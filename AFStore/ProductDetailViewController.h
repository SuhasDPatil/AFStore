//
//  ProductDetailViewController.h
//  AFStore
//
//  Created by Suhas on 12/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Social/Social.h>

#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "ContactUSViewController.h"
#import "ProductImageViewCell.h"
#import "ProductDetailTableViewCell.h"
#import "EXPhotoViewer.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface ProductDetailViewController : UIViewController< UIAlertViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    dispatch_queue_t queue ;
    NSMutableArray * ProductDetailArray;
    BOOL isfirstTimeTransform;
    NSMutableArray * ProductsImageArray;
    ProductImageViewCell *tempCellIm;
    
}


@property (strong, nonatomic) IBOutlet UIButton *btnTweeter;
@property (strong, nonatomic) IBOutlet UIButton *btnFacebook;
@property (strong, nonatomic) IBOutlet UILabel *lblProductCost;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableViewDet;




//outlets for if all image array gets false
@property (strong, nonatomic) IBOutlet UILabel *lblBorder1;
@property (strong, nonatomic) IBOutlet UILabel *lblBorder2;
@property (strong, nonatomic) IBOutlet UIImageView *imgProdImage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) IBOutlet UIButton *btnImageView;


//GetData from Product Listing
@property(strong,nonatomic)NSString * ProductName_title;
@property(strong,nonatomic)NSString * mobile_ID;


@property(strong,nonatomic)NSString * subCateName;
@property(strong,nonatomic)NSString * productName;
@property(strong,nonatomic)NSNumber *  productID;
@property(strong,nonatomic)NSString *  prodimage;
@property(strong,nonatomic)NSString *  prodFree1;
@property(strong,nonatomic)NSString *  prodcost;


@property(strong,nonatomic)NSString * detStrFinalBackView;



@property(strong,nonatomic)NSString * splitString;



//Save Parsed Response
@property(nonatomic,strong)NSString * ProductDetailsInfo;

//Save parse Response for get product image webservice
@property(nonatomic,strong)NSString * ProductImage;



- (IBAction)postToTweeter:(id)sender;


- (IBAction)posttoFacebook:(id)sender;


- (IBAction)btnImageClicked:(id)sender;



@end
