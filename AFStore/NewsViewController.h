//
//  NewsViewController.h
//  AFStore
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsViewCell.h"
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "ContactUSViewController.h"
#import "DetailNewsViewController.h"
#import "Localization.h"
@interface NewsViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
{
    
    dispatch_queue_t queue ;

    
    NSMutableArray * NewsListArray;
    NewsViewCell *tempCell;
    
}

@property(nonatomic,strong)NSString * selectedLanguage;

//FOr storing of Parsed Response
@property(strong,nonatomic)NSString * NewsTitle;
@property(strong,nonatomic)NSString * PublishDate;
@property(strong,nonatomic)NSString * ExpireDate;
@property(strong,nonatomic)NSString * Summary;
@property(strong,nonatomic)NSString * ArticleImage;
@property(strong,nonatomic)NSString * ArticleID;
@property(strong,nonatomic)NSNumber * NumberOfViews;







@property (strong, nonatomic) IBOutlet UICollectionView *view;






@end
