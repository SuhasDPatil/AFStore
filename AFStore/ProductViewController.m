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

    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    
    [self.collectionview registerNib:[UINib nibWithNibName:@"ProductViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.navigationController.navigationBar setHidden:NO];
    self.title=_subCateName;
    
    [self getProductWebService];
    

    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setNavBar];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
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
    return ProductsListArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    tempCell=[[ProductViewCell alloc]init];
    
    tempCell.cellDict=[ProductsListArray objectAtIndex:indexPath.row];
    
    NSString * str=tempCell.cellDict[@"ProductName"];
    
    NSLog(@"Str::::::::%@",str);
    
    cell.lblProductName.text=str;
    
    NSString * strDoller=@"$ ";
    NSString * strCost=tempCell.cellDict[@"ProductCost"];
    
    cell.lblProductCost.text=[NSString stringWithFormat:@"%@ %@",strDoller,strCost];
    
    cell.lblFree1.text=tempCell.cellDict[@"Free1"];
    
    NSString *detStrHTML=tempCell.cellDict[@"Details"];
    NSLog(@"Product Detail in HTML format:%@",detStrHTML);
    
    
//    self.detStrfinal=[[detStrHTML stringByStrippingTags]stringByDecodingHTMLEntities];
    NSLog(@"*************************------------------------");
    NSLog(@"*************************------------------------");
    NSLog(@"*************************------------------------");
    NSLog(@"*************************------------------------");
    NSLog(@"*************************------------------------");
    
    NSLog(@"Product Detail without HTML tag  :%@",_detStrfinal);
    NSLog(@"*************************------------------------");
    NSLog(@"*************************------------------------");
    
    
    // Configure the cell...
    dispatch_async(queue, ^(){
        
        NSString * imgURL = tempCell.cellDict[@"ProductImage"];
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        UIImage * image = [UIImage imageWithData:imgData];
        
        // It is very IMP  :::: [cell.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
        dispatch_async( dispatch_get_main_queue() , ^(){
            
            
            cell.imgProductImage.image=image;
            
            
        });
        
    });
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"DID SELECT");
    
    
    ProductDetailViewController *detProd = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    tempCell.cellDict=[ProductsListArray objectAtIndex:indexPath.row];

    detProd.productID=tempCell.cellDict[@"ProductID"];
    detProd.productName=tempCell.cellDict[@"ProductName"];
    detProd.prodimage=tempCell.cellDict[@"ProductImage"];
    detProd.prodFree1=tempCell.cellDict[@"Free1"];
    detProd.prodcost=tempCell.cellDict[@"ProductCost"];
    
    
    
    detProd.subCateName=self.subCateName;
    
    
    
    detProd.detStrFinalBackView=self.detStrfinal;
      
    NSLog(@"Prod ID ........%@",detProd.productID);
    NSLog(@"Prod Name ........%@",detProd.productName);
    NSLog(@"Sub Cate Name .......%@",detProd.subCateName);
    NSLog(@"Sub Cate Name .......%@",detProd.detStrFinalBackView);
    
    // Push the view controller.
    [self.navigationController pushViewController:detProd animated:YES];
    
    

}



-(NSString *)convertHTML:(NSString *)html {
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark Webservices

-(void)getProductWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:_SubCatID forKey:@"SubCatID"];
    
    NSLog(@"%@",dict);
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_PRODUCT_LIST
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             ProductsListArray=[[NSMutableArray alloc]init];
             ProductsListArray=[responseObject objectForKey:@"Data"];
             if(ProductsListArray.count>0)
             {
                 NSLog(@"Category Array Count:::%ld",(unsigned long)ProductsListArray.count);
                 int i;
                 for (i=0; i<ProductsListArray.count; i++)
                 {
                     NSDictionary * d = [ProductsListArray objectAtIndex:i];
                     
                     _ProductName=[d valueForKey:@"ProductName"];
                     _Details=[d valueForKey:@"Details"];
                     _ProductID=[d valueForKey:@"ProductID"];
                     _ProductImage=[d valueForKey:@"ProductImage"];
                     _Free1=[d valueForKey:@"Free1"];
                     _ProductCost=[d valueForKey:@"ProductCost"];
                     NSLog(@"CategoriesID: %@", _ProductID);
                     //              NSLog(@"CategoriesName: %@",_CategoriesName);
                     //            NSLog(@"CategoryImages: %@", _CategoryImages);
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
