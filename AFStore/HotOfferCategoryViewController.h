//
//  HotOfferCategoryViewController.h
//  AFStoreNew
//
//  Created by rac on 06/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "HotOfferCategoriesViewCell.h"
#import "HotOfferViewController.h"
#import "Localization.h"
@interface HotOfferCategoryViewController : UIViewController<UIAlertViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *CategoryArray;
    
    HotOfferCategoriesViewCell *tempCell;
    
    dispatch_queue_t  queue;

}


@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


//for getting Response

@property(strong,nonatomic)NSString * GalleryID;
@property(strong,nonatomic)NSString * GalleryName;
@property(strong,nonatomic)NSString * NumberOfViews;

@property(strong,nonatomic)NSString * PortalID;
@property(strong,nonatomic)NSString * Image;

@end
