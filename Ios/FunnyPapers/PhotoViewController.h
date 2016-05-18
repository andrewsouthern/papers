//
//  PhotoViewController.h
//  Wallpaperz
//
//  Created by CODERLAB on 17.05.14.
//  Copyright (c) 2014 studio76. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"
#import "NSString+MD5.h"
#import "Cache.h"

@interface PhotoViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic)  ImageScrollView *scroller;
@property (strong, nonatomic)  UIImage *image;
@property (strong, nonatomic)  NSString *imageURL;

- (void) loadImageFromURL:(NSString*)URL;

@end

