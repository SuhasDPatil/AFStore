//
//  AboutUSViewController.h
//  AFStore 
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "Localization.h"
@interface AboutUSViewController : UIViewController<UITextViewDelegate>
{
    NSMutableArray *About_EN, *About_AR, *quality_EN, *quality_AR, *vision_EN, *vision_AR;
}

@property(nonatomic,strong)NSUserDefaults * defaults;
@property(nonatomic,strong)NSString * selectedLang;


@property (strong, nonatomic) IBOutlet UITextView *txtViewInfo;

@property (strong, nonatomic) IBOutlet UIButton *btnAboutUs;

@property (strong, nonatomic) IBOutlet UIButton *btnQualityPolicy;

@property (strong, nonatomic) IBOutlet UIButton *btnVisionMission;

@property (strong, nonatomic) IBOutlet UIWebView *webView;



//Store Parsed Data

@property (strong, nonatomic) NSString * tempAboutUs_EN;
@property (strong, nonatomic) NSString * tempAboutUs_AR;
@property (strong, nonatomic) NSString * tempQualityP_EN;
@property (strong, nonatomic) NSString * tempQualityP_AR;
@property (strong, nonatomic) NSString * tempVisionM_EN;
@property (strong, nonatomic) NSString * tempVisionM_AR;


@property (strong, nonatomic) NSString * AboutUs_EN;
@property (strong, nonatomic) NSString * AboutUs_AR;
@property (strong, nonatomic) NSString * QualityP_EN;
@property (strong, nonatomic) NSString * QualityP_AR;
@property (strong, nonatomic) NSString * VisionM_EN;
@property (strong, nonatomic) NSString * VisionM_AR;




- (IBAction)aboutUsClicked:(id)sender;

- (IBAction)qualityPoClicked:(id)sender;

- (IBAction)visionMiClicked:(id)sender;





@end
