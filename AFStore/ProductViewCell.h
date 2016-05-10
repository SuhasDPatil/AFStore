//
//  ProductViewCell.h
//  AFStore 
//
//  Created by Suhas on 17/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewCell : UICollectionViewCell






@property (strong, nonatomic) IBOutlet UIImageView *imgProductImage;

@property (strong, nonatomic) IBOutlet UILabel *lblProductName;

@property (strong, nonatomic) IBOutlet UILabel *lblFree1;

@property (strong, nonatomic) IBOutlet UILabel *lblProductCost;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


@property(nonatomic,retain)NSMutableDictionary *cellDict;


@end
