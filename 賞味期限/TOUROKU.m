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


#pragma mark - View Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    texta_i=false;
    textb_i=false;
    textc_i=false;
    kigen_i=false;
    ArrayRecognize = NO;
    
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
    
    if (!item) {
        item = [[Item alloc] initWithCoder:nil];
    }
    
    if (!item.limitDateArray) {
        item.limitDateArray = [[NSMutableDictionary alloc] init];
    }
}

#pragma mark - DatePicker
- (void)datepicker:(UIDatePicker* )picker {
    kigen_i=true;
    [self shouldShowButtonA];
}

- (void)shouldShowButtonA {
    if (kigen_i && texta_i && textb_i && textc.selectedSegmentIndex>=0) {
        buttona.hidden = NO;
    }
}


#pragma mark - Save (RegisterButton)

-(void)buttona{
    
    // ここでitemインスタンスが残っているので、一旦初期化
    item = [[Item alloc] initWithCoder:nil];
    item.limitDateArray = [[NSMutableDictionary alloc] init];

    
    // TODO: ここですでに前の値が残ってしまっている。
    NSLog(@"TAPPED %@", item.limitDate);
    
    item.name = texta.text;
    item.count = [textb.text integerValue];
    item.basyo = basyoArray[textc.selectedSegmentIndex];
    item.limitDate = datepicker.date;
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年 M月 d日"];
    NSString *Date = [formatter stringFromDate:datepicker.date];
    NSString *Number = [NSString stringWithFormat:@"%ld",(long)item.count];
    
    
    
    [item.limitDateArray setValue:Number forKey:Date];
    

    
    // 取得
    NSData* classDataLoad = [[NSUserDefaults standardUserDefaults]  dataForKey:@"ItemArray"];
    NSMutableArray *itemArray = [[NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad] mutableCopy];
    
    if (itemArray == nil && itemArray.count == 0) {
        itemArray = [[NSMutableArray alloc] init];
    }
    
    
    // TODO: 不要なものが辞書or配列内にあるのを防ぐ
    for(int a = 0; a < itemArray.count; a++) {
        NSString *name = ((Item *)itemArray[a]).name;
        NSString *searchstring = ((Item *)item).name;
        NSRange range =[name rangeOfString:searchstring options:NSCaseInsensitiveSearch];
        
        NSLog(@"NAME===%@,SEARCHSTRING==%@",name,searchstring);
        
        if(range.length == searchstring.length && name.length == range.length) {
            ((Item *)itemArray[a]).count = ((Item *)itemArray[a]).count+((Item *)item).count;
            NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy年 M月 d日"];
            ArrayRecognize = YES;
            
//            if(![((Item *)itemArray[a]).limitDateArray valueForKey:Date]) {
//                NSString *bb = [NSString stringWithFormat:@"%d",0];
//                ((Item *)itemArray[a]).limitDateArray[Date] = bb;
//            }
            
            // 在庫の数の管理
            NSString *motomotostring = [((Item *)itemArray[a]).limitDateArray valueForKey:Date];
            NSInteger motomoto = [motomotostring integerValue];
            NSInteger numberOfItems = motomoto + item.count;
            NSString *numberString = [NSString stringWithFormat:@"%ld",(long)numberOfItems];
            [((Item *)itemArray[a]).limitDateArray setValue:numberString forKey:Date];
            NSLog(@"かぶってます");
        }else {
            NSLog(@"かぶってないっす");
        }
    }
    
    if(ArrayRecognize == NO) {
        [itemArray addObject:item];
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy/MM/dd";
    NSString *datestring = [df stringFromDate:item.limitDate];
    NSString *alertMessage = [NSString stringWithFormat:@"%@,%ld,%@,%@を保存しました",item.name,(long)item.count,item.basyo,datestring];
    
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"message" message:alertMessage delegate:nil cancelButtonTitle:@"完了" otherButtonTitles:nil];
    [alert show];
    
    //日付をソート
    for(int b;b<=itemArray.count;b++){
    NSMutableArray *onlyKeyArray = [[((Item *)itemArray[b]).limitDateArray allKeys] mutableCopy];
    NSMutableArray *arrKeys = [[onlyKeyArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy年 M月 d日"];
        NSDate *d1 = [df dateFromString:(NSString*) obj1];
        NSDate *d2 = [df dateFromString:(NSString*) obj2];
        return [d1 compare: d2];
    }]mutableCopy];
    }
    
    // MARK: Save
    NSData *classDataSave = [NSKeyedArchiver archivedDataWithRootObject:itemArray];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:classDataSave forKey:@"ItemArray"];
    [ud synchronize]; //即時保存
    [self initAll];
}

// Init
- (void)initAll {
    [texta setText:@""];
    [textb setText:@""];
    textc.selectedSegmentIndex=0;
    
    texta_i=false;
    textb_i=false;
    textc_i=false;
    kigen_i=false;
    
    [datepicker setDate:[NSDate date]];
    
    buttona.hidden = YES;
}



#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == texta) {
        texta_i = YES;
        ArrayRecognize=NO;
    } else if (textField == textb) {
        textb_i = YES;
        ArrayRecognize=NO;
    }
    return YES;
}



@end
