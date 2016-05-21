//
//  ImageScrollView.h
//  Wallpaperz
//
//  Created by Andrew Southern on 05.20.16.
//  Copyright (c) 2016 Andrew Southern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ImageScrollView : UIScrollView

@property (strong, nonatomic) UIImageView *zoomView;
- (void)displayImage:(UIImage *)image;


@end

