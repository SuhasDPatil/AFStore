//
//  DetailNewsViewController.h
//  AFStore
//
//  Created by Suhas on 16/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

#import "NSString+HTML.h"
#import "Constant.h"
#import "AFAppAPIClient.h"
#import "MBProgressHUD.h"
#import "Localization.h"
#import "EXPhotoViewer.h"
#import "ContactUSViewController.h"



#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface DetailNewsViewController : UIViewController<UIAlertViewDelegate>
{
    dispatch_queue_t queue ;
    NSMutableArray * NewsListArray;

}
@property (strong, nonatomic) IBOutlet UILabel *lblNewsTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgNewsImage;

//@property (strong, nonatomic) IBOutlet UITextView *txtNewsSummery;

@property (strong, nonatomic) IBOutlet UILabel *lblPubDate;
@property (strong, nonatomic) IBOutlet UILabel *lblSummary;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) IBOutlet UILabel *lblNoOfViews;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) IBOutlet UILabel *lblShareOn;



@property(nonatomic,strong)NSString *newsTitle;
@property(nonatomic,strong)NSString *newssummery;
@property(nonatomic,strong)NSString *newsPubDate;
@property(nonatomic,strong)NSString *newsExpDate;
@property(nonatomic,strong)NSString *newsImage;
@property(nonatomic,strong)NSString *newsArticleID;
@property(nonatomic,strong)NSString *newsNoOfViews;

//FOr storing of Parsed Response
@property(strong,nonatomic)NSString * Article;
@property(strong,nonatomic)NSNumber * NumberOfViews;


- (IBAction)viewImageClicked:(id)sender;

- (IBAction)FBShareClicked:(id)sender;

- (IBAction)TweetClicked:(id)sender;




@end
