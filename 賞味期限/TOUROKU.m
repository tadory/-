//
//  TOUROKU.m
//  賞味期限
//
//  Created by 田所　龍 on 2015/02/07.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import "TOUROKU.h"

@implementation TOUROKU
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    texta = [[UITextField alloc] initWithFrame:CGRectMake(56, 65, 208, 30)];
    texta.borderStyle =UITextBorderStyleRoundedRect;
    texta.KeyboardType=UIKeyboardTypeDefault;
    texta.textAlignment=UITextAlignmentLeft;
    texta.placeholder=@"品名";
    texta.clearButtonMode=UITextFieldViewModeAlways;
    [texta addTarget:self action:@selector(HINMEI:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [texta becomeFirstResponder];
    [self.view addSubview:texta];
    
    textb = [[UITextField alloc] initWithFrame:CGRectMake(56, 128, 208, 30)];
    textb.borderStyle =UITextBorderStyleRoundedRect;
    textb.KeyboardType=UIKeyboardTypeDefault;
    textb.textAlignment=UITextAlignmentLeft;
    textb.placeholder=@"品数";
    textb.clearButtonMode=UITextFieldViewModeAlways;
    [textb addTarget:self action:@selector(HINSUU:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [textb becomeFirstResponder];
    [self.view addSubview:textb];
    
    textc = [[UITextField alloc] initWithFrame:CGRectMake(56, 194, 208, 30)];
    textc.borderStyle =UITextBorderStyleRoundedRect;
    textc.KeyboardType=UIKeyboardTypeDefault;
    textc.textAlignment=UITextAlignmentLeft;
    textc.placeholder=@"場所";
    textc.clearButtonMode=UITextFieldViewModeAlways;
    [textc addTarget:self action:@selector(BASYO:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [textc becomeFirstResponder];
    [self.view addSubview:textc];
    
    Datepicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(15, 250, 289, 120)];
    Datepicker.datePickerMode=UIDatePickerModeDate;
    Datepicker.minimumDate = [NSDate date];
    Datepicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    [Datepicker addTarget:self action:@selector(datepicker) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:Datepicker];
    
    UIButton *buttona = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttona.frame =CGRectMake(103, 462, 115, 49);
    [buttona setTitle:@"登録" forState:UIControlStateNormal];
    [buttona addTarget:self action:@selector(buttona) forControlEvents:UIControlEventTouchUpInside];
   
    
    hinmeiarray =[NSMutableArray array];
    hinsuuarray =[NSMutableArray array];
    basyoarray =[NSMutableArray array];
    kigenarray =[NSMutableArray array];
    
    
}

-(void)HINMEI{
    
    
}

-(void)HINSUU{
    
}

-(void)BASYO{
    
}
-(void)datepicker{
    
}
-(void)buttona{
//    NSUserDefaults *hinmei =[NSUserDefaults standardUserDefaults];
//    [hinmei setObject:texta.text forKey:@"hinmei"];
//    
//    NSUserDefaults*hinsuu =[NSUserDefaults standardUserDefaults];
//    [hinsuu setObject:textb.text forKey:@"hinsuu"];
//    
//    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy年 M月 d日"];
//    NSString *Date =[formatter stringFromDate:Datepicker.date];
//    
//    NSUserDefaults*datepicker =[NSUserDefaults standardUserDefaults];
//    [datepicker setObject:Date forKey:@"datepicker"];
    
    [hinmeiarray addObject:texta.text];
    [hinsuuarray addObject:textb.text];
    [basyoarray addObject:textc];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年 M月 d日"];
    NSString *Date =[formatter stringFromDate:Datepicker.date];
    [kigenarray addObject:Date];
    
    NSUserDefaults *hinmei =[NSUserDefaults standardUserDefaults];
    [hinmei setObject:hinmeiarray forKey:@"hinmei"];
    
    NSUserDefaults *hinsuu =[NSUserDefaults standardUserDefaults];
    [hinsuu setObject:hinsuuarray forKey:@"hinsuu"];
    
    NSUserDefaults *basyo=[NSUserDefaults standardUserDefaults];
    [basyo setObject:basyoarray forKey:@"basyo"];
    
    NSUserDefaults *kigen=[NSUserDefaults standardUserDefaults];
    [kigen setObject:kigenarray forKey:@"kigen"];
    
    
    UIAlertView *alert =[[UIAlertView alloc] init];
    
}


@end
