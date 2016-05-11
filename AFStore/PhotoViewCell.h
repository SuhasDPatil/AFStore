//
//  PhotoViewCell.h
//  AFStoreNew
//
//  Created by rac on 07/07/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPhotoViewer.h"

@interface PhotoViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;


@property (strong, nonatomic) IBOutlet UIButton *btnPhotoSelect;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorV;


@property(nonatomic,retain)NSMutableDictionary *cellDict;







- (IBAction)cellSectctClicked:(id)sender;

@end
