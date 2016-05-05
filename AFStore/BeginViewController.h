//
//  BeginViewController.h
//  AFStore
//
//  Created by Suhas on 10/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryViewController.h"
#import "Localization.h"


#import "HomeMViewController.h"
#import "CategoryViewController.h"
#import "HotOfferCategoryViewController.h"
#import "MostPopularViewController.h"
#import "NewsViewController.h"
#import "SearchViewController.h"
#import "GalleryViewController.h"
#import "AboutUSViewController.h"
#import "ContactUSViewController.h"
#import "WarrantyViewController.h"
#import "ChkYrPhoneViewController.h"



@interface BeginViewController : UIViewController





@property (strong, nonatomic) IBOutlet UIButton *btnEnglish;

@property (strong, nonatomic) IBOutlet UIButton *btnArabic;



@property (strong, nonatomic) IBOutlet UIButton *btnHome;

@property (strong, nonatomic) IBOutlet UIButton *btnStore;

@property (strong, nonatomic) IBOutlet UIButton *btnSearch;

@property (strong, nonatomic) IBOutlet UIButton *btnHotOffer;

@property (strong, nonatomic) IBOutlet UIButton *btnMostPopular;

@property (strong, nonatomic) IBOutlet UIButton *btnNews;

@property (strong, nonatomic) IBOutlet UIButton *btnAboutUs;

@property (strong, nonatomic) IBOutlet UIButton *btnGallery;

@property (strong, nonatomic) IBOutlet UIButton *btnContactUs;

@property (strong, nonatomic) IBOutlet UIButton *btnWarranty;

@property (strong, nonatomic) IBOutlet UIButton *btnCheckYourPhone;

@property (strong, nonatomic) IBOutlet UIButton *btnOtherServices;

@property (strong, nonatomic) IBOutlet UIButton *btnExit;




@property (strong, nonatomic) IBOutlet UILabel *lblHome;

@property (strong, nonatomic) IBOutlet UILabel *lblStore;

@property (strong, nonatomic) IBOutlet UILabel *lblSearch;

@property (strong, nonatomic) IBOutlet UILabel *lblHotOffer;

@property (strong, nonatomic) IBOutlet UILabel *lblMostPopular;

@property (strong, nonatomic) IBOutlet UILabel *lblNews;

@property (strong, nonatomic) IBOutlet UILabel *lblAboutUs;

@property (strong, nonatomic) IBOutlet UILabel *lblGallery;

@property (strong, nonatomic) IBOutlet UILabel *lblContactUs;

@property (strong, nonatomic) IBOutlet UILabel *lblWarranty;

@property (strong, nonatomic) IBOutlet UILabel *lblCheckYourPhone;

@property (strong, nonatomic) IBOutlet UILabel *lblOtherServices;


- (IBAction)englishClicked:(id)sender;

- (IBAction)arabicClicked:(id)sender;



- (IBAction)homeClicked:(id)sender;

- (IBAction)storeClicked:(id)sender;

- (IBAction)searchClicked:(id)sender;

- (IBAction)hotOfferClicked:(id)sender;

- (IBAction)mostPopularClicked:(id)sender;

- (IBAction)newsClicked:(id)sender;

- (IBAction)aboutUsClicked:(id)sender;

- (IBAction)galleryClicked:(id)sender;

- (IBAction)contactUsClicked:(id)sender;

- (IBAction)warrantyClicked:(id)sender;

- (IBAction)CheckYourPhoneClicked:(id)sender;

- (IBAction)otherServicesClicked:(id)sender;

- (IBAction)exitClicked:(id)sender;




@end
