//
//  OurLocationsViewController.m
//  AFStore
//
//  Created by rac on 16/05/16.
//  Copyright © 2016 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "OurLocationsViewController.h"

@interface OurLocationsViewController ()

@end

@implementation OurLocationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LocationViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];

    self.title=LocalizedString(@"Our Locations");
    
    [self setNavBar];
    
    [self initViews];
    
    
    
    
    
    [self addAllPins];
    
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViews
{
    
    double miles = 12.42;
    
    double scalingFactor = ABS( (cos(2 * M_PI * 33.260223 / 360.0) ));

    MKCoordinateSpan span;
    
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/(scalingFactor * 69.0);
    
    MKCoordinateRegion region;
    region.span = span;
    
    region.center.latitude = 33.310223;
    region.center.longitude =44.364233;
    
    [_mapView setRegion:region animated:YES];
    
}


-(void)addAllPins
{
    _name=[[NSArray alloc]initWithObjects:@"بغداد المنصور شارع 14 رمضان. مقابل مطعم الساعة تلفون", @"بغداد العامرية شارع العمل الشعبي - مقابل الكوختلفون",@"فرع الجامعة - شارع الربيع - مقابل عمارة الصميدعيتلفون",@"فرع الغزالية - شارع الصديق مجاور مجمع الفهد الطبيتلفون",@"حي الخضراء – مجاورمركز الشرطة",@" بغداد المنصور شارع 14 رمضان. مجاور اللطيف للتحويل المالي",@"بغداد المنصور شارع 14 رمضان. مقابل ستي ماكس",@"بغداد الغزالية - شارع البدالة",@"بغداد زيونة - شارع الربيعي عمارة ماستر",@"فرع الدورة - داية شارع أبو طيارة  ", nil];
    
    _subName=[[NSArray alloc]initWithObjects:@"009647822229298\n009647722229298",@"009647822229298\n009647722229298",@"009647822229298\n009647722229298",@"009647822229298\n009647722229298",@"009647822229298\n009647722229298",@"009647822229298\n009647722229298",@"009647822229298\n009647722229298",@"009647822229298\n009647722229298",@"009647822229298\n009647722229298",@"009647822229298\n009647722229298", nil];

    _arrCoordinateStr = [[NSMutableArray alloc] initWithCapacity:_name.count];
    
    [_arrCoordinateStr addObject:@"33.320223, 44.338508"];
    [_arrCoordinateStr addObject:@"33.301664, 44.289203"];
    [_arrCoordinateStr addObject:@"33.311213, 44.324233"];
    [_arrCoordinateStr addObject:@"33.339006, 44.276423"];
    [_arrCoordinateStr addObject:@"33.319083, 44.295952"];
    [_arrCoordinateStr addObject:@"33.320219, 44.338082"];
    [_arrCoordinateStr addObject:@"33.316008, 44.337886"];
    [_arrCoordinateStr addObject:@"33.344609, 44.271875"];
    [_arrCoordinateStr addObject:@"33.321409, 44.447479"];
    [_arrCoordinateStr addObject:@"33.258361, 44.407414"];

    for(int i = 0; i < _name.count; i++)
    {
        [self addPinWithTitle:_name[i] andSubTitle:_subName[i] AndCoordinate:_arrCoordinateStr[i]];
    }

}

-(void)addPinWithTitle:(NSString *)title andSubTitle:(NSString *)subTit AndCoordinate:(NSString *)strCoordinate
{
    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
    
    // clear out any white space
    strCoordinate = [strCoordinate stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // convert string into actual latitude and longitude values
    NSArray *components = [strCoordinate componentsSeparatedByString:@","];
    
    double latitude = [components[0] doubleValue];
    double longitude = [components[1] doubleValue];
    
    // setup the map pin with all data and add to map view
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    mapPin.title = title;
    mapPin.subtitle=subTit;
    mapPin.coordinate = coordinate;
    
    [self.mapView addAnnotation:mapPin];
}


//- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id ) annotation
//{
//
//    MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation1"];
//    newAnnotation.pinColor = MKPinAnnotationColorRed;
//    newAnnotation.animatesDrop = YES;
//    newAnnotation.canShowCallout = NO;
//    [newAnnotation setSelected:YES animated:YES];
//    
//
//    return newAnnotation;
//}


- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    static BOOL seeded = NO;
    if(!seeded)
    {
        seeded = YES;
        srandom(time(NULL));
    }
    
    MKAnnotationView *aV;
    for (aV in views) {
        if([aV isKindOfClass:[MKUserLocation class]]) continue;
        
        CGRect endFrame = aV.frame;
        
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y, aV.frame.size.width/2, aV.frame.size.height/2);
        
        [UIView beginAnimations:nil context:NULL];
        
        CGFloat randTime = (CGFloat) random()/(CGFloat) RAND_MAX;
        [UIView setAnimationDuration:randTime];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [aV setFrame:endFrame];
        [UIView commitAnimations];
        
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_name count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LocationViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *brName = [_name objectAtIndex:indexPath.row];
    NSString * contNo=[_subName objectAtIndex:indexPath.row];
    
    cell.lblBranchName.text=brName;
    cell.lblContactNum.text=contNo;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * brName=[_name objectAtIndex:indexPath.row];
    
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:brName message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Call: 009647822229298" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSString *phoneCallNum = [NSString stringWithFormat:@"tel://009647822229298"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneCallNum]];
        

        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
            

        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Call: 009647722229298" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSString *phoneCallNum = [NSString stringWithFormat:@"tel://009647722229298"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneCallNum]];
        

        // Distructive button tapped.
        [self dismissViewControllerAnimated:YES completion:^{

        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tapped.
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];

}


-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    uint i = [self.locations indexOfObject:view.annotation];
    if (i != NSNotFound)
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}



#pragma mark User Defined

-(void)setNavBar
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255.0f/255.0f green:128.0f/255.0f blue:0.0f/255.0f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    //Back Button
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"back.png"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 10, 16);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
    
    //Contact Us Button
    UIButton *btnCont = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage4 = [UIImage imageNamed:@"call.png"]  ;
    [btnCont setBackgroundImage:rightBtnImage4 forState:UIControlStateNormal];
    [btnCont addTarget:self action:@selector(goContactUs) forControlEvents:UIControlEventTouchUpInside];
    btnCont.frame = CGRectMake(0, 0, 20, 18);
    UIBarButtonItem *ContUs = [[UIBarButtonItem alloc] initWithCustomView:btnCont] ;
    
    self.navigationItem.rightBarButtonItems=@[ContUs];
    
}

-(void)goContactUs
{
    ContactUSViewController *cuvc=[[ContactUSViewController alloc]init];
    
    [self.navigationController pushViewController:cuvc animated:YES];
    
}


- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
