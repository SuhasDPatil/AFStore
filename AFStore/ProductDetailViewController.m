//
//  ProductDetailViewController.m
//  AFStore
//
//  Created by Suhas on 12/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController
#define TRANSFORM_CELL_VALUE CGAffineTransformMakeScale(0.8, 0.8)
#define ANIMATION_SPEED 0.2

- (void)viewDidLoad
{
    NSLog(@"View did load");
    [super viewDidLoad];

    self.title=_ProductName_title;
    
    self.lblLabPrice.text=LocalizedString(@"Product Price");
    self.lblShareOn.text=LocalizedString(@"Share On");
    [_segWarranty setTitle:LocalizedString(@"SILVER") forSegmentAtIndex:0];
    [_segWarranty setTitle:LocalizedString(@"GOLD") forSegmentAtIndex:1];
    [_segWarranty setTitle:LocalizedString(@"DIAMOND") forSegmentAtIndex:2];

    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    self.collectionView.tag=111;
    isfirstTimeTransform = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductImageViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.tableViewDet registerNib:[UINib nibWithNibName:@"ProductDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];

    self.segWarranty.selectedSegmentIndex=0;
    NSString * proPrice=[NSString stringWithFormat:@"$%@",_silver_Price];
    self.lblProductCost.text=proPrice;
    [self getProductImagesWebService];
    [self getProductDetailsWebService];
    
    _scrollview.contentSize=CGSizeMake(320, 800);
    
    self.navigationController.navigationBarHidden=NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setNavBar];
    
}
-(BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark TableView Delegate and Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 18;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
        if (indexPath.row==0)
        {
            cell.lblHeader.hidden=NO;
            cell.lblLabel.hidden=YES;
            cell.lblSpec.hidden=YES;
            cell.lblHeader.text=LocalizedString(@"PRODUCT DETAILS");
            cell.backgroundColor=[UIColor colorWithRed:212.0f/255.0f green:212.0f/255.0f blue:212.0f/255.0f alpha:1.0 ];
        }
        else if (indexPath.row==1)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblLabel.text=LocalizedString(@"Brand Model");
            cell.lblSpec.text=_BrandModel;
            cell.lblHeader.hidden=YES;
            cell.backgroundColor=[UIColor whiteColor];
        }
        else if (indexPath.row==2)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"Color");
            cell.lblSpec.text=_ColorName;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==3)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"Memory");
            cell.lblSpec.text=_Memory;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==4)
        {
            cell.lblHeader.hidden=NO;
            cell.lblLabel.hidden=YES;
            cell.lblSpec.hidden=YES;
            cell.lblHeader.text=LocalizedString(@"PRODUCT SPECIFICATION");
            cell.backgroundColor=[UIColor colorWithRed:212.0f/255.0f green:212.0f/255.0f blue:212.0f/255.0f alpha:1.0 ];

        }

        else if (indexPath.row==5)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"Battery");
            cell.lblSpec.text=_Battery;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==6)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"Bluetooth");
            cell.lblSpec.text=_Bluetooth;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==7)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"Brand Name");
            cell.lblSpec.text=_BrandName;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==8)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"FM Radio");
            cell.lblSpec.text=_FM_Radio;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==9)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"GPS");
            cell.lblSpec.text=_GPS;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==10)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"Multitouch");
            cell.lblSpec.text=_Multitouch;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==11)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"Operating System");
            cell.lblSpec.text=_OperatingSystem;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==12)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"Primary Camera");
            cell.lblSpec.text=_PrimaryCamera;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==13)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"Processor");
            cell.lblSpec.text=_Processor;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==14)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"RAM");
            cell.lblSpec.text=_Ram;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==15)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"Secondary Camera");
            cell.lblSpec.text=_SecondaryCamera;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==16)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"Sound");
            cell.lblSpec.text=_Sound;
            cell.backgroundColor=[UIColor whiteColor];

        }
        else if (indexPath.row==17)
        {
            cell.lblLabel.hidden=NO;
            cell.lblSpec.hidden=NO;
            cell.lblHeader.hidden=YES;
            cell.lblLabel.text=LocalizedString(@"USB");
            cell.lblSpec.text=_USB;
            cell.backgroundColor=[UIColor whiteColor];

        }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 || indexPath.row==4)
        return 32.0f;
    else
        return 48.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

