//
//  SearchViewController.m
//  AFStore 
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);

    self.title=LocalizedString(@"Search");
    [self setNavBar];
    self.collectionView.delegate=self;
    
    _searchBar2.delegate = (id)self;

    [self.searchBar2 becomeFirstResponder];
    
//    [self GetProductListWebService];
   // [self.collectionView registerNib:@"SearchProductViewCell" forCellWithReuseIdentifier:@"cell"];
    
    _spinnerView.circleLayer.lineWidth = 2.0;
    
    // Change the color of the line
    _spinnerView.circleLayer.strokeColor = [UIColor orangeColor].CGColor;

    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchProductViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    

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
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark User Defined

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
    
    UIButton *btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage3 = [UIImage imageNamed:@"home.png"]  ;
    [btnHome setBackgroundImage:rightBtnImage3 forState:UIControlStateNormal];
    [btnHome addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    btnHome.frame = CGRectMake(0, 0, 18, 17);
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithCustomView:btnHome] ;
    
    self.navigationItem.rightBarButtonItem=home;
    
}
- (void)goHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return SearchListArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchProductViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    tempCell=[[SearchProductViewCell alloc]init];
    
    tempCell.cellDict=[SearchListArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    
    cell.lblProductName.text = tempCell.cellDict[@"Model"];
    
    dispatch_async(queue, ^(){
        
        [cell.indicatorV startAnimating];
        NSString * imgURL = tempCell.cellDict[@"PhotoPath"];
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES_Store,imgURL];
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSString * replacedStr1=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];

        NSURL * url = [NSURL URLWithString:replacedStr1];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        UIImage * image = [UIImage imageWithData:imgData];
        
        dispatch_async( dispatch_get_main_queue() , ^(){

            cell.imgProductImage.image=image;
            
            [cell.indicatorV stopAnimating];
                       
        });
        
    });
    return cell;
  
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"DID SELECT");
    
    ProductDetailViewController *detSearch = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    tempCell.cellDict=[SearchListArray objectAtIndex:indexPath.row];
    detSearch.ProductName_title=tempCell.cellDict[@"Model"];
    detSearch.mobile_ID=tempCell.cellDict[@"MobileID"];
    
//    detSearch.productName=tempCell.cellDict[@"ProductName"];
//    detSearch.prodimage=tempCell.cellDict[@"ProductImage"];
//    detSearch.subCateName=tempCell.cellDict[@"ProductName"];
//    detSearch.prodFree1=tempCell.cellDict[@"Free1"];
//    detSearch.prodcost=tempCell.cellDict[@"ProductCost"];
//    
//    
//    NSLog(@"%@",tempCell.cellDict);
//    
//    NSLog(@"Prod ID ........%@",detSearch.productID);
//    NSLog(@"Prod Name ........%@",detSearch.productName);
//    NSLog(@"Sub Cate Name .......%@",detSearch.subCateName);
//    NSLog(@"Sub Cate Name .......%@",detSearch.detStrFinalBackView);
    
    // Push the view controller.
    
    [self.navigationController pushViewController:detSearch animated:YES];
    
    detSearch.title=@"Details";

    
}


#pragma mark SearchBarDelegate

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    _txtSearch=[NSString stringWithString:text];
    
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    
    [self SearchWebService];
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //User hit Search button on Keyboard
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text=@"";
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
    [self.collectionView reloadData];
}


#pragma mark Webservices

-(void)SearchWebService
{

    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:_txtSearch forKey:@"FreeTextSearch"];
    
    [_spinnerView beginRefreshing];

    NSLog(@"%@ \n \n%@",API_SEARCH_PRODUCT_BY_TEXT, dict);
    
    [[AFAppAPIClient WSsharedClient] POST:API_SEARCH_PRODUCT_BY_TEXT
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [_spinnerView endRefreshing];

        BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             SearchListArray=[[NSMutableArray alloc]init];
             SearchListArray=[responseObject objectForKey:@"Data"];
             if(SearchListArray.count>0)
             {
                 int i;
                 for (i=0; i<SearchListArray.count; i++)
                 {
                     NSDictionary * d = [SearchListArray objectAtIndex:i];
                     _BrandID=[d valueForKey:@"BrandID"];
                     _BrandModel=[d valueForKey:@"BrandModel"];
                     _BrandName=[d valueForKey:@"BrandName"];
                     _ColorName=[d valueForKey:@"ColorName"];
                     _DiamondPrice=[d valueForKey:@"DiamondPrice"];
                     _GoldPrice=[d valueForKey:@"GoldPrice"];
                     _MobileID=[d valueForKey:@"MobileID"];
                     _MobileStatus=[d valueForKey:@"MobileStatus"];
                     _Model=[d valueForKey:@"Model"];
                     _PhotoCount=[d valueForKey:@"PhotoCount"];
                     _PhotoPath=[d valueForKey:@"PhotoPath"];
                     _Price=[d valueForKey:@"Price"];
                     _SimType=[d valueForKey:@"SimType"];
                 }
             }
             else
             {
                 UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alt1 show];
             }
         }
         else
         {
             UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             [alt1 show];
         }
        
         [self.collectionView reloadData];
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [_spinnerView endRefreshing];
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


@end
