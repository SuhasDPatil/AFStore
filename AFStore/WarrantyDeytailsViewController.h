//
//  WarrantyDeytailsViewController.h
//  AFStoreNew
//
//  Created by rac on 07/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPhotoViewer.h"
#import "Localization.h"

@interface WarrantyDeytailsViewController : UIViewController<UIWebViewDelegate>


@property(strong,nonatomic)NSString * getLink;
@property(strong,nonatomic)NSString * btnInfo;

@property(strong,nonatomic)NSString *tab1;
@property(strong,nonatomic)NSString *tab2;


@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentView;


@property (strong, nonatomic) IBOutlet UIImageView *imgWarrantyImage;

@property (strong, nonatomic) IBOutlet UILabel *lblDetailsText;

@property (strong, nonatomic) IBOutlet UIButton *btnImagView;



- (IBAction)tabChanged:(id)sender;

- (IBAction)btnImageClicked:(id)sender;




@end
