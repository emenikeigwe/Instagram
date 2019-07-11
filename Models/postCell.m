//
//  postCell.m
//  instagram
//
//  Created by arleneigwe on 7/10/19.
//  Copyright © 2019 arleneigwe. All rights reserved.
//

#import "postCell.h"

@implementation postCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    self.profileImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
