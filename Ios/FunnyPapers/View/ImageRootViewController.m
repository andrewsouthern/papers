//
//  ImageRootViewController.m
//  FunnyPapers
//
//  Created by Andrew Southern on 05.20.16.
//  Copyright (c) 2016 Andrew Southern. All rights reserved.
//

#import "ImageRootViewController.h"
#import "PhotoViewController.h"
#import "config.h"
#import "RageIAPHelper.h"

#import "ContextMenuCell.h"
#import "YALContextMenuTableView.h"
#import "SCLAlertView.h"
#import "UIImage+Resize.h"
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

static NSString *const menuCellIdentifier = @"rotationCell";

@import GoogleMobileAds;


@interface ImageRootViewController () <GADInterstitialDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, YALContextMenuTableViewDelegate, UIDocumentInteractionControllerDelegate,MFMailComposeViewControllerDelegate>{
    
    NSUInteger *currentIndexMain;
    
}

@property(nonatomic, strong) GADInterstitial *interstitial;

@property (retain, nonatomic) GADBannerView  *bannerViewAd;
@property (retain, nonatomic) UIView  *bannerView;

@property (nonatomic, strong) YALContextMenuTableView* contextMenuTableView;

@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *menuIcons;

@property  NSUInteger *currentIndexMain;

@property (retain)UIDocumentInteractionController *documentController;

@end

@implementation ImageRootViewController
@synthesize currentIndexMain;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self initiateMenuOptions];
    
  
    self->selectedIndex = _intIndex.row;
    currentIndexMain = (NSUInteger*) _intIndex.row;
   
    
    ///rendering image
    _pageViewController.delegate = self;
    
   self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                             navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                           options:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:91.0f] forKey:UIPageViewControllerOptionInterPageSpacingKey]];
    
   
    
    PhotoViewController *imageViewController = [PhotoViewController new];
    NSDictionary *imageItem = [_imageArray objectAtIndex:selectedIndex];
    imageViewController.imageURL = [imageItem valueForKey:@"url"];
    NSUInteger currentIndex3 = selectedIndex;
    _vcIndex = currentIndex3;
    
    self.selectedIndexFrosted = [NSMutableIndexSet indexSetWithIndex:_vcIndex];
    NSArray *viewControllers = [NSArray arrayWithObject:imageViewController];
    
    
    
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:noErr
                                     completion:nil];
    
    
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.start addSubview:self.pageViewController.view];
    
    [self.pageViewController didMoveToParentViewController:self];
   
    self.title = [NSString stringWithFormat:@"%lu %@ %lu",(unsigned long) selectedIndex+1, NSLocalizedString(@"of", @"/") , (unsigned long)_imageArray.count];
    
    self.interstitial.delegate = self;
  // [self createAndLoadInterstitial];
    return;
//    if ([bannerOrFull isEqualToString:@"YES"]) {
//        
//        
//        
//        self.bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
//        _bannerView.backgroundColor = [UIColor redColor];
//        self.bannerViewAd = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
//        self.bannerViewAd.rootViewController = self;
//        self.bannerViewAd.adUnitID = googleAdBannerKey;
//        GADRequest *request = [GADRequest request];
//        [self.bannerViewAd loadRequest:request];
//        if ([[RageIAPHelper sharedInstance] productPurchased:deleteAd]) {
//            
//        }else{
//            
//            [self.view addSubview:_bannerViewAd];
//            
//        }
//    } else{
//        
//        if ([[RageIAPHelper sharedInstance] productPurchased:deleteAd]) {
//            
//        }else{
//            
//            [self createAndLoadInterstitial];
//            
//        }
//        
    }
    
    
    
//}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    if(completed){
        
        PhotoViewController *enlarge =[self.pageViewController.viewControllers lastObject];
        currentIndexMain = (NSUInteger*) [[_imageArray valueForKey:@"url"] indexOfObject:enlarge.imageURL];
        NSLog(@"ZZZ -%lu",(unsigned long)currentIndexMain);
        
        self.title = [NSString stringWithFormat:@"%lu %@ %lu",(unsigned long) currentIndexMain+1, NSLocalizedString(@"of", @"/") , (unsigned long)_imageArray.count];
        
    }
    
}


- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    NSLog(@"BACK - LIST");
    
    PhotoViewController *contentVc1 = (PhotoViewController *)viewController;
    
    NSUInteger currentIndex = [[_imageArray valueForKey:@"url"] indexOfObject:contentVc1.imageURL];
    _vcIndex = currentIndex;
    
  
    if (currentIndex==0)
    {
        return nil;
    }
    
    
    
    PhotoViewController *imageViewController = [PhotoViewController new];
    NSDictionary *imageItem = [_imageArray objectAtIndex:currentIndex-1];
    imageViewController.imageURL = [imageItem valueForKey:@"url"];
    
   
   
    
    return imageViewController;
    
   
    
    
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(UIViewController *)viewController
{
    
   NSLog(@"FORVARD - LIST");
    
    
    PhotoViewController *contentVc = (PhotoViewController *)viewController;
    
   
    
    
    NSUInteger currentIndex5 = [[_imageArray valueForKey:@"url"] indexOfObject:contentVc.imageURL];
    _vcIndex = currentIndex5;
    
    
  
  //  self.title = [NSString stringWithFormat:@"%lu %@ %lu", (unsigned long)currentIndex5+1, NSLocalizedString(@"of", @"/") , (unsigned long)_imageArray.count];
    if (currentIndex5 ==_imageArray.count - 1)
    {
        return nil;
    }
    
    
    
    PhotoViewController *imageViewController = [PhotoViewController new];
    NSDictionary *imageItem = [_imageArray objectAtIndex:currentIndex5+1];
    imageViewController.imageURL = [imageItem valueForKey:@"url"];
    
  
   
    return imageViewController;
    
}

- (IBAction)shareButton:(id)sender {
    
    
    NSString *message = SHARETEXT;
    
    NSDictionary *imageItem = [_imageArray objectAtIndex:_vcIndex];
    
    NSString *key = [[imageItem valueForKey:@"url"] MD5Hash];
    NSData *data = [Cache objectForKey:key];
    
    UIImage *image = [UIImage imageWithData:data];
    
    NSArray *postItems = @[message, image];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:postItems
                                            applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
    

}

- (void)createAndLoadInterstitial {
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-6797096502373603/9238979372"];
  
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
   
   
    [self.interstitial loadRequest:request];
 
 if ([self.interstitial isReady]) {
 [self.interstitial presentFromRootViewController:self];
 }
    [self.interstitial presentFromRootViewController:self];
}

#pragma mark UIAlertViewDelegate implementation

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
   // [self startNewGame];
}

#pragma mark GADInterstitialDelegate implementation



- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"interstitialDidDismissScreen");
  // [self startNewGame];
    
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    [self.interstitial presentFromRootViewController:self];
}

/////// menu



- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    //should be called after rotation animation completed
    [self.contextMenuTableView reloadData];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.contextMenuTableView updateAlongsideRotation];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //should be called after rotation animation completed
        [self.contextMenuTableView reloadData];
    }];
    [self.contextMenuTableView updateAlongsideRotation];
    
}

#pragma mark - IBAction

- (IBAction)presentMenuButtonTapped:(UIBarButtonItem *)sender {
    // init YALContextMenuTableView tableView
    if (!self.contextMenuTableView) {
        self.contextMenuTableView = [[YALContextMenuTableView alloc]initWithTableViewDelegateDataSource:self];
        self.contextMenuTableView.animationDuration = 0.15;
        //optional - implement custom YALContextMenuTableView custom protocol
        self.contextMenuTableView.yalDelegate = self;
        
        //register nib
        UINib *cellNib = [UINib nibWithNibName:@"ContextMenuCell" bundle:nil];
        [self.contextMenuTableView registerNib:cellNib forCellReuseIdentifier:menuCellIdentifier];
    }
    
    // it is better to use this method only for proper animation
    [self.contextMenuTableView showInView:self.navigationController.view withEdgeInsets:UIEdgeInsetsZero animated:YES];
}

#pragma mark - Local methods

