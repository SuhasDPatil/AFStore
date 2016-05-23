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
    
    if ([_strTitle isEqualToString:@"Diamod Warranty"])
    {
        self.title=LocalizedString(@"Diamod Warranty");
    }
    else if ([_strTitle isEqualToString:@"Gold Warranty"])
    {
        self.title=LocalizedString(@"Gold Warranty");
        
    }
    else if ([_strTitle isEqualToString:@"Silver Warranty"])
    {
        self.title=LocalizedString(@"Silver Warranty");
    }
    
    [self setNavBar];
    _selectedLang=[_defaults valueForKey:@"Language"];
    
    self.textView.layoutManager.delegate=self;
    
    self.textView.textAlignment=NSTextAlignmentRight;
    self.textView.text=_warrantyData;
    self.textView.textAlignment=NSTextAlignmentRight;

        // Do any additional setup after loading the view from its nib.
}
- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect
{
    return 9; // Line spacing of 19 is roughly equivalent to 5 here.
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
    
    //Contact Us Button
    UIButton *btnCont = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage4 = [UIImage imageNamed:@"call.png"]  ;
    [btnCont setBackgroundImage:rightBtnImage4 forState:UIControlStateNormal];
    [btnCont addTarget:self action:@selector(goContactUs) forControlEvents:UIControlEventTouchUpInside];
    btnCont.frame = CGRectMake(0, 0,  20, 18);
    UIBarButtonItem *ContUs = [[UIBarButtonItem alloc] initWithCustomView:btnCont] ;
    
    self.navigationItem.rightBarButtonItems=@[home,ContUs];
    
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


@end
