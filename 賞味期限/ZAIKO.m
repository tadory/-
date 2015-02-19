//
//  ZAIKO.m
//  賞味期限
//
//  Created by 田所　龍 on 2015/02/19.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import "ZAIKO.h"

@implementation ZAIKO
-(void)viewDidLoad{
    [super viewDidLoad];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    contentArray = @[@"りゅう", @"たか", @"がちゃぴん", @"まっすー"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //セルの数
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // セルが作成されていないか?
    if (!cell) { // yes
        // セルを作成
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // セルにテキストを設定
    cell.textLabel.text = [contentArray objectAtIndex:indexPath.row];
    
    return cell;
}






@end
