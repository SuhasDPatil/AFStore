//
//  SubCategoryViewController.h
//  AFStore
//
//  Created by Suhas on 11/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubCategoryViewCell.h"
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "CategoryViewController.h"
#import "ProductViewController.h"
@interface SubCategoryViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray * subCategoryListArray;
    
    SubCategoryViewCell *tempCell;
    
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@property(readwrite)NSNumber *CatID;

@property(strong,nonatomic)NSString *cateName;


@property(strong,nonatomic)NSString *catImageName;


//FOr storing of Parsed Restaurant Response

@property(strong,nonatomic)NSString *CategoriesID;
@property(strong,nonatomic)NSString *CategoriesName;
@property(strong,nonatomic)NSString *SubCategoriesID;
@property(strong,nonatomic)NSString *SubCategoriesName;



@end
