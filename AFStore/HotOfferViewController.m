//
//  HotOfferViewController.m
//  AFStoreNew
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "HotOfferViewController.h"

@interface HotOfferViewController ()

@end

@implementation HotOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    
    [self.collectionview registerNib:[UINib nibWithNibName:@"OfferViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    [self getHotOffersWebService];
    

    self.title=_GalleryName;
    [self setNavBar];

    // Do any additional setup after loading the view from its nib.
}


-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark User Defined


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



#pragma mark UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return HotOfferListArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    OfferViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    tempCell=[[OfferViewCell alloc]init];
    
    tempCell.cellDict=[HotOfferListArray objectAtIndex:indexPath.row];
        
    
    cell.lblNoOfViews.text=[NSString stringWithFormat:@"Number Of View: %@",tempCell.cellDict[@"NumberOfViews"]];
    
     // Configure the cell...
    dispatch_async(queue, ^(){
        
        NSString * imgURL = tempCell.cellDict[@"FileName"];
        
        NSString * strdf=@"http://www.aynalfahad.com";
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", strdf,imgURL];
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * url = [NSURL URLWithString:replacedStr];

        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        UIImage * image = [UIImage imageWithData:imgData];
        
        // It is very IMP  :::: [cell.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
        dispatch_async( dispatch_get_main_queue() , ^(){
            
            cell.imgOfferIMage.image=image;
            
        });
        
    });
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DetailHotOfferViewController *detHot = [[DetailHotOfferViewController alloc] initWithNibName:@"DetailHotOfferViewController" bundle:nil];
    
    tempCell.cellDict=[HotOfferListArray objectAtIndex:indexPath.row];
    
    detHot.offerCatTitle=_GalleryName;
    detHot.offerImage=tempCell.cellDict[@"FileName"];
    detHot.NoOfViews=tempCell.cellDict[@"NumberOfViews"];
    
    detHot.title=LocalizedString(@"Detail");
    
    
    [self.navigationController pushViewController:detHot animated:YES];

}



#pragma mark Webservices

-(void)getHotOffersWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:_GalleryID forKey:@"GalleryID"];

    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_HOT_OFFERS_BY_GALLERY_ID
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             // NSArray *list=[responseObject objectForKey:@"Data"];
             HotOfferListArray=[[NSMutableArray alloc]init];
             HotOfferListArray=[responseObject objectForKey:@"Data"];
             if(HotOfferListArray.count>0)
             {
                 int i;
                 for (i=0; i<HotOfferListArray.count; i++)
                 {
                     NSDictionary * d = [HotOfferListArray objectAtIndex:i];
                     
                     _FileName=[d valueForKey:@"FileName"];
                     _NumberOfViews=[d valueForKey:@"NumberOfViews"];
                     
                     
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
             
             UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             alt1.tag=111;
             [alt1 show];
             
             
         }
         [hud hide:YES];
         
         [self.collectionview reloadData];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alt1.tag=111;
         [alt1 show];
         
     }];
    
}

#pragma mark - UIAlertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==111) {
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


@end
