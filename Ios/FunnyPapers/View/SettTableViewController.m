//
//  SettTableViewController.m
//  FunnyPapers
//
//  Created by studio76 on 21.05.15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import "SettTableViewController.h"
#import <StoreKit/StoreKit.h>



@interface SettTableViewController () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (weak, nonatomic) IBOutlet UILabel *RemoveAd;
@property (weak, nonatomic) IBOutlet UILabel *openVipAlbum;
@property (weak, nonatomic) IBOutlet UIButton *restorePurchase;
@property (weak, nonatomic) IBOutlet UILabel *chooseColor;

@end

@implementation SettTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.RemoveAd.text = NSLocalizedString(@"setting_rad", nil);
    self.openVipAlbum.text = NSLocalizedString(@"setting_vip", nil);
    self.chooseColor.text = NSLocalizedString(@"setting_color", nil);
    
    [self.restorePurchase setTitle:NSLocalizedString(@"setting_restore", nil) forState:UIControlStateNormal];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    
}


- (IBAction)restoreCompletedTransactions:(id)sender
{
    
    NSLog(@"restore");
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}




@end
