//
//  TOUROKU.h
//  賞味期限
//
//  Created by 田所　龍 on 2015/02/07.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOUROKU : UIViewController <UITextFieldDelegate> {
    int i;
    BOOL texta_i;
    BOOL textb_i;
    BOOL textc_i;
    BOOL kigen_i;
    BOOL ArrayRecognize;
    
    UITextField *texta;
    UITextField *textb;
    //UITextField *textc;
    UISegmentedControl *textc;
    
    UIButton *buttona;
    
//    NSMutableArray *hinmeiarray;
//    NSMutableArray *hinsuuarray;
    NSArray *basyoArray;
//    NSMutableArray *kigenarray;
    
    UIDatePicker *datepicker;
    
    UIButton *doneButton;
}



@end
