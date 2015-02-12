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
    [texta addTarget:self action:@selector(HINMEI:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:texta];
    
    UITextField  *textb = [[UITextField alloc] initWithFrame:CGRectMake(56, 128, 208, 30)];
    textb.borderStyle =UITextBorderStyleRoundedRect;
    textb.KeyboardType=UIKeyboardTypeDefault;
    textb.textAlignment=UITextAlignmentLeft;
    textb.placeholder=@"品数を入力してください";
    textb.clearButtonMode=UITextFieldViewModeAlways;
    [textb addTarget:self action:@selector(HINSUU:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:textb];
    
    UITextField  *textc = [[UITextField alloc] initWithFrame:CGRectMake(56, 194, 208, 30)];
    textc.borderStyle =UITextBorderStyleRoundedRect;
    textc.KeyboardType=UIKeyboardTypeDefault;
    textc.textAlignment=UITextAlignmentLeft;
    textc.placeholder=@"品数を入力してください";
    textc.clearButtonMode=UITextFieldViewModeAlways;
    [textc addTarget:self action:@selector(BASYO:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:textc];


}

-(void)HINMEI{
    NSUserDefaults*HINMEI =[NSUserDefaults standardUserDefaults];
    
}

-(void)HINSUU{
    
}

-(void)BASYO{
    
}


@end
