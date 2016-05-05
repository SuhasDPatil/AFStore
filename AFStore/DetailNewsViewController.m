//
//  DetailNewsViewController.m
//  AFStore 
//
//  Created by Suhas on 16/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "DetailNewsViewController.h"

@interface DetailNewsViewController ()

@end

@implementation DetailNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self NewsDetailWebService];
    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);

    self.lblNewsTitle.text=self.newsTitle;
    self.lblPubDate.text=self.newsPubDate;
    self.lblSummary.text=LocalizedString(@"Summary");
    self.lblNoOfViews.text=[NSString stringWithFormat:@"%@",_NumberOfViews];

    self.title=LocalizedString(@"Detail");
    
    dispatch_async(queue, ^(){
        
        [self.indicator startAnimating];
        
        NSString * imgURL = self.newsImage;
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        NSLog(@"***************************************************************");
        NSLog(@"***************************************************************");

        NSLog(@"News Details Image URL:%@",replacedStr);
        
        NSLog(@"***************************************************************");
        NSLog(@"***************************************************************");

        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        UIImage * image = [UIImage imageWithData:imgData];
        
        dispatch_async( dispatch_get_main_queue() , ^(){
            
            
            self.imgNewsImage.image=image;
            
            [self.indicator stopAnimating];
        });
        
    });

    
    
    
    
    
    
    
    
    
    FBSDKLikeControl *button = [[FBSDKLikeControl alloc]initWithFrame:CGRectMake(10, 490, 100, 50)];
    
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
    
    
    NSLog(@"Shre Link :%@",urlString);
    
    content.contentURL = [NSURL URLWithString:urlString];
    
    
    
    content.contentTitle=[NSString stringWithFormat:@"%@",_newsTitle];
    
    content.contentDescription=[NSString stringWithFormat:@"Publish Date:%@ \n%@ ",self.newsPubDate,self.newssummery];
    
    
    NSString * imgURL = self.newsImage;
    
    NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
    
    NSLog(@"Image URL====%@",combined);

    
    content.imageURL=[NSURL URLWithString:combined];
    
    
    FBSDKShareButton *Sharebutton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(220, 490, 80, 30)];
    Sharebutton.shareContent = content;
    
    [self.view addSubview:Sharebutton];

    
    
    
    
    
    
 //   self.imgNewsImage.image=self.newsImage;
    // Do any additional setup after loading the view from its nib.
}


-(BOOL)prefersStatusBarHidden
{
    return YES;
}



-(NSString *) replaceHTMLEntitiesInString:(NSString *) htmlString {
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"ldquo;" withString:@" "];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"rdquo;" withString:@" "];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&ndash;" withString:@" "];

    return htmlString;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [EXPhotoViewer showImageFrom:self.imgNewsImage];

}

- (IBAction)FBShareClicked:(id)sender
{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller addURL:[NSURL URLWithString:@"http://www.aynAlFahad.com/"]];
        
        
        NSString * imgURL = self.newsImage;
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        NSLog(@"Image URL====%@",combined);
        
        NSURL * url = [NSURL URLWithString:combined];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        
        [controller addImage:[UIImage imageWithData:imgData]];
        
        [controller setInitialText:[NSString stringWithFormat:@"News Title: %@ \nPublish Date: %@ \nDetails :%@ ",self.newsTitle,self.newsPubDate,self.newssummery]];
        
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

- (IBAction)TweetClicked:(id)sender
{
    
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [tweetSheet addURL:[NSURL URLWithString:@"http://www.aynAlFahad.com/"]];
        
        
        NSString * imgURL = self.newsImage;
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        NSLog(@"Image URL====%@",combined);
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        
        [tweetSheet addImage:[UIImage imageWithData:imgData]];
        
        
        [tweetSheet setInitialText:[NSString stringWithFormat:@"%@\nNo. of View:%@ \nDate: %@ \n %@",self.newsTitle,self.NumberOfViews,self.newsPubDate, self.newssummery]];
        
        
        
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




#pragma mark Webservices

-(void)NewsDetailWebService
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:_newsArticleID forKey:@"ArticalID"];
    
    NSLog(@"%@",dict);
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_NEWS_DETAILS
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             // NSArray *list=[responseObject objectForKey:@"Data"];
             NewsListArray=[[NSMutableArray alloc]init];
             NewsListArray=[responseObject objectForKey:@"Data"];
             if(NewsListArray.count>0)
             {
                 NSLog(@"Category Array Count:::%ld",(unsigned long)NewsListArray.count);
                 int i;
                 for (i=0; i<NewsListArray.count; i++)
                 {
                     NSDictionary * d = [NewsListArray objectAtIndex:i];
                     
                     _Article=[d valueForKey:@"Article"];
                     _NumberOfViews=[d valueForKey:@"NumberOfViews"];
                     
                     
                     NSLog(@"News Summery : %@", _Article);
                     NSLog(@"***************************************************");
                     NSLog(@"***************************************************");
                     NSLog(@"***************************************************");
                     NSLog(@"***************************************************");
                     
                     NSLog(@"\n\n NumberOfViews : %@\n\n",_NumberOfViews);
                     
                     
                     
                     
                     NSLog(@"***************************************************");
                     NSLog(@"***************************************************");
                     NSLog(@"***************************************************");
                     NSLog(@"***************************************************");
                     NSLog(@"***************************************************");
                     NSLog(@"***************************************************");
                     
                     
                 }
                 
                 self.lblNoOfViews.text=[NSString stringWithFormat:@"Number Of Views :%@",_NumberOfViews];
                 
                 NSString * strSummery=self.Article;
                 NSLog(@"Article Details by web-service : %@",strSummery);
                 
                 
                 NSString * converted=[[strSummery stringByDecodingHTMLEntities]stringByStrippingTags];
                 NSLog(@"Converted :::: %@",converted);


                 NSString *con =[self replaceHTMLEntitiesInString:converted];
                 
                 
              

                 [_webView loadHTMLString:[NSString stringWithFormat:@"<div style='text-align:right'>%@<div>",con] baseURL:nil];
                 
                 
             }
             else
             {
                 UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 alt1.tag=111;
                 [alt1 show];
             }
         }
         else
         {
             
             UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             alt1.tag=111;
             [alt1 show];
             
         }
         [hud hide:YES];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alt1.tag=111;
         [alt1 show];
         
     }];
    
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
    
    if (alertView.tag==111) {
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

}



@end
