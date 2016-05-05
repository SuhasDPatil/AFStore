//
//  OfferViewCell.h
//  AFStoreNew
//
//  Created by rac on 06/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferViewCell : UICollectionViewCell


@property (strong, nonatomic) IBOutlet UIImageView *imgOfferIMage;

@property (strong, nonatomic) IBOutlet UILabel *lblNoOfViews;




@property(nonatomic,retain)NSMutableDictionary *cellDict;



@end
