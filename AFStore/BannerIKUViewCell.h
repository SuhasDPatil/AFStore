//
//  BannerIKUViewCell.h
//  AFStore
//
//  Created by rac on 19/05/16.
//  Copyright © 2016 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerIKUViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgBannerImage;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorV;

@property(nonatomic,retain)NSMutableDictionary *cellDict;

@end
