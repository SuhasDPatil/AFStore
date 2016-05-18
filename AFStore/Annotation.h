//
//  Annotation.h
//  AFStore
//
//  Created by rac on 17/05/16.
//  Copyright © 2016 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Annotation : NSObject<MKAnnotation>

@property(nonatomic,assign)CLLocationCoordinate2D coordinate;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * subtitle;


@end
