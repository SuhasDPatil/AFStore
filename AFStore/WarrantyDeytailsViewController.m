//
//  WarrantyDeytailsViewController.m
//  AFStoreNew
//
//  Created by rac on 07/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "WarrantyDeytailsViewController.h"

@interface WarrantyDeytailsViewController ()

@end

@implementation WarrantyDeytailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"WebAddress link for %@ is :%@",_tab2,_getLink);
    [self setNavBar];
    
    if ([_btnInfo isEqualToString:@"Diamod Warranty"]) {
        self.title=LocalizedString(@"Diamod Warranty");
    }
    else if ([_btnInfo isEqualToString:@"Gold Warranty"])
    {
        self.title=LocalizedString(@"Gold Warranty");
        
    }
    else if ([_btnInfo isEqualToString:@"Silver Warranty"])
    {
        self.title=LocalizedString(@"Silver Warranty");
    }
    
    

    
    if (_segmentView.selectedSegmentIndex==0) {
        _lblDetailsText.text=_tab1;
        
    }
    
    
    
        // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden
{
    return NO;
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
    
    //Home Button
    UIButton *btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage3 = [UIImage imageNamed:@"home.png"]  ;
    [btnHome setBackgroundImage:rightBtnImage3 forState:UIControlStateNormal];
    [btnHome addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    btnHome.frame = CGRectMake(0, 0, 18, 17);
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithCustomView:btnHome] ;
    
    self.navigationItem.rightBarButtonItem=home;
    
}
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)goHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark UiWebViewDelegate

//- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
//    return allowLoad;
//}
//
//- (void)webViewDidFinishLoad:(UIWebView*)webView {
//    allowLoad = NO;
//}

- (IBAction)tabChanged:(id)sender
{
    
    NSUInteger index = sender ? [(UISegmentedControl*)sender selectedSegmentIndex] : 0;

    switch (index) {
        case 0:
            _lblDetailsText.hidden=NO;
            _imgWarrantyImage.hidden=YES;
            _btnImagView.hidden=YES;

            _lblDetailsText.text=_tab1;
            
            break;
            
        case 1:
            _lblDetailsText.hidden=NO;
            _imgWarrantyImage.hidden=YES;
            _btnImagView.hidden=YES;
            
            _lblDetailsText.text=_tab2;
            
            break;
            
        case 2:
            _imgWarrantyImage.hidden=NO;
            _btnImagView.hidden=NO;
            
            _lblDetailsText.hidden=YES;
            
            if ([_btnInfo isEqualToString:@"Diamod Warranty"])
            {
                _imgWarrantyImage.image=[UIImage imageNamed:@"TabDiamondImg.jpg"];
            }
            else if ([_btnInfo isEqualToString:@"Gold Warranty"])
            {
                _imgWarrantyImage.image=[UIImage imageNamed:@"TabGoldImg.jpg"];

            }
            else if ([_btnInfo isEqualToString:@"Silver Warranty"])
            {
                _imgWarrantyImage.image=[UIImage imageNamed:@"TabSilverImg.jpg"];
                
            }

            break;
            
        default:
            
            break;
    }

}

- (IBAction)btnImageClicked:(id)sender
{
    
    [EXPhotoViewer showImageFrom:self.imgWarrantyImage];

}
@end
