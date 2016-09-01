//
//  HotOfferCategoryViewController.m
//  AFStoreNew
//
//  Created by rac on 06/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "HotOfferCategoryViewController.h"

@interface HotOfferCategoryViewController ()

@end

@implementation HotOfferCategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    CategoryArray=[[NSMutableArray alloc]init];
    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);

    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HotOfferCategoriesViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.navigationController.navigationBar setHidden:NO];
    self.title=LocalizedString(@"Hot Offer");

    [self setNavBar];
    
    
    
    [self getHotOfferWebService];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
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
    
    
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return CategoryArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotOfferCategoriesViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    tempCell=[[HotOfferCategoriesViewCell alloc]init];
    
    tempCell.cellDict=[CategoryArray objectAtIndex:indexPath.row];
    
    cell.lblcategoriesName.text=tempCell.cellDict[@"GalleryName"];
    
    
    dispatch_async(queue, ^(){
        
        NSString * imgURL = tempCell.cellDict[@"Image"];
        
        NSString * strdf=@"http://www.aynalfahad.com";
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", strdf,imgURL];
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        UIImage * image = [UIImage imageWithData:imgData];
        
        // It is very IMP  :::: [cell.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
        dispatch_async( dispatch_get_main_queue() , ^(){
            
            cell.imgCategoriesImage.image=image;
            
        });
        
    });
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    HotOfferViewController *hovc = [[HotOfferViewController alloc] initWithNibName:@"HotOfferViewController" bundle:nil];
    
    // Pass the selected object to the new view controller.
    tempCell.cellDict=[CategoryArray objectAtIndex:indexPath.row];
    
    hovc.GalleryID=tempCell.cellDict[@"GalleryID"];
    hovc.GalleryName=tempCell.cellDict[@"GalleryName"];
    
    [self.navigationController pushViewController:hovc animated:YES];
    
}


#pragma mark Webservices

-(void)getHotOfferWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:@"3" forKey:@"CategoriesID"];
    
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_HOT_OFFER_CATEGORY_LIST
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             // NSArray *list=[responseObject objectForKey:@"Data"];
             CategoryArray=[[NSMutableArray alloc]init];
             CategoryArray=[responseObject objectForKey:@"Data"];
             if(CategoryArray.count>0)
             {
                 int i;
                 for (i=0; i<CategoryArray.count; i++)
                 {
                     NSDictionary * d = [CategoryArray objectAtIndex:i];
                     
                     _GalleryID=[d valueForKey:@"GalleryID"];
                     _GalleryName=[d valueForKey:@"GalleryName"];
                     _NumberOfViews=[d valueForKey:@"NumberOfViews"];
                     _PortalID=[d valueForKey:@"PortalID"];
                     _Image=[d valueForKey:@"Image"];
                     
                     
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
    if (alertView.tag==111)
    {
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
