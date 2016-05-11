//
//  ChkYrPhoneViewController.m
//  AFStore
//
//  Created by rac on 17/11/15.
//  Copyright © 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "ChkYrPhoneViewController.h"

@interface ChkYrPhoneViewController ()

@end

@implementation ChkYrPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    self.title=LocalizedString(@"Check Your Phone");;
    
    [[self.lblSeachBorder layer] setBorderWidth:1.5f];
    [[self.lblSeachBorder layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    [[self.lblSeachBorder layer] setCornerRadius:20.0f];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(BOOL)prefersStatusBarHidden
{
    return NO;
}
- (void)didReceiveMemoryWarning {
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


@end
