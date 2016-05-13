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

@property(nonatomic,strong) NSString * shareImageURL;




@property (strong, nonatomic) IBOutlet UILabel *lblLabPrice;

@property (strong, nonatomic) IBOutlet UILabel *lblShareOn;




@property (strong, nonatomic) IBOutlet UIButton *btnTweeter;
@property (strong, nonatomic) IBOutlet UIButton *btnFacebook;


@property (strong, nonatomic) IBOutlet UILabel *lblProductCost;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableViewDet;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segWarranty;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;


//outlets for if all image array gets false
@property (strong, nonatomic) IBOutlet UILabel *lblBorder1;
@property (strong, nonatomic) IBOutlet UILabel *lblBorder2;
@property (strong, nonatomic) IBOutlet UIImageView *imgProdImage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) IBOutlet UIButton *btnImageView;


//GetData from Product Listing
@property(strong,nonatomic)NSString * ProductName_title;
@property(strong,nonatomic)NSString * mobile_ID;
@property(strong,nonatomic)NSString * gold_Price;
@property(strong,nonatomic)NSString * silver_Price;
@property(strong,nonatomic)NSString * diamond_Price;
@property(strong,nonatomic)NSString * photo_path;





@property(strong,nonatomic)NSString * detStrFinalBackView;



@property(strong,nonatomic)NSString * splitString;



//Save Parsed Response
@property(nonatomic,strong)NSString * ProductDetailsInfo;


//Save parse Response for get product image webservice
@property(nonatomic,strong)NSString * ProductImage;

//save parse response for get product details webservice
@property(nonatomic,strong)NSString * Battery;
@property(nonatomic,strong)NSString * Bluetooth;
@property(nonatomic,strong)NSString * BrandModel;
@property(nonatomic,strong)NSString * BrandName;
@property(nonatomic,strong)NSString * ColorName;
@property(nonatomic,strong)NSString * Condition;
@property(nonatomic,strong)NSString * Description;
@property(nonatomic,strong)NSString * DisplaySize;
@property(nonatomic,strong)NSString * FM_Radio;
@property(nonatomic,strong)NSString * DisplayType;
@property(nonatomic,strong)NSString * GPS;
@property(nonatomic,strong)NSString * Memory;
@property(nonatomic,strong)NSString * Multitouch;
@property(nonatomic,strong)NSString * OperatingSystem;
@property(nonatomic,strong)NSString * Price;
@property(nonatomic,strong)NSString * PrimaryCamera;
@property(nonatomic,strong)NSString * Processor;
@property(nonatomic,strong)NSString * Ram;
@property(nonatomic,strong)NSString * SecondaryCamera;
@property(nonatomic,strong)NSString * SimType;
@property(nonatomic,strong)NSString * Sound;
@property(nonatomic,strong)NSString * TouchScreen;
@property(nonatomic,strong)NSString * USB;



- (IBAction)postToTweeter:(id)sender;

- (IBAction)posttoFacebook:(id)sender;

- (IBAction)btnImageClicked:(id)sender;

- (IBAction)warrantyChanged:(id)sender;


@end
