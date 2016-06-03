//
//  CategoryViewController.m
//  AFStore
//
//  Created by Suhas on 11/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "CategoryViewController.h"
@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);

    [self CategoryWebService];
    [self setNavBar];

    [self.tableView registerNib:[UINib nibWithNibName:@"CategoryViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.navigationController.navigationBar setHidden:NO];
    self.title=LocalizedString(@"Store");


    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"splash2_bg.jpg"]];

}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return CategoryListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    tempCell=[[CategoryViewCell alloc]init];
    tempCell.cellDict=[CategoryListArray objectAtIndex:indexPath.row];
    // Configure the cell...
    cell.lblCategoryName.text = tempCell.cellDict[@"CategoriesName"];
    
    cell.lblImgCount.hidden=YES;
    cell.imgCountBG.hidden=YES;
    
//    dispatch_async(queue, ^(){
//        
//        NSString * imgURL = tempCell.cellDict[@"CategoryImages"];
//        
//        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
//        
//        NSURL * url = [NSURL URLWithString:combined];
//        
//        NSData * imgData = [NSData dataWithContentsOfURL:url];
//        
//        UIImage * image = [UIImage imageWithData:imgData];
//        
//        // It is very IMP  :::: [cell.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
//        dispatch_async( dispatch_get_main_queue() , ^(){
//            
//            
//            cell.imgCategoryImage.image=image;
//            
//            
//        });
//        
//    });

    
    if (indexPath.row==0)
    {
        cell.imgCategoryImage.image=[UIImage imageNamed:@"card.png"];
    }
    else if(indexPath.row==1)
    {
        cell.imgCategoryImage.image=[UIImage imageNamed:@"mobile.png"];
        
    }
    else if(indexPath.row==2)
    {
        cell.imgCategoryImage.image=[UIImage imageNamed:@"tablet.png"];
        
    }
    else if (indexPath.row==3)
    {
        cell.imgCategoryImage.image=[UIImage imageNamed:@"accessories.png"];
        
    }
    else if (indexPath.row==4)
    {
        cell.imgCategoryImage.image=[UIImage imageNamed:@"mobile.png"];
        
    }
    else
    {
        cell.imgCategoryImage.image=[UIImage imageNamed:@"mobile.png"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    SubCategoryViewController *sub = [[SubCategoryViewController alloc] initWithNibName:@"SubCategoryViewController" bundle:nil];
    
    // Pass the selected object to the new view controller.
    tempCell.cellDict=[CategoryListArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    sub.CatID=tempCell.cellDict[@"CategoriesID"];
    sub.cateName=tempCell.cellDict[@"CategoriesName"];
    
    if (indexPath.row==0)
    {
        sub.catImageName=@"C";
    }
    else if(indexPath.row==1)
    {
        sub.catImageName=@"M";
    }
    else if(indexPath.row==2)
    {
        sub.catImageName=@"T";
    }
    else if (indexPath.row==3)
    {
        sub.catImageName=@"A";
    }
    else if (indexPath.row==4)
    {
        sub.catImageName=@"M";
    }
    else
    {
        sub.catImageName=@"M";
    }
    
    [self.navigationController pushViewController:sub animated:YES];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return LocalizedString(@"Choose Category");
}
#pragma mark Webservices

-(void)CategoryWebService
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[AFAppAPIClient WSsharedClient] POST:API_GET_MAIN_CATEGORY
                               parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         if(result)
         {
             // NSArray *list=[responseObject objectForKey:@"Data"];
             CategoryListArray=[[NSMutableArray alloc]init];
             CategoryListArray=[responseObject objectForKey:@"Data"];
             if(CategoryListArray.count>0)
             {
                 int i;
                 for (i=0; i<CategoryListArray.count; i++)
                 {
                     NSDictionary * d = [CategoryListArray objectAtIndex:i];
                     _CategoriesID=[d valueForKey:@"CategoriesID"];
                     _CategoriesName=[d valueForKey:@"CategoriesName"];
                     _CategoryImages=[d valueForKey:@"CategoryImages"];
                     
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
