//
//  loginViewController.m
//  instagram
//
//  Created by arleneigwe on 7/8/19.
//  Copyright © 2019 arleneigwe. All rights reserved.
//

#import "loginViewController.h"
#import "Parse/Parse.h"

@interface loginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField2;
@property (weak, nonatomic) IBOutlet UITextField *passwordField2;

@end

@implementation loginViewController
- (IBAction)logButtonTapped:(UIButton *)sender {
    [self loginUser];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//needs to be moved to login view controller
- (void)loginUser {
    NSString *username = self.usernameField2.text;
    NSString *password = self.passwordField2.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
