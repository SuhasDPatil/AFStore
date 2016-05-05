//
//  SearchProductViewCell.h
//  AFStore
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchProductViewCell : UICollectionViewCell


@property (strong, nonatomic) IBOutlet UILabel *lblProductName;

@property (strong, nonatomic) IBOutlet UIImageView *imgProductImage;

@property(nonatomic,retain)NSMutableDictionary *cellDict;



@end
