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
    [_searchBar2 setPlaceholder:LocalizedString(@"Search Bar")];

    [self setNavBar];
    
    
    self.collectionView.delegate=self;
    
    _searchBar2.delegate = (id)self;

    [self.searchBar2 becomeFirstResponder];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],UITextAttributeTextColor,[UIColor whiteColor],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 1)],UITextAttributeTextShadowOffset,nil]forState:UIControlStateNormal];

    
    _spinnerView.circleLayer.lineWidth = 2.0;
    
    // Change the color of the line
    _spinnerView.circleLayer.strokeColor = [UIColor orangeColor].CGColor;

    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchProductViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    nomatchesView = [[UIView alloc] initWithFrame:self.view.frame];
    nomatchesView.backgroundColor = [UIColor clearColor];
    
    UILabel *matchesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,320)];
    matchesLabel.font = [UIFont boldSystemFontOfSize:18];
    matchesLabel.minimumFontSize = 12.0f;
    matchesLabel.numberOfLines = 1;
    matchesLabel.lineBreakMode = UILineBreakModeWordWrap;
    matchesLabel.shadowColor = [UIColor lightTextColor];
    matchesLabel.textColor = [UIColor darkGrayColor];
    matchesLabel.shadowOffset = CGSizeMake(0, 1);
    matchesLabel.backgroundColor = [UIColor clearColor];
    matchesLabel.textAlignment =  UITextAlignmentCenter;
    
    //Here is the text for when there are no results
    matchesLabel.text = @"No Matches";
    
    
    nomatchesView.hidden = YES;
    _collectionView.hidden = NO;
    [nomatchesView addSubview:matchesLabel];
    [self.view insertSubview:nomatchesView belowSubview:self.searchBar2];

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
    
    UIButton *btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage3 = [UIImage imageNamed:@"home.png"]  ;
    [btnHome setBackgroundImage:rightBtnImage3 forState:UIControlStateNormal];
    [btnHome addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    btnHome.frame = CGRectMake(0, 0, 18, 17);
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithCustomView:btnHome] ;
    
    //Contact Us Button
    UIButton *btnCont = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage4 = [UIImage imageNamed:@"call.png"]  ;
    [btnCont setBackgroundImage:rightBtnImage4 forState:UIControlStateNormal];
    [btnCont addTarget:self action:@selector(goContactUs) forControlEvents:UIControlEventTouchUpInside];
    btnCont.frame = CGRectMake(0, 0,  20, 18);
    UIBarButtonItem *ContUs = [[UIBarButtonItem alloc] initWithCustomView:btnCont] ;
    
    self.navigationItem.rightBarButtonItems=@[home,ContUs];
    
}
-(void)goContactUs
{
    ContactUSViewController *cuvc=[[ContactUSViewController alloc]init];
    
    [self.navigationController pushViewController:cuvc animated:YES];
    
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([SearchListArray count] == 0 ){
        _collectionView.hidden = YES;
        nomatchesView.hidden = NO;
    } else {
        _collectionView.hidden = NO;
        nomatchesView.hidden = YES;
    }

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
    [_searchBar2 resignFirstResponder];
    
    ProductDetailViewController *detSearch = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    tempCell.cellDict=[SearchListArray objectAtIndex:indexPath.row];
    detSearch.ProductName_title=tempCell.cellDict[@"Model"];
    detSearch.mobile_ID=tempCell.cellDict[@"MobileID"];
    detSearch.gold_Price=tempCell.cellDict[@"GoldPrice"];
    detSearch.silver_Price=tempCell.cellDict[@"Price"];
    detSearch.diamond_Price=tempCell.cellDict[@"DiamondPrice"];
    detSearch.photo_path=tempCell.cellDict[@"PhotoPath"];
    
    // Push the view controller.
    
    [self.navigationController pushViewController:detSearch animated:YES];
    
    detSearch.title=@"Details";

    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchBar2 resignFirstResponder];
}

#pragma mark SearchBarDelegate

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    _txtSearch=[NSString stringWithString:text];

}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //User hit Search button on Keyboard
    [self SearchWebService];

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
    [dict setObject:_txtSearch forKey:@"FreeTextSearch"];
    
    NSLog(@"%@ \n \n%@",API_SEARCH_PRODUCT_BY_TEXT, dict);
    
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
                 _collectionView.hidden = NO;

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
                 [hud hide:YES];
                 [self.collectionView reloadData];
             }
             else
             {
                 _collectionView.hidden = YES;
                 nomatchesView.hidden=NO;
             }
         }
         else
         {
             _collectionView.hidden = YES;
             nomatchesView.hidden=NO;
         }
        [hud hide:YES];
        
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
