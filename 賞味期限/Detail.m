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
    NSLog(@"%@", items);
    
    itemTableView.delegate = self;
    itemTableView.dataSource = self;
    
    NSData *classDataLoad = [[NSUserDefaults standardUserDefaults]dataForKey:@"ItemArray"];
    contentArray=[NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return items.limitDateArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%lu",(unsigned long)items.limitDateArray.count);
}


@end
