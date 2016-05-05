//
//  SubCategoryViewCell.h
//  AFStore
//
//  Created by Suhas on 11/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubCategoryViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgSubCateImage;

@property (strong, nonatomic) IBOutlet UILabel *lblSubCateName;

@property(nonatomic,retain)NSMutableDictionary *cellDict;

@end
