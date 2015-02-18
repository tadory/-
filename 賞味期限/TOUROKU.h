//
//  TOUROKU.h
//  賞味期限
//
//  Created by 田所　龍 on 2015/02/07.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOUROKU : UIViewController{
    int i;
    
    UITextField *texta;
    UITextField *textb;
    UITextField *textc;
    
    NSMutableArray *hinmeiarray;
    NSMutableArray *hinsuuarray;
    NSMutableArray *basyoarray;
    NSMutableArray *kigenarray;
    
    UIDatePicker *Datepicker;
}


@end
