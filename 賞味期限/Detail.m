//
//  Detail.m
//  賞味期限
//
//  Created by 田所　龍 on 2015/06/17.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import "Detail.h"
#import "Item.h"
#import "ItemCelltwo.h"


@implementation Detail
- (void)viewDidLoad {
    [super viewDidLoad];
    
    items = self.receivedItems;
    NSLog(@"items == %@", items);
    
    itemTableViewtwo.delegate = self;
    itemTableViewtwo.dataSource = self;
    
    if (!contentArray) {
        contentArray = [NSMutableArray new];
        
    }
    
    NSData *classDataLoad = [[NSUserDefaults standardUserDefaults] dataForKey:@"ItemArray"];
    contentArray = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
    NSLog(@"contentArray == %@", contentArray);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return items.limitDateArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ItemCelltwo";
    ItemCelltwo *cell = (ItemCelltwo *)[itemTableViewtwo dequeueReusableCellWithIdentifier:cellIdentifier];
    NSLog(@"%lu",(unsigned long)items.limitDateArray.count);
    
    NSMutableArray *onlyKeyArray = [[items.limitDateArray allKeys] mutableCopy];
    for(int i;i<onlyKeyArray.count;i++){
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年 M月 d日"];
        onlyKeyArray[i] = [formatter dateFromString:onlyKeyArray[i]];
    }
    onlyKeyArray = [[onlyKeyArray sortedArrayUsingSelector:@selector(comparePublishDate:)]mutableCopy];
    
    
    
   // onlyKeyArray=[onlyKeyArray　sortedArrayUsingSelector:@((DateOrder *)compareWithDate)];
    cell.kigenLabel.text =[NSString stringWithFormat:@"%@",onlyKeyArray[indexPath.row]];
    cell.kosuuLabel.text =[NSString stringWithFormat:@"%@",items.limitDateArray[onlyKeyArray[indexPath.row]]];
    
    return cell;
}

-(NSComparisonResult) comparePublishDate:(Detail *)_item{
    return [self->publish_date compare:_item->publish_date];
}



@end