#pragma mark Collection View Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ProductsImageArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductImageViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    int i=1;
    if (indexPath.row == 0 && isfirstTimeTransform)
    {
        isfirstTimeTransform = NO;
        cell.lblPhotoCount.text=[NSString stringWithFormat:@"Photo %i",i];
    }
    else
    {
        cell.transform = TRANSFORM_CELL_VALUE;
    }
    tempCellIm=[[ProductImageViewCell alloc]init];
    tempCellIm.cellDict=[ProductsImageArray objectAtIndex:indexPath.row];
    
    dispatch_async(queue, ^(){
        [cell.indicator startAnimating];
        NSString * imgURL = tempCellIm.cellDict[@"PhotoPath"];
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES_Store,imgURL];
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString * replacedStr1=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];

        NSURL * url = [NSURL URLWithString:replacedStr1];
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:imgData];
        dispatch_async( dispatch_get_main_queue() , ^(){
            cell.imgProductImage.image=image;
            [cell.indicator stopAnimating];
        });
    });
    return cell;
}

#pragma mark PRoduct Image scroll Animation

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
    float pageWidth = 200 + 15; // width + space
    
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




#pragma mark User Defined

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

    //Home Button
    UIButton *btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage3 = [UIImage imageNamed:@"home.png"]  ;
    [btnHome setBackgroundImage:rightBtnImage3 forState:UIControlStateNormal];
    [btnHome addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    btnHome.frame = CGRectMake(0, 0, 18, 17);
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithCustomView:btnHome] ;
    
    self.navigationItem.rightBarButtonItem=home;
    
}
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark Button Clicked Methods
- (IBAction)postToTweeter:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud show:YES];

    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        NSString *urlStr=[NSString stringWithFormat:@"http://store.aynalfahad.com/mobileDetail.aspx?MobileID=%@",_mobile_ID];
        [tweetSheet addURL:[NSURL URLWithString:urlStr]];

        NSURL * url = [NSURL URLWithString:_shareImageURL];
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        [tweetSheet addImage:[UIImage imageWithData:imgData]];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"\n%@\n Cost:%@\n",self.ProductName_title,self.silver_Price]];
        [hud hide:YES];
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
    }
    else
    {
        SLComposeViewController *TWITTER = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [hud hide:YES];
        [self presentViewController:TWITTER animated:YES completion:nil];
    }
}

- (IBAction)posttoFacebook:(id)sender
{
    
}

-(void)btnImageClicked:(id)sender
{
    [EXPhotoViewer showImageFrom:_imgProdImage];
}

- (IBAction)warrantyChanged:(id)sender
{
    NSString * proPrice;
    if (self.segWarranty.selectedSegmentIndex==0)
    {
        proPrice=[NSString stringWithFormat:@"$%@",_silver_Price];
        self.lblProductCost.text=proPrice;
    }
    else if (self.segWarranty.selectedSegmentIndex==1)
    {
        proPrice=[NSString stringWithFormat:@"$%@",_gold_Price];
        self.lblProductCost.text=proPrice;
    }
    else if (self.segWarranty.selectedSegmentIndex==2)
    {
        proPrice=[NSString stringWithFormat:@"$%@",_diamond_Price];
        self.lblProductCost.text=proPrice;
    }
}

#pragma mark WebServices

