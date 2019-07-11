//
//  postCell.h
//  instagram
//
//  Created by arleneigwe on 7/10/19.
//  Copyright © 2019 arleneigwe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface postCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UITextView *postText;

@end

NS_ASSUME_NONNULL_END
