//
//  ContactUSViewController.h
//  AFStore 
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Localization.h"
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"

@interface ContactUSViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;

@property (strong, nonatomic) IBOutlet UITextField *txtLastName;

@property (strong, nonatomic) IBOutlet UITextField *txtMobileNo;

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;

@property (strong, nonatomic) IBOutlet UITextField *txtMessage;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentInqType;

@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;


- (IBAction)submitClicked:(id)sender;


@end
