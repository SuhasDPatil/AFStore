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
    
    // Do any additional setup after loading the view from its nib.
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
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:2];
    
    MenuItem *menuItem = [MenuItem itemWithTitle:@"Home" iconName:@"Home" glowColor:[UIColor colorWithRed:254.0f/255.0f green:201.0f/255.0f blue:125.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    

    menuItem = [MenuItem itemWithTitle:@"Store" iconName:@"Store" glowColor:[UIColor colorWithRed:126.0f/255.0f green:230.0f/255.0f blue:243.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"News" iconName:@"News" glowColor:[UIColor colorWithRed:137.0f/255.0f green:211.0f/255.0f blue:127.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"About Us" iconName:@"About_Us" glowColor:[UIColor colorWithRed:193.0f/255.0f green:114.0f/255.0f blue:75.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Gallery" iconName:@"Gallery" glowColor:[UIColor colorWithRed:75.0f/255.0f green:136.0f/255.0f blue:193.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Contact Us" iconName:@"Contact_Us" glowColor:[UIColor colorWithRed:75.0f/255.0f green:193.0f/255.0f blue:153.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Warranty" iconName:@"Warranty" glowColor:[UIColor colorWithRed:232.0f/255.0f green:122.0f/255.0f blue:119.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Check Your Phone" iconName:@"Check_Your_Phone" glowColor:[UIColor colorWithRed:133.0f/255.0f green:118.0f/255.0f blue:178.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];

    menuItem = [MenuItem itemWithTitle:@"Other Services" iconName:@"Other_Services" glowColor:[UIColor colorWithRed:193.0f/255.0f green:172.0f/255.0f blue:75.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];

    if (!_popMenu)
    {
//        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
        _popMenu = [[PopMenu alloc] initWithFrame:CGRectMake(0, 60, 320, 500) items:items];
        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
    
    }
    if (_popMenu.isShowed) {
        return;
    }
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        
        if ([selectedItem.title isEqualToString:@"Home"]||[selectedItem.title isEqualToString:@"عين الفهد"])
        {
            HomeMViewController *hvc=[[HomeMViewController alloc]init];
            
            NSLog(@"%@",hvc.selectedLanguage);
            
            [self.navigationController pushViewController:hvc animated:YES];
            
        }
        else if ([selectedItem.title isEqualToString:@"Store"]||[selectedItem.title isEqualToString:@"المتجر"])
        {
            CategoryViewController *cvc=[[CategoryViewController alloc]init];
            
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
        else if ([selectedItem.title isEqualToString:@"Other Services"]||[selectedItem.title isEqualToString:@"خدمات أخرى"])
        {
            NSString * strTitle=[NSString stringWithFormat:@"%@\nComing Soon...",LocalizedString(@"Other Services")];
            NSString * strMsg=[NSString stringWithFormat:@"1.%@\n 2.%@ \n 3.%@ ",LocalizedString(@"Installments"),LocalizedString(@"Used Mobile Phones"),LocalizedString(@"Door-to-Door Delivery")];
            
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle: strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alt.tag=101;
            [alt show];
            
        }
        
    };
    
    [_popMenu showMenuAtView:self.view];
    
}


- (void)showMenuArabic {
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:2];
    
    MenuItem *menuItem = [MenuItem itemWithTitle:@"عين الفهد" iconName:@"Home"];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"المتجر" iconName:@"Store" glowColor:[UIColor colorWithRed:254.0f/255.0f green:254.0f/255.0f blue:254.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"أخبار عالم الهواتف" iconName:@"News" glowColor:[UIColor colorWithRed:254.0f/255.0f green:254.0f/255.0f blue:254.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"عن عين الفهد" iconName:@"About_Us" glowColor:[UIColor colorWithRed:254.0f/255.0f green:254.0f/255.0f blue:254.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"الصور" iconName:@"Gallery" glowColor:[UIColor colorWithRed:254.0f/255.0f green:254.0f/255.0f blue:254.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"اتصل بنا" iconName:@"Contact_Us" glowColor:[UIColor colorWithRed:254.0f/255.0f green:254.0f/255.0f blue:254.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"ضمان" iconName:@"Warranty" glowColor:[UIColor colorWithRed:254.0f/255.0f green:254.0f/255.0f blue:254.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"افحص هاتفك" iconName:@"Check_Your_Phone" glowColor:[UIColor colorWithRed:254.0f/255.0f green:254.0f/255.0f blue:254.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"خدمات أخرى" iconName:@"Other_Services" glowColor:[UIColor colorWithRed:254.0f/255.0f green:254.0f/255.0f blue:254.0f/255.0f alpha:0.800]];
    [items addObject:menuItem];
    
    if (!_popMenu)
    {
        //        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
        _popMenu = [[PopMenu alloc] initWithFrame:CGRectMake(0, 60, 320, 500) items:items];
        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
        
    }
    if (_popMenu.isShowed) {
        return;
    }
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        
        if ([selectedItem.title isEqualToString:@"Home"]||[selectedItem.title isEqualToString:@"عين الفهد"])
        {
            HomeMViewController *hvc=[[HomeMViewController alloc]init];
            
            NSLog(@"%@",hvc.selectedLanguage);
            
            [self.navigationController pushViewController:hvc animated:NO];
            
        }
        else if ([selectedItem.title isEqualToString:@"Store"]||[selectedItem.title isEqualToString:@"المتجر"])
        {
            CategoryViewController *cvc=[[CategoryViewController alloc]init];
            
            [self.navigationController pushViewController:cvc animated:NO];
            
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
        else if ([selectedItem.title isEqualToString:@"Other Services"]||[selectedItem.title isEqualToString:@"خدمات أخرى"])
        {
            NSString * strTitle=[NSString stringWithFormat:@"%@\nComing Soon...",LocalizedString(@"Other Services")];
            NSString * strMsg=[NSString stringWithFormat:@"1.%@\n 2.%@ \n 3.%@ ",LocalizedString(@"Installments"),LocalizedString(@"Used Mobile Phones"),LocalizedString(@"Door-to-Door Delivery")];
            
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle: strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alt.tag=101;
            [alt show];
            
        }
        
    };
    
    [_popMenu showMenuAtView:self.view];
    
}



- (IBAction)englishClicked:(id)sender
{
    NSLog(@"English Clicked") ;
    
    LocalizationSetLanguage(@"en");
    
    _defaults=[NSUserDefaults standardUserDefaults];
    
    [_defaults setObject:@"English" forKey:@"Language"];
    
    [_defaults synchronize];
    
    NSString *str=[_defaults valueForKey:@"Language"];
    
    NSLog(@"%@",str);
    
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
    
    NSLog(@"%@",str);

    [self showMenuArabic];

}

- (IBAction)menuClicked:(id)sender
{
    [self showMenuEnglish];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
        [self showMenuArabic];
}

@end
