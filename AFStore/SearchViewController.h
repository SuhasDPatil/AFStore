//
//  SearchViewController.h
//  AFStore 
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchProductViewCell.h"
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "ContactUSViewController.h"

#import <JTMaterialSpinner/JTMaterialSpinner.h>

#import "Localization.h"
#import "ProductDetailViewController.h"
@interface SearchViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,UIAlertViewDelegate>
{
    dispatch_queue_t  queue;

    NSMutableArray * SearchListArray;
    SearchProductViewCell *tempCell;
    UIView *nomatchesView;

}

@property(nonatomic,strong)NSUserDefaults * defaults;


@property (weak, nonatomic) IBOutlet JTMaterialSpinner *spinnerView;

//FOr storing of Parsed Search Product Response
@property(strong,nonatomic)NSString * Details;
@property(strong,nonatomic)NSString * ProductID;
@property(strong,nonatomic)NSString * ProductImage;
@property(strong,nonatomic)NSString * ProductName;
@property(strong,nonatomic)NSString * ProductCost;
@property(strong,nonatomic)NSString * Free1;


@property(strong,nonatomic)NSString * BrandID;
@property(strong,nonatomic)NSString * BrandModel;
@property(strong,nonatomic)NSString * BrandName;
@property(strong,nonatomic)NSString * ColorName;
@property(strong,nonatomic)NSString * DiamondPrice;
@property(strong,nonatomic)NSString * GoldPrice;
@property(strong,nonatomic)NSString * MobileID;
@property(strong,nonatomic)NSString * MobileStatus;
@property(strong,nonatomic)NSString * Model;
@property(strong,nonatomic)NSString * PhotoCount;
@property(strong,nonatomic)NSString * PhotoPath;
@property(strong,nonatomic)NSString * Price;
@property(strong,nonatomic)NSString * SimType;



@property (strong, nonatomic) NSMutableArray* filteredTableData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar2;
@property (nonatomic, assign) bool isFiltered;



@property (strong, nonatomic) NSString *txtSearch;



@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@end
