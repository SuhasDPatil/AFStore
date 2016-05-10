//
//  DashboardViewController.h
//  AFStore
//
//  Created by rac on 04/05/16.
//  Copyright © 2016 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Localization.h"

#import "PopMenu.h"


#import "HomeMViewController.h"
#import "CategoryViewController.h"
#import "SubCategoryViewController.h"
#import "HotOfferCategoryViewController.h"
#import "MostPopularViewController.h"
#import "NewsViewController.h"
#import "SearchViewController.h"
#import "GalleryViewController.h"
#import "AboutUSViewController.h"
#import "ContactUSViewController.h"
#import "WarrantyViewController.h"
#import "ChkYrPhoneViewController.h"

@interface DashboardViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, strong) PopMenu *popMenu;

@property(nonatomic,strong)NSUserDefaults * defaults;

@end
