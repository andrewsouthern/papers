//
//  YALSideMenuCell.h
//  YALMenuAnimation
//
//  Created by Andrew Southern on 05.20.16.
//  Copyright (c) 2016 Andrew Southern. All rights reserved.
//


@import UIKit;

#import "YALContextMenuCell.h"

@interface ContextMenuCell : UITableViewCell <YALContextMenuCell>

@property (strong, nonatomic) IBOutlet UIImageView *menuImageView;
@property (strong, nonatomic) IBOutlet UILabel *menuTitleLabel;

@end
