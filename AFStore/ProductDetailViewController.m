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

    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    
    self.collectionView.tag=111;
    self.collectionViewDetails.tag=222;

    isfirstTimeTransform = YES;

    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductImageViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

    [self ProductDetailsWebService];

    [self getProductImagesWebService];

    NSLog(@"%@",self.subCateName);
    self.title=self.subCateName;
    self.lblProductName.text=self.productName;
    self.lblFree1.text=self.prodFree1;
    
    NSString * strDoller=@"$ ";
    
    self.lblProductCost.text=[NSString stringWithFormat:@"%@%@",strDoller,self.prodcost];
    self.imagePager.delegate=self;
    
    
    
    
    
    
    FBSDKLikeControl *button = [[FBSDKLikeControl alloc]initWithFrame:CGRectMake(10, 485, 100, 50)];
    
    button.objectID = @"https://www.aynalfahad.com/Productdetails/tabid/298/ProductID/199/";
    
    
    [self.view addSubview:button];
    
    button.likeControlStyle=FBSDKLikeControlStyleBoxCount;
    button.likeControlHorizontalAlignment=FBSDKLikeControlHorizontalAlignmentRight;
    
    
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    
    NSString *urlString=[NSString stringWithFormat:@"http://www.aynAlFahad.com/"];
    
    
    NSLog(@"Shre Link :%@",urlString);
    
    content.contentURL = [NSURL URLWithString:urlString];
    
    
    
    content.contentTitle=[NSString stringWithFormat:@"%@ : %@",_subCateName,_productName];
    
    content.contentDescription=[NSString stringWithFormat:@"\n   %@\n   Price: $%@  ",self.prodFree1,_prodcost];
    
    
    NSString * imgURL = self.prodimage;
    
    NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
    
    NSLog(@"Image URL====%@",combined);
    
    NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    content.imageURL=[NSURL URLWithString:replacedStr];
    
    
    FBSDKShareButton *Sharebutton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(220, 485, 80, 30)];
    Sharebutton.shareContent = content;
    
    [self.view addSubview:Sharebutton];
    
    

    
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
    return YES;
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _imagePager.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    _imagePager.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    _imagePager.slideshowTimeInterval = 5.5f;
    _imagePager.slideshowShouldCallScrollToDelegate = YES;
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
        NSString * imgURL = tempCellIm.cellDict[@"ProductImage"];
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        UIImage * image = [UIImage imageWithData:imgData];
        
        dispatch_async( dispatch_get_main_queue() , ^(){
            
            
            cell.imgProductImage.image=image;
            
            [cell.indicator stopAnimating];
            
        });
        
    });
    return cell;
    
}

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



#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImages:(KIImagePager*)pager
{
    productDetImgArray = [_splitString componentsSeparatedByString:@","];
    
    NSLog(@"List count:%lu",(unsigned long)[productDetImgArray count]);
    
    NSLog(@"List Array: = %@ ",productDetImgArray);
    
    return productDetImgArray;
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image inPager:(KIImagePager *)pager
{
    return UIViewContentModeScaleAspectFill;
}

- (NSString *) captionForImageAtIndex:(NSUInteger)index inPager:(KIImagePager *)pager
{
    return @[
             @"First screenshot",
             @"Another screenshot",
             @"Last one! ;-)",@"asdfg",@"Hello I am Tiger.."
             ][index];
}

#pragma mark - KIImagePager Delegate
- (void) imagePager:(KIImagePager *)imagePager didScrollToIndex:(NSUInteger)index
{
    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
}

- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
    
}





-(void)setNavBar
{
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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

    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [tweetSheet addURL:[NSURL URLWithString:@"http://www.aynAlFahad.com/"]];
        
        
        NSString * imgURL = self.prodimage;
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        NSLog(@"Image URL====%@",combined);
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        
        [tweetSheet addImage:[UIImage imageWithData:imgData]];
        
        
        [tweetSheet setInitialText:[NSString stringWithFormat:@"%@\nModel:%@\nCost:%@\nFree:%@\n%@",self.subCateName,self.productName,self.prodcost,self.prodFree1,self.ProductDetailsInfo]];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                        message:@"Twitter integration is not available.  Make sure you have setup your Twitter account on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"Settings"
                                              otherButtonTitles:@"OK", nil];
        [alert show];
        alert.tag=101;
    }
    
    
}

- (IBAction)posttoFacebook:(id)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller addURL:[NSURL URLWithString:@"http://www.aynAlFahad.com/"]];
        
    
        NSString * imgURL = self.prodimage;
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        NSLog(@"Image URL====%@",combined);
        
        NSURL * url = [NSURL URLWithString:combined];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
    
        [controller addImage:[UIImage imageWithData:imgData]];
        
        [controller setInitialText:[NSString stringWithFormat:@"Brand: %@ \nModel: %@ \n",self.subCateName,self.productName]];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook"
                                                        message:@"Facebook integration is not available.  Make sure you have setup your Facebook account on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"Settings"
                                              otherButtonTitles:@"OK", nil];
        [alert show];
        alert.tag=101;
    }
}




-(void)btnImageClicked:(id)sender
{
    [EXPhotoViewer showImageFrom:_imgProdImage];
}


#pragma mark WebServices

-(void)ProductDetailsWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:_productID forKey:@"ProductID"];
    
    NSLog(@"%@",dict);
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_PRODUCT_DETAIL
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             ProductDetailArray=[[NSMutableArray alloc]init];
             ProductDetailArray=[responseObject objectForKey:@"Data"];
             if(ProductDetailArray.count>0)
             {
                 NSLog(@"Category Array Count:::%ld",(unsigned long)ProductDetailArray.count);

                 NSDictionary * d = [ProductDetailArray objectAtIndex:0];
                 
                 _ProductDetailsInfo=[d valueForKey:@"ProductDetailsInfo"];

                 NSLog(@"Product Details Info: %@", _ProductDetailsInfo);
                 
                 _splitString=[d objectForKey:@"ProductDetailsInfo"];
                 productDetImgArray = [_splitString componentsSeparatedByString:@","];
                 
                 NSLog(@"List count:%lu",(unsigned long)[productDetImgArray count]);
                 
                 NSLog(@"List Array: = %@ ",productDetImgArray);
                 
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
             
             UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             alt1.tag=111;
             [alt1 show];
             
         }
         [hud hide:YES];
         
         [self.imagePager reloadData];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alt1.tag=111;
         [alt1 show];
         
     }];
    
}



-(void)getProductImagesWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:_productID forKey:@"ProductID"];
    
    NSLog(@"%@",dict);
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_PRODUCT_IMAGES
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
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
                     
                     _ProductImage=[d valueForKey:@"ProductImage"];
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
                 
                 NSString * imgURL = self.prodimage;
                 
                 NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
                 
                 NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                 
                 NSURL * url = [NSURL URLWithString:replacedStr];
                 
                 NSData * imgData = [NSData dataWithContentsOfURL:url];
                 
                 UIImage * image = [UIImage imageWithData:imgData];
                 
                 dispatch_async( dispatch_get_main_queue() , ^(){
                     
                     
                     self.imgProdImage.image=image;
                     
                     [self.indicator stopAnimating];
                 });
                 
             });


         }
         [hud hide:YES];
         
         [self.collectionView reloadData];
         
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

    
    if (alertView.tag==111) {
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}





@end
