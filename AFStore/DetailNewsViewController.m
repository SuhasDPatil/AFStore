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
    self.lblNoOfViews.text=[NSString stringWithFormat:@"%@ : %@",LocalizedString(@"Number of Views") ,_newsNoOfViews];

    self.title=LocalizedString(@"Detail");
    
    dispatch_async(queue, ^(){
        
        [self.indicator startAnimating];
        
        NSString * imgURL = self.newsImage;
        
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * url = [NSURL URLWithString:replacedStr];
        
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        UIImage * image = [UIImage imageWithData:imgData];
        
        dispatch_async( dispatch_get_main_queue() , ^(){
            
            
            self.imgNewsImage.image=image;
            
            [self.indicator stopAnimating];
        });
        
    });

    
    

    
    
 //   self.imgNewsImage.image=self.newsImage;
    // Do any additional setup after loading the view from its nib.
}


-(BOOL)prefersStatusBarHidden
{
    return NO;
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud show:YES];

    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet addURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://aynalfahad.com/News/TabId/143/ArtMID/921/ArticleID/%@",_newsArticleID]]];
        NSString * imgURL = self.newsImage;
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
        NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSURL * url = [NSURL URLWithString:replacedStr];
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        [tweetSheet addImage:[UIImage imageWithData:imgData]];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"%@\nNo. of View:%@ \nDate: %@",self.newsTitle,self.NumberOfViews,self.newsPubDate]];
        
        [hud hide:YES];

        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        SLComposeViewController *TWITTER = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [hud hide:YES];

        [self presentViewController:TWITTER animated:YES completion:nil];
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
                    
                 }
                 
                 
                 NSString * strSummery=self.Article;
                 NSLog(@"Article Details by web-service : %@",strSummery);
                 
                 
                 NSString * converted=[[strSummery stringByDecodingHTMLEntities]stringByStrippingTags];
                 NSLog(@"Converted :::: %@",converted);


                 NSString *con =[self replaceHTMLEntitiesInString:converted];
                 
                 
              

                 [_webView loadHTMLString:[NSString stringWithFormat:@"<div style='text-align:right'>%@<div>",con] baseURL:nil];
                 
                 
                 
                 
                 
                 //facebook sharing
                 
                 
                 FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
                 
                 
                 NSString *urlString=[NSString stringWithFormat:@"http://aynalfahad.com/News/TabId/143/ArtMID/921/ArticleID/%@",_newsArticleID];
                 
                 
                 NSLog(@"Shre Link :%@",urlString);
                 
                 content.contentURL = [NSURL URLWithString:urlString];
                 
                 
                 
                 content.contentTitle=[NSString stringWithFormat:@"%@",_newsTitle];
                 
                 content.contentDescription=[NSString stringWithFormat:@"Publish Date:%@ \n%@ ",self.newsPubDate,strSummery];
                 
                 
                 NSString * imgURL = self.newsImage;
                 
                 NSString *combined = [NSString stringWithFormat:@"%@%@", API_ALL_IMAGES,imgURL];
                 
                 NSLog(@"Image URL====%@",combined);
                 
                 
                 content.imageURL=[NSURL URLWithString:combined];
                 
                 
                 FBSDKShareButton *Sharebutton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(0, 465, 150, 36)];
                 Sharebutton.shareContent = content;
                 
                 [Sharebutton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                 [Sharebutton setBackgroundColor:[UIColor clearColor]];
                 [Sharebutton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                 [Sharebutton setTintColor:[UIColor clearColor]];
                 
                 [self.view addSubview:Sharebutton];

                 
                 
                 
                 
                 
                 
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
