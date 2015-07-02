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
    ArrayRecognize=NO;
    
    texta = [[UITextField alloc] initWithFrame:CGRectMake(56, 65, 208, 30)];
    texta.borderStyle =UITextBorderStyleRoundedRect;
    texta.keyboardType=UIKeyboardTypeDefault;
    texta.placeholder=@"品名";
    texta.delegate = self;
    
    texta.clearButtonMode=UITextFieldViewModeAlways;
    //[texta addTarget:self action:@selector(HINMEI) forControlEvents:UIControlEventEditingDidEndOnExit];
    [texta becomeFirstResponder];
    [self.view addSubview:texta];
    
    textb = [[UITextField alloc] initWithFrame:CGRectMake(56, 128, 208, 30)];
    textb.borderStyle =UITextBorderStyleRoundedRect;
    textb.keyboardType=UIKeyboardTypeNumberPad;
    textb.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    textb.placeholder=@"品数";
    textb.delegate = self;
    textb.clearButtonMode=UITextFieldViewModeAlways;
    //[textb addTarget:self action:@selector(HINSUU) forControlEvents:UIControlEventEditingDidEndOnExit];
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
    basyoArray = @[@"冷蔵庫",@"棚",@"その他"];
    textc=[[UISegmentedControl alloc]initWithItems:basyoArray];
    textc.frame=CGRectMake(56,194,208,30);
    textc.selectedSegmentIndex=0;
    //textc.tintColor = [UIColor blackColor];
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

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//    //	Notification 登録
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//}

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
    if (kigen_i && texta_i && textb_i && textc.selectedSegmentIndex>=0) {
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
    
    //    if(textc.selectedSegmentIndex==0){
    //        item.basyo=@"冷蔵庫";
    //    }else if(textc.selectedSegmentIndex==1){
    //        item.basyo=@"棚";
    //    }else if(textc.selectedSegmentIndex==2){
    //        item.basyo=@"その他";
    //    }

    
    Item *item = [[Item alloc] initWithCoder:nil];
    item.name = texta.text;
    item.count = [textb.text integerValue];
    item.basyo = basyoArray[textc.selectedSegmentIndex];
    item.limitDate = datepicker.date;
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年 M月 d日"];
    NSString *Date =[formatter stringFromDate:datepicker.date];
    NSString *Number=[NSString stringWithFormat:@"%ld",(long)item.count];
    item.limitDateArray[Date] = Number;
    
    NSLog(@"item to be added %@", item.debugDescription);
    
    // 取得
    NSData* classDataLoad = [[NSUserDefaults standardUserDefaults]  dataForKey:@"ItemArray"];
    NSMutableArray *itemArray = [[NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad] mutableCopy];
    
    if (itemArray == nil && itemArray.count == 0) {
        itemArray = [[NSMutableArray alloc] init];
    }
    
    for(int a = 0; a < itemArray.count; a++){
        NSString *name = ((Item *)itemArray[a]).name;
        NSString *searchstring = ((Item *)item).name;
        NSRange range =[name rangeOfString:searchstring options:NSCaseInsensitiveSearch];
        if(range.length==searchstring.length && name.length==range.length){
            ((Item *)itemArray[a]).count = ((Item *)itemArray[a]).count+((Item *)item).count;
            ArrayRecognize=YES;
        }
    }
    
    
    
    if(ArrayRecognize==NO){
        [itemArray addObject:item];
    }
    
    
    
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
    
    //
//    NSString *datestrong = [item.limitDate description];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy/MM/dd";
    NSString *datestrong = [df stringFromDate:item.limitDate];
    //NSLog(@"%@",datestrong);
    NSString *AlertMessage = [NSString stringWithFormat:@"%@,%ld,%@,%@を保存しました",item.name,(long)item.count,item.basyo,datestrong];
    
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"message" message:AlertMessage delegate:nil cancelButtonTitle:@"完了" otherButtonTitles:nil, nil];
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

- (void)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == texta) {
        texta_i = YES;
        ArrayRecognize=NO;
        
    } else if (textField == textb) {
        textb_i = YES;
        ArrayRecognize=NO;
        //    } else  {
        //        textc_i = YES;
        //    }
        
    }}



@end
