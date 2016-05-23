//
//  GalleryBranchViewController.m
//  AFStoreNew
//
//  Created by rac on 10/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "GalleryBranchViewController.h"

@interface GalleryBranchViewController ()

@end

@implementation GalleryBranchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBar];
    
    self.title=LocalizedString(@"Photo Gallery");
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CategoryViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    [self GetBranchWebService];
    
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
    
    //Home Button
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

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)goHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark UitableViewDelegate an UitableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return BranchListArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    tempCell=[[CategoryViewCell alloc]init];
    tempCell.cellDict=[BranchListArray objectAtIndex:indexPath.row];
    // Configure the cell...
    NSString * strBName=tempCell.cellDict[@"GalleryName"];
    NSString * strCount=[NSString stringWithFormat:@"%@",tempCell.cellDict[@"ImagesCount"]];

    cell.lblCategoryName.text =strBName;
    
    
    cell.lblImgCount.hidden=NO;
    cell.lblImgCount.text=strCount;
    
    cell.imgCategoryImage.image=[UIImage imageNamed:@"gallery_album.png"];

    //    cell.lblCategoryName.text=@"Suhas";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GalleryPhotoViewController * gpvc=[[GalleryPhotoViewController alloc]init];
    
    // Pass the selected object to the new view controller.
    tempCell.cellDict=[BranchListArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    gpvc.GallryID=tempCell.cellDict[@"GalleryID"];
    gpvc.GallryName=tempCell.cellDict[@"GalleryName"];
    // Push the view controller.
    [self.navigationController pushViewController:gpvc animated:YES];

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return LocalizedString(@"Choose Branch");
}
#pragma mark Webservices

-(void)GetBranchWebService
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:@"2" forKey:@"CategoryID"];
    
    NSLog(@"%@",dict);

    [[AFAppAPIClient WSsharedClient] POST:API_GET_GALLERY_BRANCHES
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             BranchListArray=[[NSMutableArray alloc]init];
             BranchListArray=[responseObject objectForKey:@"Data"];
             if(BranchListArray.count>0)
             {
                 NSLog(@"Category Array Count:::%ld",(unsigned long)BranchListArray.count);
                 int i;
                 for (i=0; i<BranchListArray.count; i++)
                 {
                     NSDictionary * d = [BranchListArray objectAtIndex:i];
                     _CategoryID=[d valueForKey:@"CategoryID"];
                     _GalleryDescription=[d valueForKey:@"GalleryDescription"];
                     _GalleryID=[d valueForKey:@"GalleryID"];
                     _GalleryName=[d valueForKey:@"GalleryName"];
                     _ImagesCount=[d valueForKey:@"ImagesCount"];
                     
                     NSLog(@"Category ID: %@", _CategoryID);
                     NSLog(@"Galeery Name: %@ (%@)",_GalleryName,_ImagesCount);
                     NSLog(@"Gallery ID: %@", _GalleryID);
                     
                 }
             }
             else
             {
                 [Utiles showAlert:ERROR Message:[responseObject objectForKey:@"Message"] ];
             }
         }
         else
         {
             
             UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             alt1.tag=111;
             [alt1 show];
             
         }
         [hud hide:YES];
         [self.tableView reloadData];
         
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
