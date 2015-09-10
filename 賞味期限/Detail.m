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
    // NSLog(@"contentArray == %@", contentArray);
    
    NSMutableArray *onlykeyArray_a = [[NSMutableArray alloc] init];
    onlykeyArray_a = [[((Item *)contentArray[items_indexpath.row]).limitDateArray allKeys] mutableCopy];

    if(items.limitDateArray[onlykeyArray_a[0]]==0){
//        NSData *classDataLoad = [[NSUserDefaults standardUserDefaults] dataForKey:@"ItemArray"];
//        contentArray = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
//        
//        NSMutableArray *onlykeyArray_a = [[NSMutableArray alloc] init];
//        onlykeyArray_a = [[((Item *)contentArray[items_indexpath.row]).limitDateArray allKeys] mutableCopy];
//        [((Item *)contentArray[items_indexpath.row]).limitDateArray removeObjectForKey:onlykeyArray_a[0]];
//        NSData *classDataSave = [NSKeyedArchiver archivedDataWithRootObject:contentArray];
//        [[NSUserDefaults standardUserDefaults]setObject:classDataSave forKey:@"ItemArray"];
    }
    
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self selector:@selector(Sakuzyo_a:) name:@"Sakuzyo_a" object:nil];
    [noti addObserver:self selector:@selector(StopReduce:) name:@"stopreduce" object:nil];
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

    onlyKeyArray = [[items.limitDateArray allKeys] mutableCopy];
    NSMutableArray *arrKeys = [[onlyKeyArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy年 M月 d日"];
        NSDate *d1 = [df dateFromString:(NSString*) obj1];
        NSDate *d2 = [df dateFromString:(NSString*) obj2];
        return [d1 compare: d2];
    }]mutableCopy];
    //onlyKeyArray = [[onlyKeyArray sortedArrayUsingSelector:@selector(comparePublishDate:)]mutableCopy];
    
    cell.kigenLabel.text =[NSString stringWithFormat:@"%@",arrKeys[indexPath.row]];
    cell.kosuuLabel.text =[NSString stringWithFormat:@"%@",items.limitDateArray[arrKeys[indexPath.row]]];
    
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

-(void)StopReduce:(NSNotificationCenter *)notificationCenter{
    NSData *classDataLoad = [[NSUserDefaults standardUserDefaults]dataForKey:@"ItemArray"];
    NSMutableArray *contentArray_b=[[NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad]mutableCopy];
    
}

@end
