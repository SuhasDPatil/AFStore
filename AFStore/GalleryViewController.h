//
//  GalleryViewController.h
//  AFStore 
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Localization.h"
#import "GalleryBranchViewController.h"
#import "GalleryVideoViewController.h"


@interface GalleryViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIButton *btnPhotoGallery;

@property (strong, nonatomic) IBOutlet UIButton *btnVideoGallery;

@property (strong, nonatomic) IBOutlet UILabel *lblPhotoGallery;

@property (strong, nonatomic) IBOutlet UILabel *lblVideoGallery;




- (IBAction)PhotoGalleryClicked:(id)sender;

- (IBAction)VideoGalleryClicked:(id)sender;


@end
