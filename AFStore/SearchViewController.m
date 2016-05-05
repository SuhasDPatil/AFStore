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

    
    [self GetProductListWebService];
   // [self.collectionView registerNib:@"SearchProductViewCell" forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchProductViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    
    
    
   // [self setKeyboard];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:tap];
    

    
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
    
    
    cell.lblProductName.text = tempCell.cellDict[@"ProductName"];
    
    dispatch_async(queue, ^(){
        
        NSString * imgURL = tempCell.cellDict[@"ProductImage"];
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];

        
        UIImage * image = [UIImage imageWithData:imgData];
        
        dispatch_async( dispatch_get_main_queue() , ^(){

            cell.imgProductImage.image=image;
                       
        });
        
    });
    return cell;
  
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"DID SELECT");
    
    
    ProductDetailViewController *detSearch = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    tempCell.cellDict=[SearchListArray objectAtIndex:indexPath.row];
    detSearch.productID=tempCell.cellDict[@"ProductID"];
    detSearch.productName=tempCell.cellDict[@"ProductName"];
    detSearch.prodimage=tempCell.cellDict[@"ProductImage"];
    detSearch.subCateName=tempCell.cellDict[@"ProductName"];
    detSearch.prodFree1=tempCell.cellDict[@"Free1"];
    detSearch.prodcost=tempCell.cellDict[@"ProductCost"];
    
    
    NSLog(@"%@",tempCell.cellDict);
    
    NSLog(@"Prod ID ........%@",detSearch.productID);
    NSLog(@"Prod Name ........%@",detSearch.productName);
    NSLog(@"Sub Cate Name .......%@",detSearch.subCateName);
    NSLog(@"Sub Cate Name .......%@",detSearch.detStrFinalBackView);
    
    // Push the view controller.
    
    [self.navigationController pushViewController:detSearch animated:YES];
    
    detSearch.title=@"Details";

    
}





#pragma mark SearchBarDelegate

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    //NSLog(@"searchBar ... text.length: %d", text.length);

    
    _txtSearch=[NSString stringWithString:text];
    
    
    [self SearchWebService];
    
//    [self.collectionView reloadData];
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:_txtSearch forKey:@"SearchText"];
    
    NSLog(@"%@",dict);
    
    
    [[AFAppAPIClient WSsharedClient] POST:API_SEARCH_PRODUCT_BY_TEXT
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [hud show:YES];
         
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
                     
                     
                     _Details=[d valueForKey:@"Details"];
                     _ProductID=[d valueForKey:@"ProductID"];
                     _ProductImage=[d valueForKey:@"ProductImage"];
                     _ProductName=[d valueForKey:@"ProductName"];
                     _ProductCost=[d valueForKey:@"ProductCost"];
                     _Free1=[d valueForKey:@"Free1"];
                     
                     NSLog(@"Product Name : %@", _ProductName);
                     NSLog(@"Product Details : %@",_Details);
                     NSLog(@"Product Id : %@", _ProductID);
                     NSLog(@"Product Image : %@", _ProductImage);
                     
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
         [hud hide:YES];
         [self.collectionView reloadData];
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alt1.tag=111;
         [alt1 show];
         
     }];
    
}



-(void)GetProductListWebService
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_PRODUCTS_FOR_SEARCH
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [hud show:YES];
         
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
                     
                     
                     _Details=[d valueForKey:@"Details"];
                     _ProductID=[d valueForKey:@"ProductID"];
                     _ProductImage=[d valueForKey:@"ProductImage"];
                     _ProductName=[d valueForKey:@"ProductName"];
                     _ProductCost=[d valueForKey:@"ProductCost"];
                     _Free1=[d valueForKey:@"Free1"];

                     NSLog(@"Product Name : %@", _ProductName);
                     NSLog(@"Product Details : %@",_Details);
                     NSLog(@"Product Id : %@", _ProductID);
                     NSLog(@"Product Image : %@", _ProductImage);
                     
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
    if (alertView.tag==111) {
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


@end
