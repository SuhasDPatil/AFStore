//
//  WarrantyViewController.m
//  AFStoreNew
//
//  Created by rac on 07/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "WarrantyViewController.h"

@interface WarrantyViewController ()

@end

@implementation WarrantyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=LocalizedString(@"Warranty");
    
    
    self.lblDiamond.text=LocalizedString(@"Diamond");
    self.lblGold.text=LocalizedString(@"Gold");
    self.lblSilver.text=LocalizedString(@"Silver");
    
    self.lblGuarranty1.text=LocalizedString(@"Guarantee");
    self.lblGuarranty2.text=LocalizedString(@"Guarantee");
    self.lblGuarranty3.text=LocalizedString(@"Guarantee");

    
    
    [self WarrantyWebService];
    
    
    
    [self setNavBar];
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
    
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)diamondGClicked:(id)sender
{
    wdvc=[[WarrantyDeytailsViewController alloc]init];
    wdvc.strTitle=@"Diamod Warranty";
    wdvc.warrantyData=_diamond;
    
    [self.navigationController pushViewController:wdvc animated:YES];
    
}

- (IBAction)goldGClicked:(id)sender
{
    wdvc=[[WarrantyDeytailsViewController alloc]init];
    wdvc.strTitle=@"Gold Warranty";
    wdvc.warrantyData=_gold;
    [self.navigationController pushViewController:wdvc animated:YES];
}

- (IBAction)silverGClicked:(id)sender
{
    
    wdvc=[[WarrantyDeytailsViewController alloc]init];
    wdvc.strTitle=@"Silver Warranty";
    wdvc.warrantyData=_silver;
    [self.navigationController pushViewController:wdvc animated:YES];
    
}

#pragma mark WebService

-(void)WarrantyWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_ALL_WARRANTY
                               parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             goldArray=[[NSMutableArray alloc]init];
             silverArray=[[NSMutableArray alloc]init];
             diamondArray=[[NSMutableArray alloc]init];
             
             goldArray=[responseObject objectForKey:@"gold"];
             silverArray=[responseObject objectForKey:@"silver"];
             diamondArray=[responseObject objectForKey:@"diamond"];
             
             NSDictionary * goldD = [goldArray objectAtIndex:0];
             _tempGold=[goldD valueForKey:@"value"];
             
             NSDictionary * silvreD = [silverArray objectAtIndex:0];
             _tempSilver=[silvreD valueForKey:@"value"];
             
             NSDictionary * diamondD = [diamondArray objectAtIndex:0];
             _tempDiamond=[diamondD valueForKey:@"value"];
             
             
             
             
             //             NSString * replacedStr=[_tempAboutUs_EN stringByReplacingOccurrencesOfString:@" " withString:@"&nbsp"];
             
             _gold=[_tempGold stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
             
             _gold=[_tempGold stringByReplacingOccurrencesOfString:@"  " withString:@"&nbsp"];
             
             
             NSLog(@"\nGOLD ===\n%@\n\n",_gold);
             
             _silver=[_tempSilver stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
             
             _silver=[_tempSilver stringByReplacingOccurrencesOfString:@"  " withString:@"&nbsp"];
             
             
             NSLog(@"\nSILVERE===\n%@\n\n",_silver);
             
             _diamond=[_tempDiamond stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
             
             _diamond=[_tempDiamond stringByReplacingOccurrencesOfString:@"  " withString:@"&nbsp"];
             
             
             NSLog(@"\nDIAMOND==\n%@\n\n",_diamond);
             
         }
         else
         {
             
             UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             alt1.tag=111;
             [alt1 show];
             
         }
         [hud hide:YES];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alt1.tag=111;
         [alt1 show];
         
     }];
    
}




@end
