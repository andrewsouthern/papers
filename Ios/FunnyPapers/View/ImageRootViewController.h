//
//  ImageRootViewController.h
//  FunnyPapers
//
//  Created by Andrew Southern on 05.20.16.
//  Copyright (c) 2016 Andrew Southern. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageRootViewController : UIViewController<UIPageViewControllerDelegate, UIPageViewControllerDataSource>{
    
    NSInteger selectedIndex;
}

@property (strong, nonatomic) NSArray *imageArray;
@property (nonatomic, strong) NSIndexPath *intIndex;
@property (nonatomic,strong) NSString *catName;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (nonatomic) NSInteger vcIndex;
@property (nonatomic, strong) NSMutableIndexSet *selectedIndexFrosted;
@property (strong, nonatomic) IBOutlet UIView *start;
@property (strong, nonatomic) IBOutlet UILabel *labelText;

@end
