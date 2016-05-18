//
//  ImageRootViewController.h
//  FunnyPapers
//
//  Created by studio76 on 21.05.15.
//  Copyright (c) 2015 Studio76. All rights reserved.
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
