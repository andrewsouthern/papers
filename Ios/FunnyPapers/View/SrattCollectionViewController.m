//
//  SrattCollectionViewController.m
//  FunnyPapers
//
//  Created by Andrew Southern on 05.20.16.
//  Copyright (c) 2016 Andrew Southern. All rights reserved.
//

#import "SrattCollectionViewController.h"
#import "CollectionViewCell.h"
#import "ThumbnailCache.h"
#import "NSString+MD5.h"
#import "S76MaterialTransition.h"
#import "CatTableViewController.h"
#include "ContainerViewController.h"
#import "ImageRootViewController.h"
#import "config.h"
#import "RageIAPHelper.h"
#import "SCLAlertView.h"
#import "InappTableViewController.h"
#import "UIColor+PXExtentions.h"



@import GoogleMobileAds;


static NSString *const menuCellIdentifier = @"rotationCell";

@interface SrattCollectionViewController ()<GADInterstitialDelegate>{
    
    NSArray *dataArray;
    NSArray *dataArrayPay;
    NSDictionary *dataDictonary;
    NSString *payAlbum;
    NSString *payAlbumOut;
    NSString *nameAlbums;
   
}
@property (nonatomic) S76MaterialTransition *transition;
@property (nonatomic) UIButton *presentControllerButton;
@property (retain, nonatomic) GADBannerView  *bannerViewAd;
@property (retain, nonatomic) UIView  *bannerView;
@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation SrattCollectionViewController
@synthesize bannerViewAd,bannerView;


static NSString * const reuseIdentifier = @"Cell";



- (void)viewDidLoad {
    [super viewDidLoad];
   
    
   self.title = @"Funny Papers";
  
    
 
    
    
    
    

    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
   // [[UINavigationBar appearance] setTintColor:[UIColor pxColorWithHexValue:colorApp]];
    self.navigationController.navigationBar.barTintColor = [UIColor pxColorWithHexValue:colorApp];
    self.collectionViews.backgroundColor = [UIColor pxColorWithHexValue:colorApp];
    
    
    CGFloat width = 50;
    
    _presentControllerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_presentControllerButton addTarget:self
               action:@selector(didPresentControllerButtonTouch)
     forControlEvents:UIControlEventTouchUpInside];
    
    [_presentControllerButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    _presentControllerButton.frame = CGRectMake(self.view.frame.size.width/2.0-25, self.view.frame.size.height - 40, 50.0, 50.0);
    self.presentControllerButton.backgroundColor = [UIColor pxColorWithHexValue:colorApp];
    self.presentControllerButton.layer.cornerRadius = width / 2.;
    [self.view addSubview:_presentControllerButton];
    
     [self loadData];
    [self createTransition];
     self.interstitial.delegate = self;
    return;
//    if ([bannerOrFull isEqualToString:@"YES"]) {
//        
//    
//    
//     self.bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
//     bannerView.backgroundColor = [UIColor redColor];
//     self.bannerViewAd = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
//     self.bannerViewAd.rootViewController = self;
//     self.bannerViewAd.adUnitID = googleAdBannerKey;
//     GADRequest *request = [GADRequest request];
//     [self.bannerViewAd loadRequest:request];
//               if ([[RageIAPHelper sharedInstance] productPurchased:deleteAd]) {
//        
//               }else{
//        
//               [self.view addSubview:bannerViewAd];
//        
//               }
//    } else{
//        
//               if ([[RageIAPHelper sharedInstance] productPurchased:deleteAd]) {
//            
//               }else{
//            
//               [self createAndLoadInterstitial];
//            
//               }
//        
//       }
    
    
    
    
    
//}
//
//- (void)createAndLoadInterstitial {
//    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:googleAdFullKey];
//    
//    self.interstitial.delegate = self;
//    
//    GADRequest *request = [GADRequest request];
//    
//    
//    [self.interstitial loadRequest:request];
//    
//    if ([self.interstitial isReady]) {
//        [self.interstitial presentFromRootViewController:self];
//    }
//    [self.interstitial presentFromRootViewController:self];
}


-(void)viewWillAppear:(BOOL)animated{
    bannerViewAd.hidden = YES;
    
//    if ([[RageIAPHelper sharedInstance] productPurchased:deleteAd]) {
//        
//        bannerViewAd.hidden = YES;
//        
//    }else{
//        
//        bannerViewAd.hidden = YES;
//        
//    }
    
    NSUserDefaults *udef = [NSUserDefaults standardUserDefaults];
    NSString *colz = [udef objectForKey:@"color"];
    
    if (colz==nil) {
        colz = colorApp;
    }
    
    UIColor *acolor = [UIColor pxColorWithHexValue:colz];
    self.navigationController.navigationBar.barTintColor = acolor;
    self.collectionViews.backgroundColor = acolor;
    self.presentControllerButton.backgroundColor = acolor;
    
    
   

}

-(void)viewWillDisappear:(BOOL)animated{
    
   
}


-(void)viewDidDisappear:(BOOL)animated{
    
   
}






