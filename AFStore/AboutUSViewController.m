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
    
    _defaults=[NSUserDefaults standardUserDefaults];
    
    self.btnAboutUs.backgroundColor=[UIColor orangeColor];
//    self.txtViewInfo.text=LocalizedString(@"About_Us");
//    [_webView loadHTMLString:[NSString stringWithFormat:@"<div style='text-align:right'>%@<div>",con] baseURL:nil];
    [self.btnAboutUs setTitle:LocalizedString(@"About_us") forState:UIControlStateNormal];
    [self.btnQualityPolicy setTitle:LocalizedString(@"Quality Policy") forState:UIControlStateNormal];
    [self.btnVisionMission setTitle:LocalizedString(@"Vision Mission") forState:UIControlStateNormal];
        
    [self AboutWebService];
    
    [self setNavBar];
    self.txtViewInfo.textAlignment=NSTextAlignmentNatural;

    _selectedLang=[_defaults valueForKey:@"Language"];
    

    if ([self.txtViewInfo baseWritingDirectionForPosition:[self.txtViewInfo beginningOfDocument] inDirection:UITextStorageDirectionForward] == UITextWritingDirectionLeftToRight)
    {
        self.txtViewInfo.textAlignment=NSTextAlignmentLeft;
    }
    else
    {
        self.txtViewInfo.textAlignment=NSTextAlignmentRight;
    }

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

#pragma mark ButtonClick Methods
- (IBAction)aboutUsClicked:(id)sender
{
    
    
    if ([_selectedLang isEqualToString:@"Arabic"])
    {
//        self.txtViewInfo.textAlignment=NSTextAlignmentRight;

        self.txtViewInfo.text=_AboutUs_AR;
        
        [self.webView loadHTMLString:[NSString stringWithFormat:@"<div align='right'>%@</div>",_AboutUs_AR] baseURL:nil];
        
    }
    else
    {
//        self.txtViewInfo.textAlignment=NSTextAlignmentRight;

        self.txtViewInfo.text=_AboutUs_EN;
        [self.webView loadHTMLString:[NSString stringWithFormat:@"<div align='left'>%@</div>",_AboutUs_EN] baseURL:nil];

    }

//    self.txtViewInfo.text=LocalizedString(@"About_Us");
    
    self.btnAboutUs.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:128.0f/255.0f blue:0.0f/255.0f alpha:1.0];
    self.btnQualityPolicy.backgroundColor=[UIColor darkGrayColor];
    self.btnVisionMission.backgroundColor=[UIColor darkGrayColor];
    
    
}

- (IBAction)qualityPoClicked:(id)sender
{

    if ([_selectedLang isEqualToString:@"Arabic"])
    {
//        self.txtViewInfo.textAlignment=NSTextAlignmentRight;

        self.txtViewInfo.text=_QualityP_AR;
        [self.webView loadHTMLString:[NSString stringWithFormat:@"<div align='right'>%@</div>",_QualityP_AR] baseURL:nil];
    }
    else
    {
//        self.txtViewInfo.textAlignment=NSTextAlignmentRight;

        self.txtViewInfo.text=_QualityP_EN;
        [self.webView loadHTMLString:[NSString stringWithFormat:@"<div align='justify'>%@</div>",_QualityP_EN] baseURL:nil];

    }
    self.btnAboutUs.backgroundColor=[UIColor darkGrayColor];
    self.btnQualityPolicy.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:128.0f/255.0f blue:0.0f/255.0f alpha:1.0];
    self.btnVisionMission.backgroundColor=[UIColor darkGrayColor];
}

- (IBAction)visionMiClicked:(id)sender
{

    if ([_selectedLang isEqualToString:@"Arabic"])
    {
//        self.txtViewInfo.textAlignment=NSTextAlignmentRight;

        self.txtViewInfo.text=_VisionM_AR;
        [self.webView loadHTMLString:[NSString stringWithFormat:@"<div align='right'>%@</div>",_VisionM_AR] baseURL:nil];

    }
    else
    {
//        self.txtViewInfo.textAlignment=NSTextAlignmentRight;

        self.txtViewInfo.text=_VisionM_EN;
        [self.webView loadHTMLString:[NSString stringWithFormat:@"<div align='justify'>%@</div>",_VisionM_EN] baseURL:nil];

    }
    self.btnAboutUs.backgroundColor=[UIColor darkGrayColor];
    self.btnQualityPolicy.backgroundColor=[UIColor darkGrayColor];
    self.btnVisionMission.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:128.0f/255.0f blue:0.0f/255.0f alpha:1.0];
}


