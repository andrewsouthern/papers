//
//  CatTableViewCell.h
//  FunnyPapers
//
//  Created by studio76 on 08.05.15.
//  Copyright (c) 2015 Studio76. All rights reserved.
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