- (void)didPresentControllerButtonTouch
{
  
    ContainerViewController *viewController =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"categs"];
    
    
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate = self;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - Transition

- (void)createTransition
{
    self.transition = [[S76MaterialTransition alloc] initWithAnimatedView:self.presentControllerButton];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
    
    self.transition.reverse = NO;
    return self.transition;
    
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    NSLog(@"2");
    
    
    [self loadData];
    
    self.transition.reverse = YES;
    return self.transition;
    
   
    
}

-(void)loadData{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *uudid = [user objectForKey:@"api"];
   
    
    if (uudid == nil) {
        uudid = fPstartAlbum;
    }
    
    if ([uudid isEqualToString:@""]) {
        uudid = fPstartAlbum;
    }
    
    
    
   
    
    NSString *apiStr = [NSString stringWithFormat:@"%@%@%@",PointParseUrl,pointParseAlbumFeed,uudid];
   
    
    NSURL *mainUrl = [NSURL URLWithString:apiStr];
    NSData* data = [NSData dataWithContentsOfURL: mainUrl];
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    
    nameAlbums = [json objectForKey:@"name"];
    self.title = nameAlbums;
    
    
    payAlbum = [json objectForKey:@"id"];
    
    
   
   
    dataArray = [json objectForKey:@"images"];
    
   
    
    [self.collectionView reloadData];
    
   
    
    NSIndexPath *ipath =  [NSIndexPath indexPathForRow:0 inSection:0];
   
    [self.collectionView scrollToItemAtIndexPath:ipath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    [user setValue:@"" forKey:@"api"];
    [user synchronize];
    
    
    
    
}

-(void)ressivePayAlbum:(NSString*)albumId {
    

    NSString *apiStr = [NSString stringWithFormat:@"%@%@%@",PointParseUrl,pointCheckPayAlbum,albumId];
    
    NSURL *mainUrl = [NSURL URLWithString:apiStr];
    NSData* data = [NSData dataWithContentsOfURL: mainUrl];
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    
  
    NSDictionary *hf = [json objectForKey:@"pay_album"];
    payAlbumOut = [hf objectForKey:@"pay_album"];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    static NSString *CellIdentifier = @"CollectionCell";
    
    CollectionViewCell *cell =(CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    NSDictionary *story = [dataArray objectAtIndex:indexPath.row];
   
    
    NSString *key = [[story objectForKey:@"thumb"] MD5Hash];
    NSData *data = [ThumbnailCache objectForKey:key];
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
        cell.cellImage.image = image;
    } else {
        cell.cellImage.image = [UIImage imageNamed:@"ph"];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[story objectForKey:@"thumb"]]];
            [ThumbnailCache setObject:data forKey:key];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.cellImage.image = image;
            });
        });
    }
    

    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat picDimension = self.view.frame.size.width / 3.02f;
    CGFloat picDimensionH = self.view.frame.size.height / 3.0f;
    
    
    return CGSizeMake(picDimension, picDimensionH);
   
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
   
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
//    if ([identifier isEqualToString:@"imagePush"]) {
//        NSLog(@"Segue Blocked");
//        
//        [self ressivePayAlbum:payAlbum];

//         if ([payAlbumOut isEqualToString:@"0"]) {
//             
//             return YES;
//             
//         } else{
//             
//             if ([[RageIAPHelper sharedInstance] productPurchased:buyAlbum]) {
//                 
//                 return YES;
//                 
//             }else{
//                 
//                 SCLAlertView *alert = [[SCLAlertView alloc] init];
//             
//                 [alert addButton:NSLocalizedString(@"alert_button_buy", nil) actionBlock:^(void) {
//                    
//                     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                     InappTableViewController *myVC = (InappTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"apps"];
//                     [self.navigationController pushViewController:myVC animated:YES];
//                     
//                     
//                 }];
//                 [alert showWarning:self title:NSLocalizedString(@"alert_title", nil)subTitle:NSLocalizedString(@"alert_subtitle", nil)  closeButtonTitle: NSLocalizedString(@"alert_done", nil)  duration:0.0f];
//                 
//                 return NO;
//             }
//            
//            
//             
//         }
//       
//    }
    
//    return YES;
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
   
         if ([[segue identifier] isEqualToString:@"imagePush"] ) {
            
             NSIndexPath *indexPath = [[_collectionViews indexPathsForSelectedItems] objectAtIndex:0];
             ImageRootViewController *detailViewController = [segue destinationViewController];
             detailViewController.imageArray = dataArray;
             detailViewController.intIndex = indexPath;
             detailViewController.catName = nameAlbums;
           
         
         
     }
}


//- (void)interstitial:(GADInterstitial *)interstitial
//didFailToReceiveAdWithError:(GADRequestError *)error {
//    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
//}
//
//- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
//    NSLog(@"interstitialDidDismissScreen");
//    
    
//}
//
//- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
//{
//    [self.interstitial presentFromRootViewController:self];
//}
@end
