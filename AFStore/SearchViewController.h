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
//#import "NSString+HTML.h"
#import "Localization.h"
#import "ProductDetailViewController.h"
@interface SearchViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,UIAlertViewDelegate>
{
    dispatch_queue_t  queue;

    NSMutableArray * SearchListArray;
    SearchProductViewCell *tempCell;

}

//FOr storing of Parsed Search Product Response
@property(strong,nonatomic)NSString * Details;
@property(strong,nonatomic)NSString * ProductID;
@property(strong,nonatomic)NSString * ProductImage;
@property(strong,nonatomic)NSString * ProductName;
@property(strong,nonatomic)NSString * ProductCost;
@property(strong,nonatomic)NSString * Free1;





@property (strong, nonatomic) NSMutableArray* filteredTableData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar2;
@property (nonatomic, assign) bool isFiltered;



@property (strong, nonatomic) NSString *txtSearch;





@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;





@end
