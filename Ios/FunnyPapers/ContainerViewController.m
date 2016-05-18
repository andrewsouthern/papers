//
//  ContainerViewController.m
//  FunnyPapers
//
//  Created by studio76 on 07.05.15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import "ContainerViewController.h"
#import "UIColor+PXExtentions.h"
#include "config.h"

@interface ContainerViewController (){
    
    
}
@property (nonatomic) UIButton *presentControllerButton;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor pxColorWithHexValue:colorApp];
    
    [self createCloseButton];
}

- (void)createCloseButton
{
    
     CGFloat width = 50;
    _presentControllerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_presentControllerButton addTarget:self
                                 action:@selector(didCloseButtonTouch)
                       forControlEvents:UIControlEventTouchUpInside];
    
    [_presentControllerButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    _presentControllerButton.frame = CGRectMake(self.view.frame.size.width/2.0-25, self.view.frame.size.height - 60, 50.0, 50.0);
    self.presentControllerButton.backgroundColor = [UIColor pxColorWithHexValue:colorApp];
    self.presentControllerButton.layer.cornerRadius = width / 2.;
    [self.view addSubview:_presentControllerButton];
}

- (void)didCloseButtonTouch
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *udef = [NSUserDefaults standardUserDefaults];
    NSString *colz = [udef objectForKey:@"color"];
    
    if (colz==nil) {
        colz = colorApp;
    }
    
    UIColor *acolor = [UIColor pxColorWithHexValue:colz];
    self.navigationController.navigationBar.barTintColor = acolor;
    self.view.backgroundColor = acolor;
    self.presentControllerButton.backgroundColor = acolor;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
