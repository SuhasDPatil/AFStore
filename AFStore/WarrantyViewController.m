//
//  WarrantyViewController.m
//  AFStoreNew
//
//  Created by rac on 07/08/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "WarrantyViewController.h"

@interface WarrantyViewController ()

@end

@implementation WarrantyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=LocalizedString(@"Warranty");
    
    
    self.lblDiamond.text=LocalizedString(@"Diamond");
    self.lblGold.text=LocalizedString(@"Gold");
    self.lblSilver.text=LocalizedString(@"Silver");
    
    self.lblGuarranty1.text=LocalizedString(@"Guarantee");
    self.lblGuarranty2.text=LocalizedString(@"Guarantee");
    self.lblGuarranty3.text=LocalizedString(@"Guarantee");

    
    
    
    
    
    [self setNavBar];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)diamondGClicked:(id)sender
{
    wdvc=[[WarrantyDeytailsViewController alloc]init];
    wdvc.btnInfo=@"Diamod Warranty";
    
    
    wdvc.tab1=@"\n الصيانه تكون مجانيه لمدة سنة كامله \n يجب احضار وصل الشراء عند المطالبة بحق الضمان وحتى ان انتقلت ملكية الجهاز لشخص اخر. \n تكون مدة الصيانه كحد اقصى 10 أيام .  \n لا يسمح للعميل استرجاع القيمه النقديه للشراء وفي حال قرر مركز الصيانة تبديل الجهاز ولم يتوفر نفس الموديل سيتم التعويض بنفس مواصفات الجهاز. \n الشاشه تخرج من الضمان في حالة سوء الاستخدام (كسر الشاشه) . \n لايدخل الجهاز بالضمان في حال تعرضه لسوائل او تيار كهربائي. \n من حق صيانة الشركة فتح الاجهزه لأصلاحها ان تطلب ذلك دون الرجوع للعميل. \n الضمان لا يشمل ملحقات الجهاز (شاحن , السماعات , البطاريه ..الخ). \n ";
    
    
    
    wdvc.tab2=@"\n  الشاشه تخرج من الضمان في حالة سوء الاستخدام (كسر الشاشه) . \n محاولة صيانة الجهاز خارج مركز صاينة الشركة . \n فقدان أو تضرر الرقم التسلسلي (IMEI) او اضافة (JAILBREAK ) أو (  ROOT). \n ";
    
    
    [self.navigationController pushViewController:wdvc animated:YES];
    
}

- (IBAction)goldGClicked:(id)sender
{
    wdvc=[[WarrantyDeytailsViewController alloc]init];
    wdvc.btnInfo=@"Gold Warranty";
    
    wdvc.tab1=@"\n صيانة السوفتوير مجاناً  مدي الحياة (تشمل الضمان الفضي) \n صيانة الهاردوير مناصفة بين الشركة والزبون\n يجب احضار وصل الشراء عند المطالبة بحق الضمان وحتى ان انتقلت ملكية الجهاز لشخص اخر. \n تكون مدة الصيانه كحد اقصى 10 أيام. \n الشاشه تخرج من الضمان في حالة سوء الاستخدام (كسر الشاشه) . \n من حق صيانة الشركة فتح الاجهزه لأصلاحها ان تطلب ذلك دون الرجوع للعميل. \n لايدخل الجهاز بالضمان في حال تعرضه لسوائل او تيار كهربائي. \n الضمان لا يشمل ملحقات الجهاز (شاحن , السماعات , البطاريه ..الخ). \n ";
    
    
    wdvc.tab2=@"يخرج الجهاز من الضمان في الحالات التالية: \n  محاولة صيانة الجهاز خارج مركز صيانة الشركة. \n فقدان أو تضرر الرقم التسلسلي (IMEI).  إضافة (JAILBREAK) أو (ROOT). \n لايدخل الجهاز بالضمان في حال تعرضه لسوائل او تيار كهربائي. \n الضمان لا يشمل ملحقات الجهاز (شاحن , السماعات , البطاريه ..الخ). \n  الشاشه تخرج من الضمان في حالة سوء الاستخدام (كسر الشاشه) . \n ";
    
    
    [self.navigationController pushViewController:wdvc animated:YES];
    
}

- (IBAction)silverGClicked:(id)sender
{
    
    wdvc=[[WarrantyDeytailsViewController alloc]init];
    wdvc.btnInfo=@"Silver Warranty";
    
    wdvc.tab1=@"\n ضمان سوفتوير مدى الحياة. \n  يجب إحضار وصل الشراء عند المطالبة بحق الضمان وحتى إن انتقلت ملكية الجهاز لشخص أخر. \n تكون مدة الصيانة كحد أقصى 10 أيام. \n مركز الصيانة غير مسؤول عن فقدان البيانات المخزونة في الجهاز. \n ";

    wdvc.tab2=@"\n يخرج الجهاز من الضمان في الحالات التالية:  \n محاولة صيانة الجهاز خارج مركز صيانة الشركة.  \n فقدان أو تضرر الرقم التسلسلي (IMEI).  \n إضافة (JAILBREAK) أو (ROOT). \n ";

    
    
    [self.navigationController pushViewController:wdvc animated:YES];
    
}


@end
