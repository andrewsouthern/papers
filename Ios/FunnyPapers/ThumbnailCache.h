//
//  ThumbnailCache.h
//  Wallpaperz
//
//  Created by CODERLAB on 17.05.14.
//  Copyright (c) 2014 studio76. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThumbnailCache : NSObject

+ (void) removeCache;
+ (void) setObject:(NSData*)data forKey:(NSString*)key;
+ (id) objectForKey:(NSString*)key;

@end