#pragma mark WebService

-(void)AboutWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[AFAppAPIClient WSsharedClient] POST:API_GET_ALL_ABOUT_US
                               parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             About_EN=[[NSMutableArray alloc]init];
             About_AR=[[NSMutableArray alloc]init];
             quality_EN=[[NSMutableArray alloc]init];
             quality_AR=[[NSMutableArray alloc]init];
             vision_EN=[[NSMutableArray alloc]init];
             vision_AR=[[NSMutableArray alloc]init];
             
             About_EN=[responseObject objectForKey:@"DataAbout"];
             About_AR=[responseObject objectForKey:@"DataAboutAr"];
             quality_EN=[responseObject objectForKey:@"DataQuality"];
             quality_AR=[responseObject objectForKey:@"DataQualityAr"];
             vision_EN=[responseObject objectForKey:@"DataVision"];
             vision_AR=[responseObject objectForKey:@"DataVisionAr"];
             
             NSDictionary * aboutE = [About_EN objectAtIndex:0];
             _tempAboutUs_EN=[aboutE valueForKey:@"value"];
             
             NSDictionary * aboutA = [About_AR objectAtIndex:0];
             _tempAboutUs_AR=[aboutA valueForKey:@"value"];
             
             NSDictionary * qualityE = [quality_EN objectAtIndex:0];
             _tempQualityP_EN=[qualityE valueForKey:@"value"];
             
             NSDictionary * qualityA = [quality_AR objectAtIndex:0];
             _tempQualityP_AR=[qualityA valueForKey:@"value"];
             
             NSDictionary * visionE = [vision_EN objectAtIndex:0];            
             _tempVisionM_EN=[visionE valueForKey:@"value"];
             
             NSDictionary * visionA = [vision_AR objectAtIndex:0];
             _tempVisionM_AR=[visionA valueForKey:@"value"];
             
             
             
             
//             NSString * replacedStr=[_tempAboutUs_EN stringByReplacingOccurrencesOfString:@" " withString:@"&nbsp"];

             _AboutUs_EN=[_tempAboutUs_EN stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
             
             _AboutUs_EN=[_AboutUs_EN stringByReplacingOccurrencesOfString:@"  " withString:@"&nbsp"];


             NSLog(@"\nAbout US EN===\n%@\n\n",_AboutUs_EN);
             
             _AboutUs_AR=[_tempAboutUs_AR stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
             
             _AboutUs_AR=[_AboutUs_AR stringByReplacingOccurrencesOfString:@"  " withString:@"&nbsp"];

             
             NSLog(@"\nAbout US AR===\n%@\n\n",_AboutUs_AR);
             
             _VisionM_EN=[_tempVisionM_EN stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
             
             _VisionM_EN=[_VisionM_EN stringByReplacingOccurrencesOfString:@"  " withString:@"&nbsp"];

             
             NSLog(@"\nVision Mission EN==\n%@\n\n",_VisionM_EN);
             
             _VisionM_AR=[_tempVisionM_AR stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
             
             _VisionM_AR=[_VisionM_AR stringByReplacingOccurrencesOfString:@"  " withString:@"&nbsp"];

             
             NSLog(@"\nVision Mission AR==\n%@\n\n",_VisionM_AR);
             
             _QualityP_EN=[_tempQualityP_EN stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
             
             _QualityP_EN=[_QualityP_EN stringByReplacingOccurrencesOfString:@"  " withString:@"&nbsp"];

             
             NSLog(@"\nQuality Policy EN==\n%@\n\n",_QualityP_EN);
             
             _QualityP_AR=[_tempQualityP_AR stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
             
             _QualityP_AR=[_QualityP_AR stringByReplacingOccurrencesOfString:@"  " withString:@"&nbsp"];

             
             NSLog(@"\nQuality Policy AR==\n%@\n\n",_QualityP_AR);
             
             
             

             if ([_selectedLang isEqualToString:@"Arabic"])
             {
//                 self.txtViewInfo.textAlignment=NSTextAlignmentRight;
                 self.txtViewInfo.text=_AboutUs_AR;
                 [_webView loadHTMLString:[NSString stringWithFormat:@"<div align='right'>%@</div>",_AboutUs_AR] baseURL:nil];
             }
             else
             {
//                 self.txtViewInfo.textAlignment=NSTextAlignmentLeft;
                 self.txtViewInfo.text=_AboutUs_EN;
                 [_webView loadHTMLString:[NSString stringWithFormat:@"<div align='left'>%@</div>",_AboutUs_EN] baseURL:nil];
             }
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
