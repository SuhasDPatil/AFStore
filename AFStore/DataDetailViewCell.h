//
//  DataDetailViewCell.h
//  AFStore
//
//  Created by rac on 17/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataDetailViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblGPRS;

@property (strong, nonatomic) IBOutlet UILabel *lblEDGE;

@property (strong, nonatomic) IBOutlet UILabel *lblSpeed;

@property (strong, nonatomic) IBOutlet UILabel *lblWLAN;

@property (strong, nonatomic) IBOutlet UILabel *lblBluetooth;

@property (strong, nonatomic) IBOutlet UILabel *lblNFC;

@property (strong, nonatomic) IBOutlet UILabel *lblUSB;



@end
