//
//  RageIAPHelper.m
//  In App Purchase Test
//
//  Created by Swapnil Godambe on 16/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "RageIAPHelper.h"
#import "config.h"

@implementation RageIAPHelper

+ (RageIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static RageIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        
        
        NSSet * productIdentifiers = [NSSet setWithObjects:
//                                      deleteAd,
//                                      buyAlbum,
                                      
                                      nil];
        
        
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
