//
//  PhotoViewCell.m
//  AFStoreNew
//
//  Created by rac on 07/07/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "PhotoViewCell.h"

@implementation PhotoViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)cellSectctClicked:(id)sender
{
    
    [EXPhotoViewer showImageFrom:self.imgPhoto];

}
@end