- (void)initiateMenuOptions {
    self.menuTitles = @[@"",
//                        @"Share  in WhatsApp",
                        @"Share on Twitter",
                        @"Share on facebook",
                        @"Save image",
                        @"Close"];
    
    self.menuIcons = @[[UIImage imageNamed:@"close"],
//                       [UIImage imageNamed:@"whatsapp"],
                       [UIImage imageNamed:@"twitter"],
                       [UIImage imageNamed:@"fb"],
                       [UIImage imageNamed:@"save"],
                       [UIImage imageNamed:@"close"]];
}


#pragma mark - YALContextMenuTableViewDelegate

- (void)contextMenuTableView:(YALContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Menu dismissed with indexpath = %ld", (long)indexPath.row);
    
    if (indexPath.row == 0) {
        
    }
    if (indexPath.row == 1) {
        
        [self shareImageOnTwitter];
        
    }
    if (indexPath.row == 2) {
        
        [self shareFb];
        
    }
    if (indexPath.row == 3) {
        
        [self saveImageInRoll];
        
    }
//    if (indexPath.row == 4) {
//        
//         [self saveImageInRoll];
//    }
    
    
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)tableView:(YALContextMenuTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView dismisWithIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(YALContextMenuTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContextMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
    
    if (cell) {
        cell.backgroundColor = [UIColor clearColor];
        cell.menuTitleLabel.text = [self.menuTitles objectAtIndex:indexPath.row];
        cell.menuImageView.image = [self.menuIcons objectAtIndex:indexPath.row];
    }
    
    return cell;
}

//// share & save

-(void) saveImageInRoll{
    
    NSDictionary *imageItem = [_imageArray objectAtIndex:(NSUInteger)currentIndexMain];
    
    NSString *key = [[imageItem valueForKey:@"url"] MD5Hash];
    NSData *data = [Cache objectForKey:key];
    
    UIImage *image = [UIImage imageWithData:data];
    
     UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    //[alert addButton:@"Buy access" actionBlock:^(void) {
    //    NSLog(@"Second button tapped");
       
        
        
   // }];
    [alert showSuccess:self title:@"Saved" subTitle:@"The image is now saved to your camera roll. Set your wallpaper and lockscreen from your camera roll :)" closeButtonTitle:@"Cool!" duration:0.0f];
}

/// share Twitter

-(void)shareImageOnTwitter{
    
    
    SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"Check out some sweet artwork by @andrewsouthern here %@", Url_My_App]];
    
    
    NSDictionary *imageItem = [_imageArray objectAtIndex:(NSUInteger)currentIndexMain];
    
    NSString *key = [[imageItem valueForKey:@"url"] MD5Hash];
    NSData *data = [Cache objectForKey:key];
    
    UIImage *image = [UIImage imageWithData:data];
    
    [mySLComposerSheet addImage:image];
    
    
    [self presentViewController:mySLComposerSheet animated:YES completion:^{
        
    }];
    
}

-(void) shareFb{
    
    
    SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"Check out Andrew Southern's wallpaper app here %@", Url_My_App]];
    
    
    NSDictionary *imageItem = [_imageArray objectAtIndex:(NSUInteger)currentIndexMain];
    
    NSString *key = [[imageItem valueForKey:@"url"] MD5Hash];
    NSData *data = [Cache objectForKey:key];
    
    UIImage *image = [UIImage imageWithData:data];
    
    [mySLComposerSheet addImage:image];
    
    
    [self presentViewController:mySLComposerSheet animated:YES completion:^{
        
    }];

}

-(void) shareWp{
    
    if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]]){
        
        
        
        NSDictionary *imageItem = [_imageArray objectAtIndex:(NSUInteger)currentIndexMain];
        
        NSString *key = [[imageItem valueForKey:@"url"] MD5Hash];
        NSData *data = [Cache objectForKey:key];
        
        UIImage *image = [UIImage imageWithData:data];

        NSString    * savePath  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.wai"];
        
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:savePath atomically:YES];
        
        _documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
        _documentController.UTI = @"net.whatsapp.image";
        _documentController.delegate = self;
        
        [_documentController presentOpenInMenuFromRect:CGRectMake(0, 0, 0, 0) inView:self.view animated: YES];
        
    }
    
    
}


@end
