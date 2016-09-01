//
//  GalleryVideoViewController.h
//  AFStoreNew
//
//  Created by rac on 27/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VideoTableViewCell.h"
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "VideoViewController.h"
#import "XCDYouTubeVideoPlayerViewController.h"
#import "Localization.h"
#import "ContactUSViewController.h"

@interface GalleryVideoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    dispatch_queue_t  queue;

    NSMutableArray * VideoListArray;
    VideoTableViewCell *tempCell;
}



//FOr storing of Parsed Response
@property(strong,nonatomic)NSNumber * ThumbUrl;
@property(strong,nonatomic)NSString * FileName;

@property (strong, nonatomic) IBOutlet UITableView *Tabview;





@property(nonatomic,strong)MPMoviePlayerViewController * video;


@end
