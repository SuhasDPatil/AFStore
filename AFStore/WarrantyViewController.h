//
//  WarrantyViewController.h
//  AFStoreNew
//
//  Created by rac on 07/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WarrantyDeytailsViewController.h"
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "Localization.h"
@interface WarrantyViewController : UIViewController
{
    WarrantyDeytailsViewController * wdvc;
    
    NSMutableArray *goldArray, *silverArray, *diamondArray;

}

//Store Parsed Respomse

@property (strong, nonatomic) NSString * tempGold;
@property (strong, nonatomic) NSString * tempSilver;
@property (strong, nonatomic) NSString * tempDiamond;


@property (strong, nonatomic) NSString * diamond;
@property (strong, nonatomic) NSString * gold;
@property (strong, nonatomic) NSString * silver;



@property (strong, nonatomic) IBOutlet UIButton *btnDiamondG;

@property (strong, nonatomic) IBOutlet UIButton *btnGoldG;

@property (strong, nonatomic) IBOutlet UIButton *btnSliverG;


@property (strong, nonatomic) IBOutlet UILabel *lblDiamond;

@property (strong, nonatomic) IBOutlet UILabel *lblGold;

@property (strong, nonatomic) IBOutlet UILabel *lblSilver;

@property (strong, nonatomic) IBOutlet UILabel *lblGuarranty1;

@property (strong, nonatomic) IBOutlet UILabel *lblGuarranty2;

@property (strong, nonatomic) IBOutlet UILabel *lblGuarranty3;






- (IBAction)diamondGClicked:(id)sender;

- (IBAction)goldGClicked:(id)sender;

- (IBAction)silverGClicked:(id)sender;

@end
