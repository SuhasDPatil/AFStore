//
//  SubCategoryViewController.m
//  AFStore
//
//  Created by Suhas on 11/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "SubCategoryViewController.h"

@interface SubCategoryViewController ()

@end

@implementation SubCategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);

    self.title=@"Store";
    [self.collectionView registerNib:[UINib nibWithNibName:@"SubCategoryViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self subCategoryWebService];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setNavBar];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
}
-(BOOL)prefersStatusBarHidden
{
    return NO;
}




-(void)setNavBar
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:223.0f/255.0f green:128.0f/255.0f blue:0.0f/255.0f alpha:1.0];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Overriding methods
- (void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0,0};
    frame.size = (CGSize){40,40};
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:@"menu_button.png"] forState:UIControlStateNormal];
}
- (BOOL)deepnessForLeftMenu
{
    return YES;
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return subCategoryListArray.count;
    
    NSLog(@"Sub Count:::: %ld",(unsigned long)subCategoryListArray.count);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubCategoryViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    tempCell=[[SubCategoryViewCell alloc]init];
    
    tempCell.cellDict=[subCategoryListArray objectAtIndex:indexPath.row];
    
//    cell.lblSubCateName.text=tempCell.cellDict[@"SubCategoriesName"];
    
    dispatch_async(queue, ^(){
        [cell.indicator startAnimating];
        NSString * imgURL = tempCell.cellDict[@"Logo"];
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES_Store,imgURL];
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString * replacedStr1=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];
        
        NSURL * url = [NSURL URLWithString:replacedStr1];
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:imgData];
        dispatch_async( dispatch_get_main_queue() , ^(){
            cell.imgSubCateImage.image=image;
            [cell.indicator stopAnimating];
        });
    });

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ProductViewController *prod = [[ProductViewController alloc] initWithNibName:@"ProductViewController" bundle:nil];
    
    // Pass the selected object to the new view controller.
 
    
    
    tempCell.cellDict=[subCategoryListArray objectAtIndex:indexPath.row];
    
    
    prod.BrandID=tempCell.cellDict[@"BrandID"];
    
    prod.Brand_name=tempCell.cellDict[@"BrandName"];

    
    NSLog(@"Selected cell index===%ld",(long)indexPath.row);
    
    [self.navigationController pushViewController:prod animated:YES];
  
}


#pragma mark Webservices

-(void)subCategoryWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_BRAND_LIST
                               parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             subCategoryListArray=[[NSMutableArray alloc]init];
             subCategoryListArray=[responseObject objectForKey:@"Data"];
             if(subCategoryListArray.count>0)
             {
                 
                 int i;
                 for (i=0; i<subCategoryListArray.count; i++)
                 {
                     NSDictionary * d = [subCategoryListArray objectAtIndex:i];
                     
                     _BrandID=[d valueForKey:@"BrandID"];
                     _BrandName=[d valueForKey:@"BrandName"];
                     _Logo=[d valueForKey:@"Logo"];
                     
                 }
             }
             else
             {
                 [Utiles showAlert:ERROR Message:[responseObject objectForKey:@"Message"]];
                 
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
    if (alertView.tag==111) {
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}



@end
