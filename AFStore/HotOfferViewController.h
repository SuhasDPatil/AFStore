//
//  HotOfferViewController.h
//  AFStoreNew
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfferViewCell.h"
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "DetailHotOfferViewController.h"
#import "Localization.h"
@interface HotOfferViewController : UIViewController<UIAlertViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    dispatch_queue_t  queue;
    
    NSMutableArray * HotOfferListArray;
    OfferViewCell *tempCell;
    
}

//FOr storing of Parsed Response
//@property(strong,nonatomic)NSString * HOTitle;
//@property(strong,nonatomic)NSString * ThumbUrl;
//@property(strong,nonatomic)NSString * Description;
@property(strong,nonatomic)NSString * FileName;
@property(strong,nonatomic)NSString * NumberOfViews;

//@property(strong,nonatomic)NSString * Image;



@property (strong, nonatomic) IBOutlet UICollectionView *collectionview;



@property(strong,nonatomic)NSString * GalleryID;
@property(strong,nonatomic)NSString * GalleryName;

@end
