//
//  TOUROKU.m
//  賞味期限
//
//  Created by 田所　龍 on 2015/02/07.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import "TOUROKU.h"
#import "Item.h"

@implementation TOUROKU
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    texta_i=false;
    textb_i=false;
    textc_i=false;
    kigen_i=false;
    
    texta = [[UITextField alloc] initWithFrame:CGRectMake(56, 65, 208, 30)];
    texta.borderStyle =UITextBorderStyleRoundedRect;
    texta.KeyboardType=UIKeyboardTypeDefault;
    texta.placeholder=@"品名";
    texta.delegate = self;
    
        texta.clearButtonMode=UITextFieldViewModeAlways;
//    [texta addTarget:self action:@selector(HINMEI) forControlEvents:UIControlEventEditingDidEndOnExit];
    [texta becomeFirstResponder];
    [self.view addSubview:texta];
    
    textb = [[UITextField alloc] initWithFrame:CGRectMake(56, 128, 208, 30)];
    textb.borderStyle =UITextBorderStyleRoundedRect;
    textb.KeyboardType=UIKeyboardTypeDefault;
    textb.placeholder=@"品数";
    textb.delegate = self;
    textb.clearButtonMode=UITextFieldViewModeAlways;
//    [textb addTarget:self action:@selector(HINSUU) forControlEvents:UIControlEventEditingDidEndOnExit];
    [textb becomeFirstResponder];
    [self.view addSubview:textb];
    
//    textc = [[UITextField alloc] initWithFrame:CGRectMake(56, 194, 208, 30)];
//    textc.borderStyle =UITextBorderStyleRoundedRect;
//    textc.KeyboardType=UIKeyboardTypeDefault;
//    textc.placeholder=@"場所";
//    textc.delegate = self;
//
//    textc.clearButtonMode=UITextFieldViewModeAlways;
////    [textc addTarget:self action:@selector(BASYO) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [textc becomeFirstResponder];
//    [self.view addSubview:textc];
    NSArray *BasyoArray =[NSArray arrayWithObjects:@"冷蔵庫",@"棚",@"その他",nil];
    textc=[[UISegmentedControl alloc]initWithItems:BasyoArray];
    textc.frame=CGRectMake(56,194,208,30);
    textc.segmentedControlStyle=UISegmentedControlStylePlain;
    textc.selectedSegmentIndex=0;
    [textc addTarget:self action:@selector(BASYO) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:textc];
    
    
    
    datepicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(15, 250, 289, 120)];
    datepicker.datePickerMode=UIDatePickerModeDate;
    datepicker.minimumDate = [NSDate date];
    datepicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    [datepicker addTarget:self action:@selector(datepicker:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datepicker];
    
    buttona = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttona.frame =CGRectMake(103, 462, 115, 49);
    [buttona setTitle:@"登録" forState:UIControlStateNormal];
    [buttona addTarget:self action:@selector(buttona) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttona];
    buttona.hidden = YES;
    
    
//    NSData* classDataSave = [NSKeyedArchiver archivedDataWithRootObject:[[NSMutableArray alloc] init]];
//    [[NSUserDefaults standardUserDefaults] setObject:classDataSave forKey:@"ItemArray"];
    
//    hinmeiarray =[NSMutableArray array];
//    hinsuuarray =[NSMutableArray array];
//    basyoarray =[NSMutableArray array];
//    kigenarray =[NSMutableArray array];
    
    
}

//-(void)HINMEI{
//    texta_i=true;
//}
//
//-(void)HINSUU{
//    textb_i=true;
//}
//
//-(void)BASYO{
//    textc_i=true;
//}
- (void)datepicker:(UIDatePicker* )picker {
    kigen_i=true;
    [self shouldShowButtonA];
}

- (void)shouldShowButtonA {
    if (kigen_i && texta_i && textb_i && textc_i) {
        buttona.hidden = NO;
    }
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
    
    Item *item = [[Item alloc] initWithCoder:nil];
    item.name = texta.text;
    item.count = [textb.text integerValue];
    item.basyo = (NSString*)textc;
    item.limitDate = datepicker.date;
    
    NSLog(@"item to be added %@", item.debugDescription);
    
    // 取得
    NSData* classDataLoad = [[NSUserDefaults standardUserDefaults]  dataForKey:@"ItemArray"];
    NSMutableArray *itemArray = [[NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad] mutableCopy];
    
    if (itemArray == nil && itemArray.count == 0) {
        itemArray = [[NSMutableArray alloc] init];
    }
    
    [itemArray addObject:item];
    
    NSLog(@"new array %@", itemArray);
    
    // 保存
    NSData* classDataSave = [NSKeyedArchiver archivedDataWithRootObject:itemArray];
    [[NSUserDefaults standardUserDefaults] setObject:classDataSave forKey:@"ItemArray"];
    
//    [hinmeiarray addObject:texta.text];
//    [hinsuuarray addObject:textb.text];
//    [basyoarray addObject:textc];
    
//    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy年 M月 d日"];
//    NSString *Date =[formatter stringFromDate:Datepicker.date];
//    [kigenarray addObject:Date];
//    
//    NSUserDefaults *hinmei =[NSUserDefaults standardUserDefaults];
//    [hinmei setObject:hinmeiarray forKey:@"hinmei"];
//    
//    NSUserDefaults *hinsuu =[NSUserDefaults standardUserDefaults];
//    [hinsuu setObject:hinsuuarray forKey:@"hinsuu"];
//    
//    NSUserDefaults *basyo=[NSUserDefaults standardUserDefaults];
//    [basyo setObject:basyoarray forKey:@"basyo"];
//    
//    NSUserDefaults *kigen=[NSUserDefaults standardUserDefaults];
//    [kigen setObject:kigenarray forKey:@"kigen"];
    
    
    
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"message" message:@"texta.text,textb.text,textc.text,Dateで設定しました" delegate:nil cancelButtonTitle:@"完了"otherButtonTitles:nil, nil];
    [alert show];
    
    [texta setText:@""];
    [textb setText:@""];
//    [textc setText:@""];
    textc.selectedSegmentIndex=0;
    
    texta_i=false;
    textb_i=false;
    textc_i=false;
    kigen_i=false;
    
    [datepicker setDate:[NSDate date]];
    
    buttona.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == texta) {
        texta_i = YES;
    } else if (textField == textb) {
        textb_i = YES;
    } else  {
        textc_i = YES;
    }

}

@end
