////
//  HomeMViewController.m
//  AFStore
//
//  Created by Suhas on 16/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "HomeMViewController.h"
#import "Localization.h"
@interface HomeMViewController ()


@end

@implementation HomeMViewController

#define TRANSFORM_CELL_VALUE CGAffineTransformMakeScale(0.8, 0.8)
#define ANIMATION_SPEED 0.2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=LocalizedString(@"Home");
    
    [_searchBar setPlaceholder:LocalizedString(@"Search Bar")];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BannerIKUViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

    self.lblHotDeals.text=LocalizedString(@"Hot Deals");
    self.lblAbout.text=LocalizedString(@"About Ayn Al Fahad");
    self.lblAboutUsInfo.text=LocalizedString(@"About Info");
    
    
    [self ImageSliderWebService];

    [self ImageSliderHotDealsWebService];
    
    [self BannerIKUWebService];
    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);


    _scrollView.contentSize=CGSizeMake(320, 830);
    
    
    _spinnerView.circleLayer.lineWidth = 2.0;
    
    // Change the color of the line
    _spinnerView.circleLayer.strokeColor = [UIColor orangeColor].CGColor;

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setNavBar];

    self.navigationController.navigationBarHidden=NO;

}
-(BOOL)prefersStatusBarHidden
{
    return NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setNavBar
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255.0f/255.0f green:128.0f/255.0f blue:0.0f/255.0f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    //Back Button
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"back.png"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 10, 16);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma AOScrollViewDelegate
-(void)buttonClick:(int)vid{
    NSLog(@"%d",vid);
}



#pragma mark Collection View Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return BannerImageArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BannerIKUViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    tempCellIm=[[BannerIKUViewCell alloc]init];
    tempCellIm.cellDict=[BannerImageArray objectAtIndex:indexPath.row];

    
    dispatch_async(queue, ^(){
        [cell.indicatorV startAnimating];
        NSString * imgURL = tempCellIm.cellDict[@"Img"];
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES_Store,imgURL];
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString * replacedStr1=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];
        
        NSURL * url = [NSURL URLWithString:replacedStr1];
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:imgData];
        dispatch_async( dispatch_get_main_queue() , ^(){
            cell.imgBannerImage.image=image;
            [cell.indicatorV stopAnimating];
        });
    });
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    tempCellIm.cellDict=[BannerImageArray objectAtIndex:indexPath.row];

    ProductViewController *pvc=[[ProductViewController alloc]init];
    
    pvc.BrandID=tempCellIm.cellDict[@"BrandID"];
    pvc.Brand_name=tempCellIm.cellDict[@"Brand"];
    pvc.Condition_newUsed=@"1";
    
    [self.navigationController pushViewController:pvc animated:YES];

}
#pragma mark PRoduct Image scroll Animation

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
    float pageWidth = 316 + 2; // width + space
    
    float currentOffset = scrollView.contentOffset.x;
    float targetOffset = targetContentOffset->x;
    float newTargetOffset = 0;
    
    if (targetOffset > currentOffset)
        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    else
        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
    
    if (newTargetOffset < 0)
        newTargetOffset = 0;
    else if (newTargetOffset > scrollView.contentSize.width)
        newTargetOffset = scrollView.contentSize.width;
    
    targetContentOffset->x = currentOffset;
    [scrollView setContentOffset:CGPointMake(newTargetOffset, 0) animated:YES];
    
    int index = newTargetOffset / pageWidth;
    
    if (index == 0) { // If first index
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index  inSection:0]];
        
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
        cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index + 1  inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
    }
    else{
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
        
        index --; // left
        cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
        
        index ++;
        index ++; // right
        cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
    }
}



#pragma mark Webservices
-(void)BannerIKUWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_BANNER_IKU_IMAGES
                               parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         [hud show:YES];
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             BannerImageArray=[[NSMutableArray alloc]init];
             BannerImageArray=[responseObject objectForKey:@"Data"];
             if(BannerImageArray.count>0)
             {
                 NSLog(@"Banner Array Count:::%ld",(unsigned long)BannerImageArray.count);
                 int i;
                 for (i=0; i<BannerImageArray.count; i++)
                 {
                     NSDictionary * d = [BannerImageArray objectAtIndex:i];
                     
                     _Img=[d valueForKey:@"Img"];
                     _BrandID=[d valueForKey:@"BrandID"];
                     _Brand=[d valueForKey:@"Brand"];
                     
                     NSLog(@"Img Source: %@",_Img);
                 }
             }
             else
             {
                 UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"**SORRY**" message:@"Slider Images Not Available!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alt show];
             }
         }
         else
         {
             UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             alt1.tag=111;
             [alt1 show];
         }
         [hud hide:YES];
         [_collectionView reloadData];
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alt1.tag=111;
         [alt1 show];
     }];
    
}

