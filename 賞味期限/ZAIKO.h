//
//  ZAIKO.h
//  賞味期限
//
//  Created by 田所　龍 on 2015/02/19.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZAIKO : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tableview;
    NSArray *contentArray;
    
}

@end