//
//  CatTableViewCell.h
//  FunnyPapers
//
//  Created by Andrew Southern on 05.20.16.
//  Copyright (c) 2016 Andrew Southern. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatTableViewCell : UITableViewCell{
    
    UIImageView *catImage;
    UILabel *catLabel;
    UIImageView *backB;
}

@property (nonatomic,retain) IBOutlet UIImageView *catImage;
@property (nonatomic,retain) IBOutlet UILabel *catLabel;
@property (nonatomic,retain) IBOutlet UIImageView *backB;

@end
