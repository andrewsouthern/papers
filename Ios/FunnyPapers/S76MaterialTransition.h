//
//  S76MaterialTransition.h
//  Example
//
//  Created by Andrew Southern on 05.20.16.
//  Copyright (c) 2016 Andrew Southern. All rights reserved.
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
