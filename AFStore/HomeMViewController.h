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

#import "HotOfferCollectionViewCell.h"
#import "NewsTableViewCell.h"

#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "NSString+HTML.h"
#import "DetailNewsViewController.h"
#import "HotOfferViewController.h"

@interface HomeMViewController : UIViewController<ValueClickDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    dispatch_queue_t queue ;
    
    NSMutableArray * SlidingImageArray;
    NSMutableArray * NewsListArray;
    NewsTableViewCell *tempCell;
    
    NSMutableArray * HotOfferListArray;
    HotOfferCollectionViewCell *tempCellHot;

    
    
}
@property(nonatomic,strong)NSString * selectedLanguage;

//FOr storing of Parsed Response




//News Web Service
@property(strong,nonatomic)NSString * NewsTitle;
@property(strong,nonatomic)NSString * PublishDate;
@property(strong,nonatomic)NSString * ExpireDate;
@property(strong,nonatomic)NSString * Summary;
@property(strong,nonatomic)NSString * ArticleImage;

//Hot Offers Service
@property(strong,nonatomic)NSString * GalleryID;
@property(strong,nonatomic)NSString * GalleryName;
@property(strong,nonatomic)NSNumber * NumberOfViews;
@property(strong,nonatomic)NSString * PortalID;
@property(strong,nonatomic)NSString * Image;

//Slide Image Service
@property(strong,nonatomic)NSString * imgNameSli;






@property (strong, nonatomic) IBOutlet UICollectionView *collViewHotOffers;

@property (strong, nonatomic) IBOutlet UITableView *tableViewNews;




@property (strong, nonatomic) IBOutlet UIView *slideView;

@property (strong, nonatomic) IBOutlet UILabel *lblHotOffer;

@property (strong, nonatomic) IBOutlet UILabel *lblNews;



@end
