//
//  VideoViewController.h
//  AFStoreNew
//
//  Created by rac on 02/04/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface VideoViewController : UIViewController


@property(nonatomic,strong)NSString * videoURL;

@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;

@end
