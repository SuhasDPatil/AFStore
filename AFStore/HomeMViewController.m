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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=LocalizedString(@"Home");
    
    [self ImageSliderWebService];

    [self HotOfferWebService];

    [self NewsWebService];
    
    self.lblHotOffer.text=LocalizedString(@"Hot Offer");
    self.lblNews.text=LocalizedString(@"News");
    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);


    [self.tableViewNews registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [self.collViewHotOffers registerNib:[UINib nibWithNibName:@"HotOfferCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
    
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
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark UITableView View Delegate & DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NewsListArray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    tempCell=[[NewsTableViewCell alloc]init];
    
    tempCell.cellDict=[NewsListArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    cell.lblNewsTitle.text = tempCell.cellDict[@"Title"];
    
    cell.lblNewsPubDate.text=tempCell.cellDict[@"PublishDate"];
    
    NSNumber * noOfVi=tempCell.cellDict[@"NumberOfViews"];
    cell.lblNewsSummery.text=[NSString stringWithFormat:@"Number of Views: %@",noOfVi];
    dispatch_async(queue, ^(){
        
        NSString * imgURL = tempCell.cellDict[@"ArticleImage"];
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        UIImage * image = [UIImage imageWithData:imgData];
        
        dispatch_async( dispatch_get_main_queue() , ^(){
            
            cell.imgNewsImage.image=image;
            
        });
        
    });
    return cell;

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailNewsViewController *detNews = [[DetailNewsViewController alloc] initWithNibName:@"DetailNewsViewController" bundle:nil];
    
    tempCell.cellDict=[NewsListArray objectAtIndex:indexPath.row];
    
    detNews.newsTitle=tempCell.cellDict[@"Title"];
    detNews.newsPubDate=tempCell.cellDict[@"PublishDate"];
    detNews.newssummery=tempCell.cellDict[@"Summary"];
    detNews.newsExpDate=tempCell.cellDict[@"ExpireDate"];
    detNews.newsImage=tempCell.cellDict[@"ArticleImage"];
    detNews.newsArticleID=tempCell.cellDict[@"ArticleID"];
    
    NSLog(@"%@",detNews.newsTitle);
    NSLog(@"%@",detNews.newssummery);
    
    [self.navigationController pushViewController:detNews animated:YES];

}

#pragma mark UICollection View Delegate & DataSource
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

    HotOfferCollectionViewCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    tempCellHot=[[HotOfferCollectionViewCell alloc]init];
        
    tempCellHot.cellDictHot=[HotOfferListArray objectAtIndex:indexPath.row];
        
        // Configure the cell...
        
    cell1.lbltitleHotOffer.text = tempCellHot.cellDictHot[@"GalleryName"];
        
    dispatch_async(queue, ^(){
            
    NSString * imgURL = tempCellHot.cellDictHot[@"Image"];
            
    NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
            
    NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            
    NSURL * url = [NSURL URLWithString:replacedStr];
            
    NSData * imgData = [NSData dataWithContentsOfURL:url];
            
    UIImage * image = [UIImage imageWithData:imgData];
            
        dispatch_async( dispatch_get_main_queue() , ^(){
                
        cell1.imgHotOffer.image=image;
                
        });
    });
    return cell1;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotOfferViewController *hovc = [[HotOfferViewController alloc]initWithNibName:@"HotOfferViewController" bundle:nil];
        
    // Pass the selected object to the new view controller.
    tempCell.cellDict=[HotOfferListArray objectAtIndex:indexPath.row];
    
    hovc.GalleryID=tempCell.cellDict[@"GalleryID"];
    hovc.GalleryName=tempCell.cellDict[@"GalleryName"];
    
    [self.navigationController pushViewController:hovc animated:YES];

}

-(NSString *) replaceHTMLEntitiesInString:(NSString *) htmlString {
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"ldquo;" withString:@" "];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"rdquo;" withString:@" "];
    
    return htmlString;
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
  
    
}

    

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma AOScrollViewDelegate
-(void)buttonClick:(int)vid{
    NSLog(@"%d",vid);
}



#pragma mark Webservices


-(void)ImageSliderWebService
{
    
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_SLIDING_IMAGES
                               parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         NSMutableArray * newarray=[[NSMutableArray alloc]init];

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
                     
                     
                     NSLog(@"Slide Image Name: %@", replacedStr);
                     [newarray addObject:replacedStr];
                     
                 }
                
                 NSLog(@"New Array     %@",newarray);

                 
                 AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:newarray titleArr:nil height:105];
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
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alt1.tag=111;
         [alt1 show];
     }];
    
}








// News Webservice

-(void)NewsWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_NEWS_ALL
                               parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             NewsListArray=[[NSMutableArray alloc]init];
             NewsListArray=[responseObject objectForKey:@"Data"];
             if(NewsListArray.count>0)
             {
                 NSLog(@"News Array Count:::%ld",(unsigned long)NewsListArray.count);
                 int i;
                 for (i=0; i<NewsListArray.count; i++)
                 {
                     NSDictionary * d = [NewsListArray objectAtIndex:i];
                     
                     _NewsTitle=[d valueForKey:@"Title"];
                     _PublishDate=[d valueForKey:@"PublishDate"];
                     _ExpireDate=[d valueForKey:@"ExpireDate"];
                     _ArticleImage=[d valueForKey:@"ArticleImage"];
                     _Summary=[d valueForKey:@"Summary"];
                     
                     NSLog(@"News Title: %@", _NewsTitle);
                     NSLog(@"News Image: %@", _ArticleImage);
                     
                     NSLog(@"pub date: %@",_PublishDate);
                     NSLog(@"exp date: %@", _ExpireDate);
                 }
                 
             }
             else
             {
                 UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"**SORRY**" message:@"News Not Available!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 
                 
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
         
         [self.tableViewNews reloadData];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alt1.tag=111;
         [alt1 show];
         
     }];
    
}







//Hot Offer

-(void)HotOfferWebService
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:@"3" forKey:@"CategoriesID"];
    NSLog(@"Request Dictionary: %@",dict);

    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_HOT_OFFER_CATEGORY_LIST
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             HotOfferListArray=[[NSMutableArray alloc]init];
             HotOfferListArray=[responseObject objectForKey:@"Data"];
             if(HotOfferListArray.count>0)
             {
                 NSLog(@"Hot Offer Array Count:::%ld",(unsigned long)HotOfferListArray.count);
                 int i;
                 for (i=0; i<HotOfferListArray.count; i++)
                 {
                     NSDictionary * d = [HotOfferListArray objectAtIndex:i];
                     
                     _GalleryID=[d valueForKey:@"GalleryID"];
                     _GalleryName=[d valueForKey:@"GalleryName"];
                     _NumberOfViews=[d valueForKey:@"NumberOfViews"];
                     _PortalID=[d valueForKey:@"PortalID"];
                     _Image=[d valueForKey:@"Image"];
                     
                     NSLog(@"Gallery ID: %@", _GalleryID);
                     NSLog(@"Gallery Name: %@", _GalleryName);
                     NSLog(@"Image: %@",_Image);
                     NSLog(@"No. of views: %@",_NumberOfViews);
                     
                 }
                 
             }
             else
             {
                 UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"**SORRY**" message:@"Hot Offers Not Available!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 
                 
                 [alt show];
                 [self.navigationController popViewControllerAnimated:YES];
             }
             [hud hide:YES];

         }
         else
         {
             
             
             UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             alt1.tag=111;
             [alt1 show];
             
         }
         
         [self.collViewHotOffers reloadData];
         
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
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}




@end