-(void)ImageSliderWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[AFAppAPIClient WSsharedClient] POST:API_GET_SLIDING_IMAGES
                               parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         NSMutableArray * newarray=[[NSMutableArray alloc]init];

         [hud show:YES];
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             SlidingImageArray=[[NSMutableArray alloc]init];
             SlidingImageArray=[responseObject objectForKey:@"Data"];
             if(SlidingImageArray.count>0)
             {
                 NSLog(@"Slide Image Count Count:::%ld",(unsigned long)SlidingImageArray.count);
                 int i;
                 NSArray *d;
                 
                 for (i=0; i<SlidingImageArray.count; i++)
                 {
                     d = [SlidingImageArray objectAtIndex:i];
                     
                     _imgNameSli=[d valueForKey:@"Content"];
                     
                     NSString * strAPI=@"http://aynalfahad.com";
                     NSString *combined = [NSString stringWithFormat:@"%@%@", strAPI,_imgNameSli];
                     
                     NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                     

                     [newarray addObject:replacedStr];
                 }
                 AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:newarray titleArr:nil height:105];
                 aSV.tag=100;
                 aSV.vDelegate=self;
                 [self.slideView addSubview:aSV];
             }
             else
             {
                 UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"**SORRY**" message:@"Slider Images Not Available!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alt show];
                 [self.navigationController popViewControllerAnimated:YES];
             }
         }
         else
         {
             UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             alt1.tag=111;
             [alt1 show];
         }
         [hud hide:YES];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alt1.tag=111;
         [alt1 show];
     }];
    
}

-(void)ImageSliderHotDealsWebService
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[AFAppAPIClient WSsharedClient] POST:API_GET_SLIDING_IMAGES_HOT_DEALS
                               parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         NSMutableArray * newarray=[[NSMutableArray alloc]init];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             SlidingHotDealImageArray=[[NSMutableArray alloc]init];
             SlidingHotDealImageArray=[responseObject objectForKey:@"Data"];
             if(SlidingHotDealImageArray.count>0)
             {
                 NSLog(@"Slide Image Count Count:::%ld",(unsigned long)SlidingHotDealImageArray.count);
                 int i;
                 NSArray *d;
                 
                 for (i=0; i<SlidingHotDealImageArray.count; i++)
                 {
                     d = [SlidingHotDealImageArray objectAtIndex:i];
                     
                     _FileName=[d valueForKey:@"FileName"];
                     
                     NSString * strAPI=@"http://aynalfahad.com";
                     NSString *combined = [NSString stringWithFormat:@"%@%@", strAPI,_FileName];
                     
                     NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                     
                     NSString * url = [replacedStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];

                     NSLog(@"%@",url);
                     [newarray addObject:url];
                     
                 }
                 
                 AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:newarray titleArr:nil height:220];
                 aSV.vDelegate=self;
                 [self.slideViewHotDeals addSubview:aSV];
             }
             else
             {
                 UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"**SORRY**" message:@"Hot Deals Not Available!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alt show];
             }
         }
         else
         {
             UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:@"Hot Deals Not Available!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             
             [alt1 show];
            
             [newarray addObject:[NSString stringWithFormat:@"%@%@",API_ALL_IMAGES,@"/Portals/0/fahad-logo.png"]];
             [newarray addObject:[NSString stringWithFormat:@"%@%@",API_ALL_IMAGES,@"/Portals/0/fahad-logo.png"]];

             AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:newarray titleArr:nil height:220];
             aSV.vDelegate=self;
             [self.slideViewHotDeals addSubview:aSV];

         }
        
         [hud hide:YES];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         [alt1 show];
     }];
}



#pragma mark - UIAlertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==111)
    {
        if (buttonIndex==0)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}




- (IBAction)searchClicked:(id)sender
{
    SearchViewController *svc=[[SearchViewController alloc]init];
    
    [self.navigationController pushViewController:svc animated:NO];
}

- (IBAction)IKUClicked:(id)sender
{
    
    ProductViewController *pvc=[[ProductViewController alloc]init];
    
    pvc.BrandID=@"20";
    pvc.Brand_name=@"IKU";
    pvc.Condition_newUsed=@"1";
    
    [self.navigationController pushViewController:pvc animated:YES];
    
}
@end
