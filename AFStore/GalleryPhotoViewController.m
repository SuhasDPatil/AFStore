//
//  GalleryPhotoViewController.m
//  AFStoreNew
//
//  Created by rac on 07/07/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "GalleryPhotoViewController.h"

@interface GalleryPhotoViewController ()

@end

@implementation GalleryPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=_GallryName;

    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    
    [self.photoCollectionView registerNib:[UINib nibWithNibName:@"PhotoViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self PhotoWebService];
    [self.photoCollectionView reloadData];

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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return photoArray.count;
    NSLog(@"Array Count: %ld",photoArray.count);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.imgPhoto.image = [UIImage imageNamed:photoArray[indexPath.row]];
    
    tempCell=[[PhotoViewCell alloc]init];

    tempCell.cellDict=[photoArray objectAtIndex:indexPath.row];

    
    dispatch_async(queue, ^(){
        
        [cell.indicatorV startAnimating];
        
        NSString * imgURL = tempCell.cellDict[@"FileName"];
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        NSLog(@"Image URL======================%@",combined);
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        UIImage * image = [UIImage imageWithData:imgData];
        
        dispatch_async( dispatch_get_main_queue() , ^(){
            
            cell.imgPhoto.image=image;
            
            [cell.indicatorV stopAnimating];
        });
        
    });


    
    return cell;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)PhotoWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:_GallryID forKey:@"GalleryID"];
    
    NSLog(@"%@",dict);

    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_GALLERY_IMAGES
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             photoArray=[[NSMutableArray alloc]init];
             photoArray=[responseObject objectForKey:@"Data"];
             
             if(photoArray.count>0)
             {
                 NSLog(@"Category Array Count:::%ld",(unsigned long)photoArray.count);
                 int i;
                 for (i=0; i<photoArray.count; i++)
                 {
                     NSDictionary * d = [photoArray objectAtIndex:i];
                     
                     _ThumbUrl=[d valueForKey:@"ThumbUrl"];
                     _FileName=[d valueForKey:@"FileName"];
                     
                     NSLog(@"Thumb URL: %@",_ThumbUrl);
                     NSLog(@"File Name: %@",_FileName);
                     
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
         
         [self.photoCollectionView reloadData];
         
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
