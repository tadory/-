//
//  ZAIKO.h
//  賞味期限
//
//  Created by 田所　龍 on 2015/02/19.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCell.h"
//@property (nonatomic,weak) IBOutlet UISearchBar *search;

@interface ZAIKO : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UIAlertViewDelegate, UISearchDisplayDelegate>
{
    ItemCell *cell;
    
    IBOutlet UITableView *itemTableview;
    IBOutlet UIBarButtonItem *sakuzyoButton;
    IBOutlet UISearchBar *zaikoSearchBar;

    NSMutableArray *contentArray;
    NSMutableArray *searchItemArray;
    int IndexPath;
    
    BOOL douka;
    BOOL sakuzyo;
    BOOL zyouge;
}
-(IBAction)sakuzyobutton;
-(IBAction)hensyuubutton;
- (IBAction)UpButton:(UIButton *)buttonInfo;
- (IBAction)DownButton:(UIButton *)buttonInfo;


@end