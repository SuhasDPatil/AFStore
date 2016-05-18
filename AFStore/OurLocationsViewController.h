//
//  OurLocationsViewController.h
//  AFStore
//
//  Created by rac on 16/05/16.
//  Copyright © 2016 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "Localization.h"
#import "LocationViewCell.h"

#import "Annotation.h"

@interface OurLocationsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic) NSMutableArray *locations;

@property(nonatomic,strong)NSArray *name;
@property(nonatomic,strong)NSArray *subName;
@property(nonatomic,strong)NSMutableArray * arrCoordinateStr;

@property (nonatomic,retain) CLLocationManager *CLmanager;
@property (nonatomic,retain) CLLocation * MainLocation;





@end
