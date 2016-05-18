//
//  S76MaterialTransition.h
//  Example
//
//  Created by studio76 on 06.05.15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface S76MaterialTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (weak, nonatomic) UIView *animatedView;

@property (nonatomic) CGRect startFrame;
@property (nonatomic) UIColor *startBackgroundColor;

@property (getter=isReverse) BOOL reverse;

- (instancetype)initWithAnimatedView:(UIView *)animatedView;

@end
