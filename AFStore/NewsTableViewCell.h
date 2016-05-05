//
//  NewsTableViewCell.h
//  AFStoreNew
//
//  Created by rac on 13/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *imgNewsImage;

@property (strong, nonatomic) IBOutlet UILabel *lblNewsTitle;

@property (strong, nonatomic) IBOutlet UILabel *lblNewsSummery;

@property (strong, nonatomic) IBOutlet UILabel *lblNewsPubDate;



@property(nonatomic,retain)NSMutableDictionary *cellDict;


@end
