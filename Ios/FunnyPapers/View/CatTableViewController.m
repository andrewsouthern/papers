//
//  CatTableViewController.m
//  FunnyPapers
//
//  Created by studio76 on 07.05.15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import "CatTableViewController.h"
#import "CatTableViewCell.h"
#import "ThumbnailCache.h"
#import "NSString+MD5.h"
#import "SrattCollectionViewController.h"
#import "UIColor+PXExtentions.h"
#import "config.h"
@interface CatTableViewController (){
    
    NSArray *dataArray;
    NSArray *dataAlbum;
    NSDictionary *dataDictonary;
    
    
}

@property (nonatomic) UIButton *presentControllerButton;

@end

@implementation CatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
  
    [self loadData];
    
}

-(void)loadData{
    
    NSURL *mainUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PointParseUrl,pointParseCategory ]];
    NSData* data = [NSData dataWithContentsOfURL: mainUrl];
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    
    dataArray = [json objectForKey:@"allcat"];
    
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self->dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    CatTableViewCell *cell = (CatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CatTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *story = [dataArray objectAtIndex:indexPath.row];
    
   // NSLog(@"STORY %@",story);
    
    NSArray *colors = @[@"#D24D57",@"#F22613",@"#D91E18",@"#96281B",@"#DB0A5B",@"#663399",@"#446CB3",@"#59ABE3",@"#336E7B",@"#22313F",@"#3A539B",@"#34495E",@"#67809F",@"#1F3A93",@"#4B77BE",@"#26A65B",@"#68C3A3",@"#EB9532",@"#E67E22",@"#6C7A89",@"#ABB7B7",@"#BFBFBF"];
    int r = arc4random_uniform(20);
    NSString *colorz = [colors objectAtIndex:r];
    UIColor *mycolor = [UIColor pxColorWithHexValue:colorz];
    cell.backB.backgroundColor = mycolor;
    
     cell.catLabel.text = [story objectForKey:@"name"];
    
    //get 1 image
    
   
    
    NSString *api2 = [NSString stringWithFormat:@"%@%@",PointParseUrl,pointParseAlbumFeed];
    
    
    NSURL *mainUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",api2,[story objectForKey:@"uuid"]]];
    NSData* data = [NSData dataWithContentsOfURL: mainUrl];
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    
    dataAlbum = [json objectForKey:@"images"];


//    NSDictionary *storyz = [dataAlbum objectAtIndex:indexPath.row];
//    
//    NSString *key = [[storyz objectForKey:@"url"] MD5Hash];
//    NSData *data2 = [ThumbnailCache objectForKey:key];
//    if (data2) {
//        UIImage *image = [UIImage imageWithData:data2];
//        cell.catImage.image = image;
//    } else {
//        cell.catImage.image = [UIImage imageNamed:@"ph"];
//        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
//        dispatch_async(queue, ^{
//            NSData *data3 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[storyz objectForKey:@"url"]]];
//            [ThumbnailCache setObject:data3 forKey:key];
//            UIImage *image = [UIImage imageWithData:data3];
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                cell.catImage.image = image;
//            });
//        });
//    }
    
    
    return cell;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
      
    NSLog(@"Test");
    
   
    
    
    NSDictionary *uud = [dataArray objectAtIndex:indexPath.row];
    NSString *uudid = [uud objectForKey:@"uuid"];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:uudid forKey:@"api"];
    [user synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
        
    
}
@end
