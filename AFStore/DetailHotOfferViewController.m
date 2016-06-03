//
//  DetailHotOfferViewController.m
//  AFStoreNew
//
//  Created by rac on 19/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "DetailHotOfferViewController.h"

@interface DetailHotOfferViewController ()

@end

@implementation DetailHotOfferViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);

    _lblTitleHotOffer.text=_offerCatTitle;
    
    _lblNoOfViews.text=[NSString stringWithFormat:@"Number Of Views %@",_NoOfViews];
    
    
   dispatch_async(queue, ^(){
    
        [self.indicator startAnimating];

        NSString * imgURL = self.offerImage;


        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];

        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

        NSURL * url = [NSURL URLWithString:replacedStr];

        NSData * imgData = [NSData dataWithContentsOfURL:url];

        UIImage * image = [UIImage imageWithData:imgData];

        dispatch_async( dispatch_get_main_queue() , ^(){


            self.imgHotOfferImage.image=image;
            
            [self.indicator stopAnimating];

        });
        
    });
    
    
    
    
    
    
    
    
    FBSDKLikeControl *button = [[FBSDKLikeControl alloc]initWithFrame:CGRectMake(10, 390, 100, 50)];
    
    button.objectID = @"https://www.aynalfahad.com/Productdetails/tabid/298/ProductID/199/";
    
    
    [self.view addSubview:button];
    
    button.likeControlStyle=FBSDKLikeControlStyleBoxCount;
    button.likeControlHorizontalAlignment=FBSDKLikeControlHorizontalAlignmentRight;
    
    // Center Button
    //    CGRect bounds = self.view.bounds;
    //    button.center = CGPointMake(
    //                                CGRectGetMidX(bounds), CGRectGetMidY(bounds)
    //                                );
    
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    
    NSString *urlString=[NSString stringWithFormat:@"http://www.aynAlFahad.com/"];
    
    
    
    content.contentURL = [NSURL URLWithString:urlString];
    
    
    
    content.contentTitle=[NSString stringWithFormat:@"%@",_offerCatTitle];
    
    content.contentDescription=[NSString stringWithFormat:@"Number Of Views: %@  ",self.NoOfViews];
    
    
    NSString * imgURL = self.offerImage;
    
    NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
    
    
    NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    content.imageURL=[NSURL URLWithString:replacedStr];
    
    
    FBSDKShareButton *Sharebutton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(220, 390, 80, 30)];
    Sharebutton.shareContent = content;
    
    [self.view addSubview:Sharebutton];
    

    
    
    
    
    
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
    [self setNavBar];
    
}



-(void)setNavBar
{
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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

- (IBAction)viewImageClicked:(id)sender
{
    [EXPhotoViewer showImageFrom:self.imgHotOfferImage];
}

- (IBAction)FBShareClicked:(id)sender
{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller addURL:[NSURL URLWithString:@"http://www.aynAlFahad.com/"]];
        
        
        NSString * imgURL = self.offerImage;
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        
        NSURL * url = [NSURL URLWithString:combined];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        
        [controller addImage:[UIImage imageWithData:imgData]];
        
        [controller setInitialText:[NSString stringWithFormat:@"Offer: %@ \n\n %@ \n",self.offerCatTitle,self.offerCatTitle]];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook"
                                                        message:@"Facebook integration is not available.  Make sure you have setup your Facebook account on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"Settings"
                                              otherButtonTitles:@"OK", nil];
        [alert show];
        alert.tag=101;
    }

    
}

- (IBAction)TweeterClicked:(id)sender
{
    
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [tweetSheet addURL:[NSURL URLWithString:@"http://www.aynAlFahad.com/"]];
        
        
        NSString * imgURL = self.offerImage;
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        
        [tweetSheet addImage:[UIImage imageWithData:imgData]];
        
        [tweetSheet setInitialText:[NSString stringWithFormat:@" %@ \nNo. of Views: %@ \n",self.offerCatTitle,self.NoOfViews]];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                        message:@"Twitter integration is not available.  Make sure you have setup your Twitter account on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"Settings"
                                              otherButtonTitles:@"OK", nil];
        [alert show];
        alert.tag=101;
    }
    

}

#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==101)
    {
        if (buttonIndex==0)
        {
            [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}



@end
