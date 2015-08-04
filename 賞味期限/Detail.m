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
    items_indexpath = self.receivedIndexPath;
    
    itemTableViewtwo.delegate = self;
    itemTableViewtwo.dataSource = self;
    
    if (!contentArray) {
        contentArray = [[NSMutableArray alloc]init];
    }
    
    NSData *classDataLoad = [[NSUserDefaults standardUserDefaults] dataForKey:@"ItemArray"];
    contentArray = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
    NSLog(@"contentArray == %@", contentArray);
    
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self selector:@selector(Sakuzyo_a:) name:@"Sakuzyo_a" object:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSData *classDataLoad = [[NSUserDefaults standardUserDefaults] dataForKey:@"ItemArray"];
    contentArray = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
    return items.limitDateArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"ItemCelltwo";
    ItemCelltwo *cell = (ItemCelltwo *)[itemTableViewtwo dequeueReusableCellWithIdentifier:cellIdentifier];
    //NSLog(@"%lu",(unsigned long)items.limitDateArray.count);
    
    onlyKeyArray = [[items.limitDateArray allKeys] mutableCopy];
    //    for(int i;i<onlyKeyArray.count;i++){
    //        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //        [formatter setDateFormat:@"yyyy年 M月 d日"];
    //        onlyKeyArray[i] = [formatter dateFromString:onlyKeyArray[i]];
    //    }
    //onlyKeyArray = [[onlyKeyArray sortedArrayUsingSelector:@selector(comparePublishDate:)]mutableCopy];
    
    cell.kigenLabel.text =[NSString stringWithFormat:@"%@",onlyKeyArray[indexPath.row]];
    cell.kosuuLabel.text =[NSString stringWithFormat:@"%@",items.limitDateArray[onlyKeyArray[indexPath.row]]];
    
    return cell;
}


-(NSComparisonResult) comparePublishDate:(Detail *)_item{
    return [self->publish_date compare:_item->publish_date];
}

-(void)Sakuzyo_a:(NSNotificationCenter *)notificationCenter {
    NSData *classDataLoad = [[NSUserDefaults standardUserDefaults] dataForKey:@"ItemArray"];
    contentArray = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
    
    NSMutableArray *onlykeyArray_a = [[NSMutableArray alloc] init];
    onlykeyArray_a = [[((Item *)contentArray[items_indexpath.row]).limitDateArray allKeys] mutableCopy];
    [((Item *)contentArray[items_indexpath.row]).limitDateArray removeObjectForKey:onlykeyArray_a[0]];
    NSData *classDataSave = [NSKeyedArchiver archivedDataWithRootObject:contentArray];
    [[NSUserDefaults standardUserDefaults]setObject:classDataSave forKey:@"ItemArray"];
    [itemTableViewtwo reloadData];
    
}


@end
