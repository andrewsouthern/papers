//
//  Cache.h
//  Wallpaperz
//
//  Created by Andrew Southern on 05.20.16.
//  Copyright (c) 2016 Andrew Southern. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cache : NSObject

+ (void) removeCache;
+ (void) setObject:(NSData*)data forKey:(NSString*)key;
+ (id) objectForKey:(NSString*)key;

@end

