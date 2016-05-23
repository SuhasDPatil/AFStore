//
//  GalleryBranchViewController.h
//  AFStoreNew
//
//  Created by rac on 10/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryViewCell.h"
#import "GalleryPhotoViewController.h"
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "Localization.h"
#import "ContactUSViewController.h"


@interface GalleryBranchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * BranchListArray;
    CategoryViewCell *tempCell;
    
    dispatch_queue_t  queue;
    
}


//FOr storing of Parsed Response
@property(strong,nonatomic)NSNumber * CategoryID;
@property(strong,nonatomic)NSString * GalleryDescription;
@property(strong,nonatomic)NSString * GalleryID;
@property(strong,nonatomic)NSString * GalleryName;
@property(strong,nonatomic)NSString * ImagesCount;



@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
