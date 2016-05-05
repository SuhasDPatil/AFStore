//
//  CategoryViewCell.h
//  AFStore
//
//  Created by Suhas on 11/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *lblCategoryName;


@property (strong, nonatomic) IBOutlet UIImageView *imgCategoryImage;

@property (strong, nonatomic) IBOutlet UIImageView *imgCountBG;

@property (strong, nonatomic) IBOutlet UILabel *lblImgCount;


@property(nonatomic,retain)NSMutableDictionary *cellDict;

@end
