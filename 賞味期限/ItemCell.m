//
//  ItemCell.m
//  賞味期限
//
//  Created by 田所　龍 on 2015/02/26.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import "ItemCell.h"
#import "Item.h"


@implementation ItemCell


- (IBAction)upButtonPushed:(UIButton *)buttonInfo {
    //押されたボタンの情報
    NSLog(@"up buttonInfo ==  %@", buttonInfo);
    NSLog(@"tag ==  %ld", (long)buttonInfo.superview.superview.tag);
    
    NSMutableArray *contentArray;
    
    int index = buttonInfo.superview.superview.tag;

    //NSIndexPath *indexPath;
    NSData *classDataLoad =[[NSUserDefaults standardUserDefaults] dataForKey:@"ItemArray"];
    contentArray =[NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
    ((Item *)contentArray[index]).count=((Item *)contentArray[index]).count+1;
    NSData* classDataSave = [NSKeyedArchiver archivedDataWithRootObject:contentArray];
    [[NSUserDefaults standardUserDefaults] setObject:classDataSave forKey:@"ItemArray"];
    NSLog(@"count == %ld",(long)((Item *)contentArray[index]).count);
    NSNotification *nc=[NSNotification  notificationWithName:@"Tuchi" object:self];
    [[NSNotificationCenter defaultCenter]postNotification:nc];
    
    
    
    
    /* TODO */
    /*
     UserDefaultsに保存されているItemsクラスの配列オブジェクトを取り出して、COUNTキーをイジる
     */
}
- (IBAction)downButtonPushed:(UIButton *)buttonInfo {
    NSLog(@"down buttonInfo ==  %@", buttonInfo);
    
    int index = buttonInfo.superview.superview.tag;
    
    NSData* classDataLoad = [[NSUserDefaults standardUserDefaults]  dataForKey:@"ItemArray"];
    NSMutableArray *contentArray = [[NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad] mutableCopy];
    ((Item *)contentArray[index]).count=((Item *)contentArray[index]).count-1;
    NSData *classDataSave = [NSKeyedArchiver archivedDataWithRootObject:contentArray];
    [[NSUserDefaults standardUserDefaults]setObject:classDataSave forKey:@"ItemArray"];
    
    NSNotification *nc=[NSNotification  notificationWithName:@"Tuchi" object:self];
    [[NSNotificationCenter defaultCenter]postNotification:nc];
    
    if(((Item *)contentArray[index]).count==0){
    NSNotification *noti = [NSNotification notificationWithName:@"Sakuzyo" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:noti];
    }
}
@end
