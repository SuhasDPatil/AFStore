//
//  ContactUSViewController.m
//  AFStore 
//
//  Created by Suhas on 10/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "ContactUSViewController.h"

@interface ContactUSViewController ()

@end

@implementation ContactUSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[self.btnSubmit layer] setBorderWidth:0.5f];
    [[self.btnSubmit layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[self.btnSubmit layer]setCornerRadius:3.5f];

    
    
    self.title=LocalizedString(@"Contact Us");
    [self setNavBar];
    
    [self setKeyboard];
    
    _txtEmail.delegate=self;
    _txtFirstName.delegate=self;
    _txtLastName.delegate=self;
    _txtMobileNo.delegate=self;
    _txtMessage.delegate=self;
  
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



#pragma mark - TextField Delegate


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    
    [self SlideupScreen:textField];
    
    //  [self setKeyboard];
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self SlideDownScreen:textField];
    
    [textField resignFirstResponder];
    
    return YES;
}




#pragma mark User Defined

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

}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)setKeyboard
{
    
    UIToolbar* keyboardToolBar = [[UIToolbar alloc] init];
    //   [keyboardToolBar setBackgroundImage:[UIImage imageNamed:@"SerchbarBackground.png"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    
    keyboardToolBar.barStyle = UIBarStyleBlack;
    keyboardToolBar.backgroundColor=[UIColor darkGrayColor];
    keyboardToolBar.translucent = YES;
    keyboardToolBar.alpha=0.8f;
    // for ios 6
    keyboardToolBar.tintColor = [UIColor whiteColor];
    // for ios 7
    //keyboardToolBar.tintColor = [UIColor whiteColor];
    
    [keyboardToolBar sizeToFit];
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneButtonClicked:)];
    [keyboardToolBar setItems:[NSArray arrayWithObjects:doneButton,flexibleSpaceLeft, nil]];
    
    _txtFirstName.inputAccessoryView=keyboardToolBar;
    _txtLastName.inputAccessoryView=keyboardToolBar;
    _txtEmail.inputAccessoryView=keyboardToolBar;
    _txtMobileNo.inputAccessoryView=keyboardToolBar;
    _txtMessage.inputAccessoryView=keyboardToolBar;

    
}

-(void)doneButtonClicked:(id)sender
{
    [_txtFirstName resignFirstResponder];
    [_txtLastName resignFirstResponder];
    [_txtMobileNo resignFirstResponder];
    [_txtEmail resignFirstResponder];
    [_txtMessage resignFirstResponder];

    [self SlideDownScreen:sender];
    
    
    // for ios 6
    
    // for ios 7
    // CGPoint scrollPoint = CGPointMake(0, self.view.frame.origin.y-65);
    // [scrollView setContentOffset:scrollPoint animated:YES];
}




-(void)SlideupScreen:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    if ([[UIScreen mainScreen] bounds].size.height ==480)
    {
        
        if ([_txtFirstName isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, 0,320, self.view.frame.size.height)];
            
        }
        else if([_txtLastName isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, 0,320, self.view.frame.size.height)];
            
        }
        else if([_txtMobileNo isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -15,320, self.view.frame.size.height)];
            
        }
        else if([_txtEmail isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -35,320, self.view.frame.size.height)];
            
        }
        else if([_txtMessage isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -45,320, self.view.frame.size.height)];
            
        }
    }
    
    else
    {
        if ([_txtFirstName isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, 0,320, self.view.frame.size.height)];
        }
        
        else if([_txtLastName isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, 0,320, self.view.frame.size.height)];
            
        }
        else if([_txtMobileNo isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -15,320, self.view.frame.size.height)];
            
        }
        else if([_txtEmail isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -35,320, self.view.frame.size.height)];
            
        }
        else if([_txtMessage isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -45,320, self.view.frame.size.height)];
            
        }
        
    }
    
    [UIView commitAnimations];
}

-(void)SlideDownScreen:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    [self.view setFrame:CGRectMake(0, 44, 320, self.view.frame.size.height)];

    [UIView commitAnimations];
    
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitClicked:(id)sender
{
    
    
    [_txtFirstName resignFirstResponder];
    [_txtLastName resignFirstResponder];
    [_txtMobileNo resignFirstResponder];
    [_txtMessage resignFirstResponder];
    [_txtEmail resignFirstResponder];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    [self.view setFrame:CGRectMake(0, 44, 320, self.view.frame.size.height)];
    
    [UIView commitAnimations];

    
    if(_txtFirstName.text.length==0)
    {
        [Utiles showAlert:APP_NAME Message:@"Enter First Name"];
        return;
    }
    if(_txtLastName.text.length==0)
    {
        [Utiles showAlert:APP_NAME Message:@"Enter Last Name"];
        return;
    }
    
    if(_txtMobileNo.text.length==0)
    {
        [Utiles showAlert:APP_NAME Message:@"Enter Mobile No."];
        return;
    }
    else  if(_txtMobileNo.text.length<10)
    {
        [Utiles showAlert:APP_NAME Message:@"Enter 10 digit mobile number."];
        return;
    }
    
    if(_txtEmail.text.length==0)
    {
        [Utiles showAlert:APP_NAME Message:@"Enter Email"];
        return;
    }
    else if (![Utiles validEmail:[_txtEmail.text lowercaseString]] )
    {
        [Utiles showAlert:APP_NAME Message:@"Enter Valid Email"];
        return;
    }
    
    
    
    if(_txtMessage.text.length==0)
    {
        [Utiles showAlert:APP_NAME Message:@"Enter Your Message"];
        return;
    }
    
    

    
    
    [self ContactUsWebService];
    
}


#pragma mark - Web-service


-(void)ContactUsWebService
{
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:_txtFirstName.text forKey:@"FName"];
    [dict setObject:_txtLastName.text forKey:@"LName"];
    [dict setObject:_txtMobileNo.text forKey:@"ContactNumber"];
    [dict setObject:_txtEmail.text forKey:@"emailFrom"];
    [dict setObject:_txtMessage.text forKey:@"body"];

    NSLog(@"Request Dictionary: %@",dict);
   
    
    [[AFAppAPIClient WSsharedClient] POST:API_SEND_EMAIL_FOR_CONTACT_US
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
            
             
             UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"Thank you for contacting AynAlfahad. Your message has been received and we will be contacting you within 48 hours to answer you inquiry." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             
             [alt show];

             
             alt.tag=101;
             
         }
         else
         {
             UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             alt1.tag=111;
             [alt1 show];
         }
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alt1.tag=111;
         [alt1 show];
         
     }];
    
}

#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==101) {
        if (buttonIndex==0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    
    if (alertView.tag==111) {
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
 
}


@end
