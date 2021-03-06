//
//  ProductViewController.m
//  AFStore 
//
//  Created by Suhas on 17/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "ProductViewController.h"
//#import "NSString+HTML.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.segCondition.selectedSegmentIndex=0;

    [_segCondition setTitle:LocalizedString(@"New") forSegmentAtIndex:0];
    [_segCondition setTitle:LocalizedString(@"Used") forSegmentAtIndex:1];

    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    [self.collectionview registerNib:[UINib nibWithNibName:@"ProductViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.navigationController.navigationBar setHidden:NO];
    self.title=_Brand_name;
    self.segCondition.selectedSegmentIndex=0;
    _Condition_newUsed=@"1";
    
    [self getProductWebService];

    nomatchesView = [[UIView alloc] initWithFrame:self.view.frame];
    nomatchesView.backgroundColor = [UIColor clearColor];
    
    UILabel *matchesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,220)];
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
    matchesLabel.text = @"No Record Found";
    
    
    nomatchesView.hidden = YES;
    _collectionview.hidden = NO;
    [nomatchesView addSubview:matchesLabel];
    [self.view insertSubview:nomatchesView belowSubview:self.segCondition];

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)conditionChanged:(id)sender
{
    if (self.segCondition.selectedSegmentIndex==0)
    {
        _Condition_newUsed=@"1";
    }
    else if (self.segCondition.selectedSegmentIndex==1)
    {
        _Condition_newUsed=@"2";
    }

    [self getProductWebService];

}

-(void)viewWillAppear:(BOOL)animated
{
    [self setNavBar];
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}


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
    
    //Home Button
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

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Collection View Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([ProductsListArray count] == 0 ){
        _collectionview.hidden = YES;
        nomatchesView.hidden = NO;
    } else {
        _collectionview.hidden = NO;
        nomatchesView.hidden = YES;
    }

    return ProductsListArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    tempCell=[[ProductViewCell alloc]init];
    tempCell.cellDict=[ProductsListArray objectAtIndex:indexPath.row];
    NSString * str=tempCell.cellDict[@"BrandModel"];
    cell.lblProductName.text=str;
    NSString * strDoller=@"$";
    NSString * strCost=tempCell.cellDict[@"Price"];
    cell.lblProductCost.text=[NSString stringWithFormat:@"%@",strCost];
    cell.lblFree1.text=tempCell.cellDict[@"ColorName"];
    
    
    
    // Configure the cell...
    dispatch_async(queue, ^(){
        
        [cell.indicator startAnimating];
        
        NSString * imgURL = tempCell.cellDict[@"PhotoPath"];
        
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductDetailViewController *detProd = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    tempCell.cellDict=[ProductsListArray objectAtIndex:indexPath.row];

    detProd.ProductName_title=tempCell.cellDict[@"Model"];
    detProd.mobile_ID=tempCell.cellDict[@"MobileID"];
    detProd.gold_Price=tempCell.cellDict[@"GoldPrice"];
    detProd.silver_Price=tempCell.cellDict[@"Price"];
    detProd.diamond_Price=tempCell.cellDict[@"DiamondPrice"];
    detProd.photo_path=tempCell.cellDict[@"PhotoPath"];
    
    [self.navigationController pushViewController:detProd animated:YES];
    
}

#pragma mark Webservices

-(void)getProductWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:_BrandID forKey:@"BrandID"];
    [dict setObject:_Condition_newUsed forKey:@"Condition"];

    
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_PRODUCT_LIST
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             // NSArray *list=[responseObject objectForKey:@"Data"];
             ProductsListArray=[[NSMutableArray alloc]init];
             ProductsListArray=[responseObject objectForKey:@"Data"];
             if(ProductsListArray.count>0)
             {
                 nomatchesView.hidden=YES;

                 int i;
                 for (i=0; i<ProductsListArray.count; i++)
                 {
                     NSDictionary * d = [ProductsListArray objectAtIndex:i];
                     
                     _BrandID=[d valueForKey:@"BrandID"];
                     _Condition=[d valueForKey:@"Condition"];
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
                 }
                 [self.collectionview reloadData];

             }
             else
             {
                 _collectionview.hidden=YES;
                 nomatchesView.hidden=NO;

                 UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alt1 show];
             }
         }
         else
         {
             _collectionview.hidden=YES;
             nomatchesView.hidden=NO;

             UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:LocalizedString(@"Goto New") otherButtonTitles:LocalizedString(@"Cancel"), nil];
             alt1.tag=20;
             [alt1 show];
             
         }
         [hud hide:YES];
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:LocalizedString(@"Goto New") otherButtonTitles:LocalizedString(@"Cancel"), nil];
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
    if (alertView.tag==20)
    {
        if (buttonIndex==0)
        {
            self.segCondition.selectedSegmentIndex=0;
            _collectionview.hidden=NO;
            nomatchesView.hidden=YES;
        }
        else
        {
            _collectionview.hidden=YES;
            nomatchesView.hidden=NO;
        }
    }

}

@end
