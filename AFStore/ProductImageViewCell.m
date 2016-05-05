//
//  ProductImageViewCell.m
//  AFStoreNew
//
//  Created by rac on 16/07/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "ProductImageViewCell.h"

@implementation ProductImageViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)imgViewClicked:(id)sender
{
    [EXPhotoViewer showImageFrom:self.imgProductImage];
}
@end


