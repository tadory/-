//
//  Detail.h
//  賞味期限
//
//  Created by 田所　龍 on 2015/06/17.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"


@interface Detail : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    Item *items;
    IBOutlet UITableView *itemTableViewtwo;
    NSMutableArray *contentArray;
    
    NSInteger no;
    NSString* furigana;
    NSDate* publish_date;
}

-(NSComparisonResult) comparePublishDate:(Detail *)_item;

@property (nonatomic)Item *receivedItems;



@end
