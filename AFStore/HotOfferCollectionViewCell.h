//
//  HotOfferCollectionViewCell.h
//  AFStore
//
//  Created by Suhas on 16/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotOfferCollectionViewCell : UICollectionViewCell


@property (strong, nonatomic) IBOutlet UIImageView *imgHotOffer;

@property (strong, nonatomic) IBOutlet UILabel *lbltitleHotOffer;




@property(nonatomic,retain)NSMutableDictionary *cellDictHot;


@end
