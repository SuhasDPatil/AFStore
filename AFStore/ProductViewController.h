//
//  ProductViewController.h
//  AFStore 
//
//  Created by Suhas on 17/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewCell.h"
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "SubCategoryViewController.h"
#import "ProductDetailViewController.h"


@interface ProductViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate>
{
    dispatch_queue_t  queue;
    
    NSMutableArray * ProductsListArray;
    ProductViewCell *tempCell;

}



@property(readwrite)NSNumber *SubCatID;
@property(strong,nonatomic)NSString *subCateName;



@property(nonatomic,strong)NSString *detStrfinal;



//FOr storing of Parsed Response
@property(strong,nonatomic)NSString * Details;
@property(strong,nonatomic)NSString * ProductID;
@property(strong,nonatomic)NSString * ProductImage;
@property(strong,nonatomic)NSString * ProductName;
@property(strong,nonatomic)NSString * Free1;
@property(strong,nonatomic)NSString * ProductCost;




@property (strong, nonatomic) IBOutlet UICollectionView *collectionview;



@end
