//
//  ProductImageViewCell.h
//  AFStoreNew
//
//  Created by rac on 16/07/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPhotoViewer.h"
@interface ProductImageViewCell : UICollectionViewCell


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (strong, nonatomic) IBOutlet UIImageView *imgProductImage;

@property (strong, nonatomic) IBOutlet UILabel *lblPhotoCount;

@property (strong, nonatomic) IBOutlet UIButton *btnImageView;







@property(nonatomic,retain)NSMutableDictionary *cellDict;

- (IBAction)imgViewClicked:(id)sender;

@end
