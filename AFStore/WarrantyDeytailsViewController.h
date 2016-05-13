//
//  WarrantyDeytailsViewController.h
//  AFStoreNew
//
//  Created by rac on 07/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPhotoViewer.h"
#import "Localization.h"

@interface WarrantyDeytailsViewController : UIViewController<UIWebViewDelegate,NSLayoutManagerDelegate  >


@property(strong,nonatomic)NSString * warrantyData;
@property(strong,nonatomic)NSString * strTitle;

@property(nonatomic,strong)NSUserDefaults * defaults;
@property(nonatomic,strong)NSString * selectedLang;

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) IBOutlet UITextView *textView;



@end
