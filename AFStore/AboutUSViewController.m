//
//  AboutUSViewController.m
//  AFStore 
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "AboutUSViewController.h"

@interface AboutUSViewController ()

@end

@implementation AboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=LocalizedString(@"Ayn Al Fahad Company");
    
    self.btnAboutUs.backgroundColor=[UIColor orangeColor];
//    self.txtViewInfo.text=LocalizedString(@"About_Us");
//    [_webView loadHTMLString:[NSString stringWithFormat:@"<div style='text-align:right'>%@<div>",con] baseURL:nil];
    self.txtViewInfo.text=LocalizedString(@"About_Us");
    [self.btnAboutUs setTitle:LocalizedString(@"About_us") forState:UIControlStateNormal];
    [self.btnQualityPolicy setTitle:LocalizedString(@"Quality Policy") forState:UIControlStateNormal];
    [self.btnVisionMission setTitle:LocalizedString(@"Vision Mission") forState:UIControlStateNormal];
        
    
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


- (IBAction)aboutUsClicked:(id)sender
{
    
    
    
    self.txtViewInfo.text=LocalizedString(@"About_Us");
    
    self.btnAboutUs.backgroundColor=[UIColor orangeColor];
    self.btnQualityPolicy.backgroundColor=[UIColor darkGrayColor];
    self.btnVisionMission.backgroundColor=[UIColor darkGrayColor];
    
    
}

- (IBAction)qualityPoClicked:(id)sender
{

    self.txtViewInfo.text=LocalizedString(@"Quality_Policy");

    self.btnAboutUs.backgroundColor=[UIColor darkGrayColor];
    self.btnQualityPolicy.backgroundColor=[UIColor orangeColor];
    self.btnVisionMission.backgroundColor=[UIColor darkGrayColor];

    
}

- (IBAction)visionMiClicked:(id)sender
{

    self.txtViewInfo.text=LocalizedString(@"Vision_Mission");

    self.btnAboutUs.backgroundColor=[UIColor darkGrayColor];
    self.btnQualityPolicy.backgroundColor=[UIColor darkGrayColor];
    self.btnVisionMission.backgroundColor=[UIColor orangeColor];

}

-(void)languageDetected
{
//    NSString *preferredLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
//    
//    if ([preferredLanguage isEqualToString:@"ar"])
//    {
//        self.txtViewInfo.textAlignment=NSTextAlignmentCenter;
//    }
//    else
//    {
//        self.txtViewInfo.textAlignment=NSTextAlignmentCenter;
//    }
    
////    NSString *asdf=(NSString *)[LocalizationSetLanguage(@"en")];
//    
//    if (asdf)
//    {
//        
//        self.txtViewInfo.textAlignment=NSTextAlignmentLeft;
//    }
//    else
//    {
//        self.txtViewInfo.textAlignment=NSTextAlignmentRight;
//    }
    
    
}

@end
