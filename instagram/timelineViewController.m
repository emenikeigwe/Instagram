//
//  timelineViewController.m
//  instagram
//
//  Created by arleneigwe on 7/8/19.
//  Copyright © 2019 arleneigwe. All rights reserved.
//

#import "timelineViewController.h"
#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "postCell.h"
#import "Post.h"

@protocol UITableViewDataSourceDelegate
@end
@interface timelineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<Post*> *posts;
@end

@implementation timelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(fetchPosts:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    //reveals posts
    [self viewPosts];

}

//brings user back to log-in page upon clicking logout button
- (IBAction)logoutButton:(UIBarButtonItem *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    timelineViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"login View Controller"];
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        if (!error){
            appDelegate.window.rootViewController = loginViewController;
        }
    }];
}

- (void)viewPosts{
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.posts = posts;
            [self.tableView reloadData];
        }
        else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error"
                                                                           message:@"Check connection and try again"
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            // create a cancel action
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     // handle cancel response here. Doing nothing will dismiss the view.
                                                                 }];
            // add the cancel action to the alertController
            [alert addAction:cancelAction];
            
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                                 //[self fetchMovies];
                                                             }];
            // add the OK action to the alert controller
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:^{
                // what happens after the alert controller has finished presenting
                //trys to retrieve posts again upon error
                [self viewPosts];
            }];
        }
    }];
}

// Fetches post data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)fetchPosts:(UIRefreshControl *)refreshControl {
    //actually refresh the data
    [refreshControl endRefreshing];
    [self.tableView reloadData];
}
   
//user presses the camera button to make a new post
- (IBAction)newPost:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"composeSegue" sender:nil];
}

//next two methods are vv important for data sources
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    postCell *cell =  [tableView dequeueReusableCellWithIdentifier: @"postCell"];
    
    
    Post *post = self.posts[indexPath.row];
    
    //set profile name
    cell.profileNameLabel.text = post.author.username;
    
    //*set profile image <to-do>*
    //cell.profileImage = post.author;
    
    //set post image
    PFFileObject *post_image = post.image;
    [post_image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        cell.postImage.image = [UIImage imageWithData:data];
    }];
    
    //set post text
    cell.postText.text = post.caption;
    
    //cell.posterView.image = nil;
    //[cell.posterView setImageWithURL: posterURL];
    
    return cell;
}

@end
