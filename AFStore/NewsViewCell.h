//
//  NewsViewCell.h
//  AFStore
//
//  Created by Suhas on 16/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewCell : UICollectionViewCell


@property (strong, nonatomic) IBOutlet UILabel *lblNewsTitle;

@property (strong, nonatomic) IBOutlet UIImageView *imgNewsImage;

@property (strong, nonatomic) IBOutlet UILabel *lblNewsSummery;

@property (strong, nonatomic) IBOutlet UILabel *lblPublishDate;

@property (strong, nonatomic) IBOutlet UILabel *lblNoOfViews;




@property(nonatomic,retain)NSMutableDictionary *cellDict;


@end
