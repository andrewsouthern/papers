//
//  PhotoViewController.m
//  Wallpaperz
//
//  Created by CODERLAB on 17.05.14.
//  Copyright (c) 2014 studio76. All rights reserved.
//

#import "PhotoViewController.h"
#import "LoadingHUD.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _scroller = [ImageScrollView new];
    _scroller.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.view = _scroller;
    
    [_scroller.zoomView removeFromSuperview];
    _scroller.zoomView = nil;
    _scroller.zoomScale = 0.0;
    
    [self loadImageFromURL:_imageURL];
    
    
}


- (void) viewWillDisappear:(BOOL)animated{
}

- (void) viewWillAppear {
    
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
}

- (void) loadImageFromURL:(NSString*)URL {
	NSURL *imageURL = [NSURL URLWithString:URL];
	NSString *key = [URL MD5Hash];
    
	NSData *data = [Cache objectForKey:key];
    
	if (data) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        _image = [UIImage imageWithData:data];
        _scroller.zoomView = [[UIImageView alloc] initWithImage:_image];
        [_scroller displayImage:_image];
        [_scroller addSubview:_scroller.zoomView];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	} else {
        
        [[LoadingHUD loadingHUD] showInView:self.view];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
		dispatch_async(queue, ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
			[Cache setObject:data forKey:key];
			_image = [UIImage imageWithData:data];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            dispatch_sync(dispatch_get_main_queue(), ^{
				_scroller.zoomView = [[UIImageView alloc] initWithImage:_image];
                [_scroller displayImage:_image];
                [_scroller addSubview:_scroller.zoomView];
            });
            [[LoadingHUD loadingHUD] hideActivityIndicator];
            
        });
        
	}
    
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskAllButUpsideDown);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
