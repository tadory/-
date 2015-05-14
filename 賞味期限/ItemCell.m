//
//  ItemCell.m
//  賞味期限
//
//  Created by 田所　龍 on 2015/02/26.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell


- (IBAction)upButtonPushed {
    NSLog(@"up");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    /* TODO */
    /*
     UserDefaultsに保存されているItemsクラスの配列オブジェクトを取り出して、COUNTキーをイジる
     */
}
- (IBAction)downButtonPushed {
    NSLog(@"down");
}


@end
