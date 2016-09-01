//
//  GalleryPhotoViewController.h
//  AFStoreNew
//
//  Created by rac on 07/07/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewCell.h"
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "Localization.h"
#import "EXPhotoViewer.h"
#import "ContactUSViewController.h"


@interface GalleryPhotoViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
{
    
    dispatch_queue_t  queue;

    PhotoViewCell *tempCell;

    NSMutableArray * photoArray;
    
}
@property (strong, nonatomic) IBOutlet UICollectionView *photoCollectionView;

@property (strong, nonatomic) IBOutlet UILabel *lblbranchName;


@property(readwrite)NSNumber *GallryID;

@property(strong,nonatomic)NSString *GallryName;


//For Getting Parsed Response

@property(strong,nonatomic)NSString * ThumbUrl;
@property(strong,nonatomic)NSString * Description;
@property(strong,nonatomic)NSString * FileName;


@end
