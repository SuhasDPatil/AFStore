//
//  NewsViewController.m
//  AFStore
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "NewsViewController.h"
@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);

    
    
    [self NewsWebService];
    self.title=LocalizedString(@"News");
    [self setNavBar];

    
    
    [self.view registerNib:[UINib nibWithNibName:@"NewsViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)prefersStatusBarHidden
{
    return NO;
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
    
    //Contact Us Button
    UIButton *btnCont = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage4 = [UIImage imageNamed:@"call.png"]  ;
    [btnCont setBackgroundImage:rightBtnImage4 forState:UIControlStateNormal];
    [btnCont addTarget:self action:@selector(goContactUs) forControlEvents:UIControlEventTouchUpInside];
    btnCont.frame = CGRectMake(0, 0,  20, 18);
    UIBarButtonItem *ContUs = [[UIBarButtonItem alloc] initWithCustomView:btnCont] ;
    
    self.navigationItem.rightBarButtonItems=@[ContUs];
    
}
-(void)goContactUs
{
    ContactUSViewController *cuvc=[[ContactUSViewController alloc]init];
    
    [self.navigationController pushViewController:cuvc animated:YES];
    
}


- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark Collection view methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return NewsListArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     NewsViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    tempCell=[[NewsViewCell alloc]init];
    
    tempCell.cellDict=[NewsListArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    
    cell.lblNewsTitle.text = tempCell.cellDict[@"Title"];
    
//    cell.lblNewsSummery.text=tempCell.cellDict[@"Summary"];
    cell.lblPublishDate.text=tempCell.cellDict[@"PublishDate"];
    NSNumber * noOfVi=tempCell.cellDict[@"NumberOfViews"];
    cell.lblNoOfViews.text=[NSString stringWithFormat:@"%@ : %@",LocalizedString(@"Number of Views"), noOfVi];
    
    
    dispatch_async(queue, ^(){
        
        [cell.indicatorV startAnimating];
        // NSString * webURL=@"http://192.168.1.9/MenupicsServices/DishPhoto/";
        
        NSString * imgURL = tempCell.cellDict[@"ArticleImage"];
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        UIImage * image = [UIImage imageWithData:imgData];
        
           dispatch_async( dispatch_get_main_queue() , ^(){
            
               
            cell.imgNewsImage.image=image;
            
               [cell.indicatorV stopAnimating];
        });
        
    });
    
    return cell;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    DetailNewsViewController *detNews = [[DetailNewsViewController alloc] initWithNibName:@"DetailNewsViewController" bundle:nil];
    
    tempCell.cellDict=[NewsListArray objectAtIndex:indexPath.row];
    
    detNews.newsTitle=tempCell.cellDict[@"Title"];
    detNews.newsPubDate=tempCell.cellDict[@"PublishDate"];
    detNews.newssummery=tempCell.cellDict[@"Summary"];
    
    detNews.newsNoOfViews=tempCell.cellDict[@"NumberOfViews"];
    detNews.newsExpDate=tempCell.cellDict[@"ExpireDate"];
    detNews.newsImage=tempCell.cellDict[@"ArticleImage"];
    detNews.newsArticleID=tempCell.cellDict[@"ArticleID"];
    
    
    [self.navigationController pushViewController:detNews animated:YES];
    
    
}
#pragma mark Webservices

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
             // NSArray *list=[responseObject objectForKey:@"Data"];
             NewsListArray=[[NSMutableArray alloc]init];
             NewsListArray=[responseObject objectForKey:@"Data"];
             if(NewsListArray.count>0)
             {
                 int i;
                 for (i=0; i<NewsListArray.count; i++)
                 {
                     NSDictionary * d = [NewsListArray objectAtIndex:i];
                     
                     _NewsTitle=[d valueForKey:@"Title"];
                     _PublishDate=[d valueForKey:@"PublishDate"];
                     _ExpireDate=[d valueForKey:@"ExpireDate"];
                     _ArticleImage=[d valueForKey:@"ArticleImage"];
                     _Summary=[d valueForKey:@"Summary"];
                     _ArticleID=[d valueForKey:@"ArticleID"];
                     _NumberOfViews=[d valueForKey:@"NumberOfViews"];
                 }
                 
             }
             else
             {
                 UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:@"News Not Available!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
           
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
         
         [self.view reloadData];
         
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
