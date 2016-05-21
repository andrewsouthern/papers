//
//  YALSideMenuCell.m
//  YALMenuAnimation
//
//  Created by Andrew Southern on 05.20.16.
//  Copyright (c) 2016 Andrew Southern. All rights reserved.
//

#import "ContextMenuCell.h"

@interface ContextMenuCell ()

@end

@implementation ContextMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layer.masksToBounds = YES;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowColor = [[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1] CGColor];
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - YALContextMenuCell

- (UIView*)animatedIcon {
    return self.menuImageView;
}

- (UIView *)animatedContent {
    return self.menuTitleLabel;
}

@end
