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
    UITextField  *texta = [[UITextField alloc] initWithFrame:CGRectMake(56, 65, 208, 30)];
    texta.borderStyle =UITextBorderStyleRoundedRect;
    texta.KeyboardType=UIKeyboardTypeDefault;
    texta.textAlignment=UITextAlignmentLeft;
    texta.placeholder=@"品名を入力してください";
    texta.clearButtonMode=UITextFieldViewModeAlways;
    [texta addTarget:self action:@selecter(HINMEI) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:texta];
}

-(void)HINMEI{
    NSUserDefaults*hinmei =[NSUserDefaults standardUserDefaults];
    
}


@end
