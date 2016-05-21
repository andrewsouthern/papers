//
//  SrattCollectionViewController.h
//  FunnyPapers
//
//  Created by Andrew Southern on 05.20.16.
//  Copyright (c) 2016 Andrew Southern. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SrattCollectionViewController : UICollectionViewController <UIViewControllerTransitioningDelegate>{
    
   
}
@property (nonatomic,strong)NSString *udidApi;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionViews;

@end
