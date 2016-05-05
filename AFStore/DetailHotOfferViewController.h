//
//  DetailHotOfferViewController.h
//  AFStoreNew
//
//  Created by rac on 19/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>


#import "Constant.h"
#import "EXPhotoViewer.h"


#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface DetailHotOfferViewController : UIViewController
{
    dispatch_queue_t queue ;

}

@property (strong, nonatomic) IBOutlet UIImageView *imgHotOfferImage;



@property (strong, nonatomic) IBOutlet UILabel *lblTitleHotOffer;

@property (strong, nonatomic) IBOutlet UILabel *lblNoOfViews;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;





@property(nonatomic,strong)NSString *offerCatTitle;
@property(nonatomic,strong)NSString *NoOfViews;
@property(nonatomic,strong)NSString *offerImage;


- (IBAction)viewImageClicked:(id)sender;

- (IBAction)FBShareClicked:(id)sender;

- (IBAction)TweeterClicked:(id)sender;



@end
