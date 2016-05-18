//
//  ImageScrollView.h
//  Wallpaperz
//
//  Created by CODERLAB on 17.05.14.
//  Copyright (c) 2014 studio76. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ImageScrollView : UIScrollView

@property (strong, nonatomic) UIImageView *zoomView;
- (void)displayImage:(UIImage *)image;


@end

