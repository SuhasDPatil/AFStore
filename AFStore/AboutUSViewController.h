//
//  AboutUSViewController.h
//  AFStore 
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Localization.h"
@interface AboutUSViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *txtViewInfo;

@property (strong, nonatomic) IBOutlet UIButton *btnAboutUs;

@property (strong, nonatomic) IBOutlet UIButton *btnQualityPolicy;

@property (strong, nonatomic) IBOutlet UIButton *btnVisionMission;




- (IBAction)aboutUsClicked:(id)sender;

- (IBAction)qualityPoClicked:(id)sender;

- (IBAction)visionMiClicked:(id)sender;





@end