-(void)getProductImagesWebService
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:_mobile_ID forKey:@"MobileID"];

    [[AFAppAPIClient WSsharedClient] POST:API_GET_PRODUCT_IMAGES
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         if(result)
         {
             _lblBorder1.hidden=YES;
             _lblBorder2.hidden=YES;
             _imgProdImage.hidden=YES;
             _btnImageView.hidden=YES;
             _collectionView.hidden=NO;
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             ProductsImageArray=[[NSMutableArray alloc]init];
             ProductsImageArray=[responseObject objectForKey:@"Data"];
             if(ProductsImageArray.count>0)
             {
                 NSLog(@"Category Array Count:::%ld",(unsigned long)ProductsImageArray.count);
                 int i;
                 for (i=0; i<ProductsImageArray.count; i++)
                 {
                     NSDictionary * d = [ProductsImageArray objectAtIndex:i];
                     
                     _ProductImage=[d valueForKey:@"PhotoPath"];
                     NSLog(@"Product image name : %@", _ProductImage);
                 }
             }
             else
             {
                 UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 alt1.tag=111;
                 [alt1 show];
             }
         }
         else
         {
             _lblBorder1.hidden=NO;
             _lblBorder2.hidden=NO;
             _imgProdImage.hidden=NO;
             _btnImageView.hidden=NO;
             _collectionView.hidden=YES;
             dispatch_async(queue, ^(){
                 [self.indicator startAnimating];
                 NSString * imgURL = self.photo_path;
//                 NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
//                 NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//                 NSURL * url = [NSURL URLWithString:replacedStr];
                 
                 NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES_Store,imgURL];
                 NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                 NSString * replacedStr1=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];
                 NSURL * url = [NSURL URLWithString:replacedStr1];
                 
                 NSData * imgData = [NSData dataWithContentsOfURL:url];
                 UIImage * image = [UIImage imageWithData:imgData];
                 dispatch_async( dispatch_get_main_queue() , ^(){
                     self.imgProdImage.image=image;
                     [self.indicator stopAnimating];
                 });
             });
         }
         [self.collectionView reloadData];
         
         FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
         NSString *urlString=[NSString stringWithFormat:@"http://store.aynalfahad.com/mobileDetail.aspx?MobileID=%@",_mobile_ID];
         NSLog(@"Shre Link :%@",urlString);
         content.contentURL = [NSURL URLWithString:urlString];
         
         content.contentTitle=[NSString stringWithFormat:@"%@\n",_ProductName_title];
         content.contentDescription=[NSString stringWithFormat:@"\nPrice: $%@  ",_silver_Price];
         NSDictionary * dict=[ProductsImageArray objectAtIndex:0];
         NSString * imgURL = [dict valueForKey:@"PhotoPath"];
         NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES_Store,imgURL];
         NSLog(@"Image URL====%@",combined);
         NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
         _shareImageURL=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];
         content.imageURL=[NSURL URLWithString:_shareImageURL];
         NSLog(@"%@",content);
         FBSDKShareButton *Sharebutton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(0, 465, 150, 35)];
         Sharebutton.shareContent = content;
         [Sharebutton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
         [Sharebutton setBackgroundColor:[UIColor clearColor]];
         [Sharebutton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
         [Sharebutton setTintColor:[UIColor clearColor]];
         [self.view addSubview:Sharebutton];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alt1.tag=111;
         [alt1 show];
         
     }];
}

-(void)getProductDetailsWebService
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:_mobile_ID forKey:@"MobileID"];
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_PRODUCT_DETAILS_BY_ID
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             ProductDetailArray=[[NSMutableArray alloc]init];
             ProductDetailArray=[responseObject objectForKey:@"Data"];
             if(ProductDetailArray.count>0)
             {
                 int i;
                 NSArray *d;
                 
                 for (i=0; i<ProductDetailArray.count; i++)
                 {
                     d = [ProductDetailArray objectAtIndex:i];
                     
                     _Battery=[d valueForKey:@"Battery"];
                     _Bluetooth=[d valueForKey:@"Bluetooth"];
                     _BrandModel=[d valueForKey:@"BrandModel"];
                     _BrandName=[d valueForKey:@"BrandName"];
                     _ColorName=[d valueForKey:@"ColorName"];
                     _Condition=[d valueForKey:@"Condition"];
                     _Description=[d valueForKey:@"Description"];
                     _DisplaySize=[d valueForKey:@"DisplaySize"];
                     _DisplayType=[d valueForKey:@"DisplayType"];
                     _FM_Radio=[d valueForKey:@"FM_Radio"];
                     _GPS=[d valueForKey:@"GPS"];
                     _Memory=[d valueForKey:@"Memory"];
                     _Multitouch=[d valueForKey:@"Multitouch"];
                     _OperatingSystem=[d valueForKey:@"OperatingSystem"];
                     _Price=[d valueForKey:@"Price"];
                     _PrimaryCamera=[d valueForKey:@"PrimaryCamera"];
                     _Processor=[d valueForKey:@"Processor"];
                     _Ram=[d valueForKey:@"Ram"];
                     _SecondaryCamera=[d valueForKey:@"SecondaryCamera"];
                     _SimType=[d valueForKey:@"SimType"];
                     _Sound=[d valueForKey:@"Sound"];
                     _TouchScreen=[d valueForKey:@"TouchScreen"];
                     _USB=[d valueForKey:@"USB"];
                 }
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
         [_tableViewDet reloadData];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alt1.tag=111;
         [alt1 show];
     }];
}


#pragma mark - UIAlertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==101)
    {
        if (buttonIndex==0)
        {
            [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
    if (alertView.tag==111)
    {
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
