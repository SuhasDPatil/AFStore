//
//  GalleryVideoViewController.m
//  AFStoreNew
//
//  Created by rac on 27/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "GalleryVideoViewController.h"

@interface GalleryVideoViewController ()

@end

@implementation GalleryVideoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=LocalizedString(@"Video Gallery");

    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);

    [self.Tabview registerNib:[UINib nibWithNibName:@"VideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self VideoWebService];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden
{
    return NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setNavBar];
    [self.navigationController setNavigationBarHidden:NO];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return VideoListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    tempCell=[[VideoTableViewCell alloc]init];
    
    tempCell.cellDict=[VideoListArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    
    dispatch_async(queue, ^(){
        
        NSString * imgURL = tempCell.cellDict[@"ThumbUrl"];
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        NSLog(@"Image URL======================%@",combined);
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        UIImage * image = [UIImage imageWithData:imgData];
        
        dispatch_async( dispatch_get_main_queue() , ^(){
            
            cell.imgVideoImage.image=image;
            
        });
        
    });

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"DID SELECT");

    VideoViewController *vvc = [[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:nil];
    
    tempCell.cellDict=[VideoListArray objectAtIndex:[self.Tabview indexPathForSelectedRow].row];
    vvc.videoURL=tempCell.cellDict[@"FileName"];
   
    NSString *str=tempCell.cellDict[@"FileName"];
    
    NSLog(@"%@",str);
    
    [self.navigationController pushViewController:vvc animated:YES];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 213.0f;
    
}


#pragma mark Webservices

-(void)VideoWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_GALLERY_VIDEOS
                               parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             VideoListArray=[[NSMutableArray alloc]init];
             VideoListArray=[responseObject objectForKey:@"Data"];
             if(VideoListArray.count>0)
             {
                 NSLog(@"Category Array Count:::%ld",(unsigned long)VideoListArray.count);
                 int i;
                 for (i=0; i<VideoListArray.count; i++)
                 {
                     NSDictionary * d = [VideoListArray objectAtIndex:i];
                     
                     _ThumbUrl=[d valueForKey:@"ThumbUrl"];
                     _FileName=[d valueForKey:@"FileName"];
                     
                     NSLog(@"CategoriesID: %@", _ThumbUrl);
                     NSLog(@"CategoriesName: %@",_FileName);
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
         [self.Tabview reloadData];
         
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
