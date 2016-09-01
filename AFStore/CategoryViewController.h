//
//  CategoryViewController.h
//  AFStore
//
//  Created by Suhas on 11/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryViewCell.h"
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "SubCategoryViewController.h"
#import "Localization.h"


@interface CategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray * CategoryListArray;
    CategoryViewCell *tempCell;
    
    dispatch_queue_t  queue;

}


//FOr storing of Parsed Response
@property(strong,nonatomic)NSNumber * CategoriesID;
@property(strong,nonatomic)NSString * CategoriesName;
@property(strong,nonatomic)NSString * CategoryImages;

@property (strong, nonatomic) IBOutlet UITableView *tableView;




@end
