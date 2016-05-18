//
//  CatTableViewCell.m
//  FunnyPapers
//
//  Created by studio76 on 08.05.15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import "CatTableViewCell.h"

@implementation CatTableViewCell
@synthesize catImage,catLabel,backB;

- (void)awakeFromNib {
    // Initialization code
    
   // catLabel.transform  = CGAffineTransformMakeRotation(15 * M_PI / 180.0);
   // catLabel.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
