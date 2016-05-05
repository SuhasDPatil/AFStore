//
//  HotOfferCategoriesViewCell.h
//  AFStoreNew
//
//  Created by rac on 06/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotOfferCategoriesViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblcategoriesName;

@property (strong, nonatomic) IBOutlet UIImageView *imgCategoriesImage;

@property(nonatomic,retain)NSMutableDictionary *cellDict;



@end
