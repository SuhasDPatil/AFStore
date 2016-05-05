//
//  MostPopularViewController.h
//  AFStoreNew
//
//  Created by rac on 03/07/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewCell.h"

#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "ProductDetailViewController.h"


@interface MostPopularViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
{
    NSMutableArray *MostPArray;
    
    dispatch_queue_t  queue;
    
    ProductViewCell *tempCell;
    
}



@property(nonatomic,strong)IBOutlet UICollectionView * collection;





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




@end
