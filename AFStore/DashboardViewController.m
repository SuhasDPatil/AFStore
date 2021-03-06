//
//  DashboardViewController.m
//  AFStore
//
//  Created by rac on 04/05/16.
//  Copyright © 2016 ___SANDS_TECHNOLOGIES___. All rights reserved.
//


#import "DashboardViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _defaults=[NSUserDefaults standardUserDefaults];
    
    // Do any additional setup after loading the view from its nib.
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewWillAppear:(BOOL)animated
{
    NSString *str=[_defaults valueForKey:@"Language"];
    
    if ([str isEqualToString:@"English"]) {
        
        [self showMenuEnglish];
    }
    else if ([str isEqualToString:@"Arabic"])
    {
        [self showMenuArabic];
    }
    else
    {
          [self showMenuEnglish];
    }
    
    [self.navigationController.navigationBar setHidden:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    
}

- (void)showMenuEnglish {
    items = [[NSMutableArray alloc] initWithCapacity:2];
    
    menuItem=[[MenuItem alloc]init];

    menuItem = [MenuItem itemWithTitle:@"Home" iconName:@"Home" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    

    menuItem = [MenuItem itemWithTitle:@"Store" iconName:@"Store" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"News" iconName:@"News" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"About Us" iconName:@"About_Us" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Gallery" iconName:@"Gallery" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Contact Us" iconName:@"Contact_Us" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Warranty" iconName:@"Warranty" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Check Your Phone" iconName:@"Check_Your_Phone" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];

    menuItem = [MenuItem itemWithTitle:@"Our Locations" iconName:@"Other_Services" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];

    if (!_popMenuEnglish)
    {
//        _popMenuEnglish = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
        
        
        if ([[UIScreen mainScreen] bounds].size.height ==480)
        {
            _popMenuEnglish = [[PopMenu alloc] initWithFrame:CGRectMake(0, 40, 320, 450) items:items];
        }
        else
        {
            _popMenuEnglish = [[PopMenu alloc] initWithFrame:CGRectMake(0, 60, 320, 500) items:items];

        }
        
        _popMenuEnglish.menuAnimationType = kPopMenuAnimationTypeNetEase;
    
    }
    if (_popMenuEnglish.isShowed) {
        return;
    }
    _popMenuEnglish.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        
        if ([selectedItem.title isEqualToString:@"Home"]||[selectedItem.title isEqualToString:@"عين الفهد"])
        {
            HomeMViewController *hvc=[[HomeMViewController alloc]init];
            
            
            [self.navigationController pushViewController:hvc animated:YES];
            
        }
        else if ([selectedItem.title isEqualToString:@"Store"]||[selectedItem.title isEqualToString:@"المتجر"])
        {
            SubCategoryViewController *cvc=[[SubCategoryViewController alloc]init];
            
            [self.navigationController pushViewController:cvc animated:YES];
            
        }
        else if ([selectedItem.title isEqualToString:@"News"]||[selectedItem.title isEqualToString:@"أخبار عالم الهواتف"])
        {
            NewsViewController *nvc=[[NewsViewController alloc]init];
            
            [self.navigationController pushViewController:nvc animated:YES];
            
        }
        else if ([selectedItem.title isEqualToString:@"About Us"]||[selectedItem.title isEqualToString:@"عن عين الفهد"])
        {
            AboutUSViewController *auvc=[[AboutUSViewController alloc]init];
            
            [self.navigationController pushViewController:auvc animated:YES];
            
        }
        else if ([selectedItem.title isEqualToString:@"Gallery"]||[selectedItem.title isEqualToString:@"الصور"])
        {
            GalleryViewController *gvc=[[GalleryViewController alloc]init];
            
            [self.navigationController pushViewController:gvc animated:YES];
            
        }
        else if ([selectedItem.title isEqualToString:@"Contact Us"]||[selectedItem.title isEqualToString:@"اتصل بنا"])
        {
            ContactUSViewController * cuvc=[[ContactUSViewController alloc]init];
            
            [self.navigationController pushViewController:cuvc animated:YES];
            
        }
        else if ([selectedItem.title isEqualToString:@"Warranty"]||[selectedItem.title isEqualToString:@"ضمان"])
        {
            WarrantyViewController *wvc=[[WarrantyViewController alloc]init];
            
            [self.navigationController pushViewController:wvc animated:YES];
            
        }
        else if ([selectedItem.title isEqualToString:@"Check Your Phone"]||[selectedItem.title isEqualToString:@"افحص هاتفك"])
        {
            NSString * str=[NSString stringWithFormat:@"%@\nComing Soon...",LocalizedString(@"Check Your Phone")];
            
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:str message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alt.tag=100;
            [alt show];
            
        }
        else if ([selectedItem.title isEqualToString:@"Our Locations"]||[selectedItem.title isEqualToString:@"مواقعنا"])
        {
            OurLocationsViewController *olvc=[[OurLocationsViewController alloc]init];
            
            [self.navigationController pushViewController:olvc animated:YES];
        }
        
    };
    
    [_popMenuEnglish showMenuAtView:self.view];
    
}


- (void)showMenuArabic {
    
    items = [[NSMutableArray alloc] initWithCapacity:2];
    
    menuItem=[[MenuItem alloc]init];
    
    menuItem = [MenuItem itemWithTitle:@"عين الفهد" iconName:@"Home"];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"المتجر" iconName:@"Store" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"أخبار عالم الهواتف" iconName:@"News" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"عن عين الفهد" iconName:@"About_Us" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"الصور" iconName:@"Gallery" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"اتصل بنا" iconName:@"Contact_Us" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"ضمان" iconName:@"Warranty" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"افحص هاتفك" iconName:@"Check_Your_Phone" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"مواقعنا" iconName:@"Other_Services" glowColor:[UIColor clearColor]];
    [items addObject:menuItem];
    

    
    if (!_popMenuArabic)
    {
        //        _popMenuEnglish = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
        if ([[UIScreen mainScreen] bounds].size.height ==480)
        {
            _popMenuArabic = [[PopMenu alloc] initWithFrame:CGRectMake(0, 40, 320, 450) items:items];
        }
        else
        {
            _popMenuArabic = [[PopMenu alloc] initWithFrame:CGRectMake(0, 60, 320, 500) items:items];
            
        }
        _popMenuArabic.menuAnimationType = kPopMenuAnimationTypeNetEase;
        
    }
    if (_popMenuArabic.isShowed) {
        return;
    }
    _popMenuArabic.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        
        if ([selectedItem.title isEqualToString:@"Home"]||[selectedItem.title isEqualToString:@"عين الفهد"])
        {
            HomeMViewController *hvc=[[HomeMViewController alloc]init];
            
            
            [self.navigationController pushViewController:hvc animated:NO];
            
        }
        else if ([selectedItem.title isEqualToString:@"Store"]||[selectedItem.title isEqualToString:@"المتجر"])
        {
            SubCategoryViewController *cvc=[[SubCategoryViewController alloc]init];
            
            [self.navigationController pushViewController:cvc animated:YES];
            
        }
        
        else if ([selectedItem.title isEqualToString:@"News"]||[selectedItem.title isEqualToString:@"أخبار عالم الهواتف"])
        {
            NewsViewController *nvc=[[NewsViewController alloc]init];
            
            [self.navigationController pushViewController:nvc animated:NO];
            
        }
        else if ([selectedItem.title isEqualToString:@"About Us"]||[selectedItem.title isEqualToString:@"عن عين الفهد"])
        {
            AboutUSViewController *auvc=[[AboutUSViewController alloc]init];
            
            [self.navigationController pushViewController:auvc animated:YES];
            
        }
        else if ([selectedItem.title isEqualToString:@"Gallery"]||[selectedItem.title isEqualToString:@"الصور"])
        {
            GalleryViewController *gvc=[[GalleryViewController alloc]init];
            
            [self.navigationController pushViewController:gvc animated:YES];
            
        }
        else if ([selectedItem.title isEqualToString:@"Contact Us"]||[selectedItem.title isEqualToString:@"اتصل بنا"])
        {
            ContactUSViewController * cuvc=[[ContactUSViewController alloc]init];
            
            [self.navigationController pushViewController:cuvc animated:YES];
            
        }
        else if ([selectedItem.title isEqualToString:@"Warranty"]||[selectedItem.title isEqualToString:@"ضمان"])
        {
            WarrantyViewController *wvc=[[WarrantyViewController alloc]init];
            
            [self.navigationController pushViewController:wvc animated:YES];
            
        }
        else if ([selectedItem.title isEqualToString:@"Check Your Phone"]||[selectedItem.title isEqualToString:@"افحص هاتفك"])
        {
            NSString * str=[NSString stringWithFormat:@"%@\nComing Soon...",LocalizedString(@"Check Your Phone")];
            
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:str message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alt.tag=100;
            [alt show];
            
        }
        else if ([selectedItem.title isEqualToString:@"Our Locations"]||[selectedItem.title isEqualToString:@"مواقعنا"])
        {
            OurLocationsViewController *olvc=[[OurLocationsViewController alloc]init];
            
            [self.navigationController pushViewController:olvc animated:YES];
            
        }
        
    };
    
    [_popMenuArabic showMenuAtView:self.view];
    
}



