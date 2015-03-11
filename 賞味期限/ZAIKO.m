//
//  ZAIKO.m
//  賞味期限
//
//  Created by 田所　龍 on 2015/02/19.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import "ZAIKO.h"
#import "Item.h"
#import "ItemCell.h"

@implementation ZAIKO
-(void)viewDidLoad{
    [super viewDidLoad];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    NSData* classDataLoad = [[NSUserDefaults standardUserDefaults]  dataForKey:@"ItemArray"];
    contentArray = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ItemCell";
    ItemCell *cell = (ItemCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Item *item = contentArray[indexPath.row];
    
    cell.nameLabel.text = item.name;
    cell.basyoLabel.text = item.basyo;
    cell.countLabel.text = [NSString stringWithFormat:@"%d個",(int)item.count];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy/MM/dd";
    
    cell.kigenLabel.text = [df stringFromDate:item.limitDate];
    
    return cell;
}






@end
