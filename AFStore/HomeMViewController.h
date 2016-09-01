//
//  HomeMViewController.h
//  AFStore
//
//  Created by Suhas on 16/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOScrollerView.h"
#import "Localization.h"
#import "ContactUSViewController.h"

#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "NSString+HTML.h"
#import "HotOfferViewController.h"

#import "SearchViewController.h"
#import "ProductViewController.h"

#import "BannerIKUViewCell.h"

#import <JTMaterialSpinner/JTMaterialSpinner.h>

@interface HomeMViewController : UIViewController<ValueClickDelegate,UIAlertViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    dispatch_queue_t queue ;
    
    NSMutableArray * SlidingImageArray;
    NSMutableArray * SlidingHotDealImageArray;
    NSMutableArray * BannerImageArray;
    
    BannerIKUViewCell *tempCellIm;

}
@property(nonatomic,strong)NSString * selectedLanguage;


@property (weak, nonatomic) IBOutlet JTMaterialSpinner *spinnerView;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


//Slide Image web-Service
@property(strong,nonatomic)NSString * imgNameSli;

//Slide Image web-Service Hot Deals
@property(strong,nonatomic)NSString * FileName;

//Banner Image web-Service Hot Deals
@property(strong,nonatomic)NSString *BrandID;
@property(strong,nonatomic)NSString *Img;
@property(strong,nonatomic)NSString *Brand;

@property (strong, nonatomic) IBOutlet UIView *slideView;


@property (strong, nonatomic) IBOutlet UIView *slideViewHotDeals;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIButton *btnIKU;

@property (strong, nonatomic) IBOutlet UIButton *btnSearch;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;


@property (strong, nonatomic) IBOutlet UILabel *lblAboutUsInfo;
@property (strong, nonatomic) IBOutlet UILabel *lblHotDeals;
@property (strong, nonatomic) IBOutlet UILabel *lblAbout;


- (IBAction)searchClicked:(id)sender;

- (IBAction)IKUClicked:(id)sender;

@end
