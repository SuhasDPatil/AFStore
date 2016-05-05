//
//  BeginViewController.m
//  AFStore
//
//  Created by Suhas on 10/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "BeginViewController.h"
@interface BeginViewController ()

@end

@implementation BeginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  //  sleep(5);
    [self.navigationController.navigationBar setHidden:YES];
    
    
    
      
    
    
    
    
    self.lblHome.text=LocalizedString(@"Home");
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Button Actions

- (IBAction)englishClicked:(id)sender
{
    NSLog(@"English Clicked") ;
    
    LocalizationSetLanguage(@"en");
    HomeMViewController *hvcc=[[HomeMViewController alloc]init];
    NewsViewController *nvcc=[[NewsViewController alloc]init];

    hvcc.selectedLanguage=@"en";
    nvcc.selectedLanguage=@"en";
    NSLog(@"%@",hvcc.selectedLanguage);
    [self translateText];
    
    
//    MainVC * ctvc=[[MainVC alloc]init];
//    
//    [self.navigationController pushViewController:ctvc animated:YES];

}

- (IBAction)arabicClicked:(id)sender
{
    NSLog(@"Arabic Clicked") ;
    
    LocalizationSetLanguage(@"ar");
    
//    NSString * seleLan=[Localization sharedLocalSystem];
    
    
    HomeMViewController *hvcc=[[HomeMViewController alloc]init];
    NewsViewController *nvcc=[[NewsViewController alloc]init];
    
    hvcc.selectedLanguage=@"ar";
    nvcc.selectedLanguage=@"ar";
    NSLog(@"%@",hvcc.selectedLanguage);

    

    [self translateText];
    
}

-(void)translateText
{
    self.lblHome.text=LocalizedString(@"Home");
    self.lblStore.text=LocalizedString(@"Store");
    self.lblSearch.text=LocalizedString(@"Search");
    self.lblHotOffer.text=LocalizedString(@"Hot Offer");
    self.lblMostPopular.text=LocalizedString(@"Most Popular");
    self.lblNews.text=LocalizedString(@"News");
    self.lblAboutUs.text=LocalizedString(@"About Us");
    self.lblGallery.text=LocalizedString(@"Gallery");
    self.lblContactUs.text=LocalizedString(@"Contact Us");
    self.lblWarranty.text=LocalizedString(@"Warranty");
    self.lblCheckYourPhone.text=LocalizedString(@"Check Your Phone");
    self.lblOtherServices.text=LocalizedString(@"Other Services");
}

- (IBAction)homeClicked:(id)sender
{
    HomeMViewController *hvc=[[HomeMViewController alloc]init];
    
    NSLog(@"%@",hvc.selectedLanguage);
    
    [self.navigationController pushViewController:hvc animated:YES];
    
}

- (IBAction)storeClicked:(id)sender
{
    CategoryViewController *cvc=[[CategoryViewController alloc]init];
    
    [self.navigationController pushViewController:cvc animated:YES];
    
}

- (IBAction)searchClicked:(id)sender
{
    SearchViewController *svc=[[SearchViewController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
}

- (IBAction)hotOfferClicked:(id)sender
{
    HotOfferCategoryViewController *hovc=[[HotOfferCategoryViewController alloc]init];
    
    [self.navigationController pushViewController:hovc animated:YES];
    
}


- (IBAction)mostPopularClicked:(id)sender
{
    MostPopularViewController *mpvc=[[MostPopularViewController alloc]init];
    
    [self.navigationController pushViewController:mpvc animated:YES];
}

- (IBAction)newsClicked:(id)sender
{
    NewsViewController *nvc=[[NewsViewController alloc]init];

    [self.navigationController pushViewController:nvc animated:YES];
    
}

- (IBAction)aboutUsClicked:(id)sender
{
    
    AboutUSViewController *auvc=[[AboutUSViewController alloc]init];
    
    [self.navigationController pushViewController:auvc animated:YES];
    
}

- (IBAction)galleryClicked:(id)sender
{
    
    GalleryViewController *gvc=[[GalleryViewController alloc]init];
    
    [self.navigationController pushViewController:gvc animated:YES];
    
}

- (IBAction)contactUsClicked:(id)sender
{
    
    ContactUSViewController * cuvc=[[ContactUSViewController alloc]init];
    
    [self.navigationController pushViewController:cuvc animated:YES];
    
}

- (IBAction)warrantyClicked:(id)sender
{
    WarrantyViewController *wvc=[[WarrantyViewController alloc]init];
    
    [self.navigationController pushViewController:wvc animated:YES];
    
}

- (IBAction)CheckYourPhoneClicked:(id)sender
{
    NSString * str=[NSString stringWithFormat:@"%@\nComing Soon...",LocalizedString(@"Check Your Phone")];
    
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:str message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
   [alt show];
    
    
//    ChkYrPhoneViewController *cypvc=[[ChkYrPhoneViewController alloc]init];
//    
//    [self.navigationController pushViewController:cypvc animated:YES];

    
}


- (IBAction)otherServicesClicked:(id)sender
{
    NSString * strTitle=[NSString stringWithFormat:@"%@\nComing Soon...",LocalizedString(@"Other Services")];
    NSString * strMsg=[NSString stringWithFormat:@"1.%@\n 2.%@ \n 3.%@ ",LocalizedString(@"Installments"),LocalizedString(@"Used Mobile Phones"),LocalizedString(@"Door-to-Door Delivery")];

    UIAlertView *alt=[[UIAlertView alloc]initWithTitle: strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alt show];

}
- (IBAction)exitClicked:(id)sender
{
    exit(0);
}


@end