- (IBAction)englishClicked:(id)sender
{
    NSLog(@"English Clicked") ;
    
    LocalizationSetLanguage(@"en");
    
    _defaults=[NSUserDefaults standardUserDefaults];
    
    [_defaults setObject:@"English" forKey:@"Language"];
    
    [_defaults synchronize];
    
    NSString *str=[_defaults valueForKey:@"Language"];
    
    
    _lblselectLang.text=LocalizedString(@"Select Your Language");

    [_popMenuArabic setHidden:YES];
    [_popMenuEnglish setHidden:NO];
    
    [self showMenuEnglish];
}

- (IBAction)arabicClicked:(id)sender
{
    NSLog(@"Arabic Clicked") ;
    LocalizationSetLanguage(@"ar");
    
    _defaults=[NSUserDefaults standardUserDefaults];
    
    [_defaults setObject:@"Arabic" forKey:@"Language"];
    
    [_defaults synchronize];
    
    NSString *str=[_defaults valueForKey:@"Language"];
    
    
    _lblselectLang.text=LocalizedString(@"Select Your Language");

    [_popMenuEnglish setHidden:YES];
    [_popMenuArabic setHidden:NO];
    [self showMenuArabic];

}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSString *str=[_defaults valueForKey:@"Language"];
    
    if ([str isEqualToString:@"English"])
    {
        [self showMenuEnglish];
    }
    else if ([str isEqualToString:@"Arabic"])
    {
        [self showMenuArabic];
    }
    else
    {
        [self showMenuEnglish];
    }
}


#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100)
    {
        if (buttonIndex==0)
        {
            
            NSString *str=[_defaults valueForKey:@"Language"];
            
            if ([str isEqualToString:@"English"])
            {
                [self showMenuEnglish];
                
                [_popMenuArabic setHidden:YES];
                [_popMenuEnglish setHidden:NO];
            }
            else if ([str isEqualToString:@"Arabic"])
            {
                [self showMenuArabic];
                
                [_popMenuArabic setHidden:NO];
                [_popMenuEnglish setHidden:YES];
            }
        }
    }
}

@end
