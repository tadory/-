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
#import "Detail.h"


@implementation ZAIKO {
   Item *passItem;
    NSIndexPath *passIndexPath;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    zyouge =NO;
    
    douka=NO;
    sakuzyo=NO;
    
    sakuzyoButton.enabled = NO;
    sakuzyoButton.tintColor = [UIColor clearColor];
    zaikoSearchBar.delegate = self;
    
    itemTableview.delegate = self;
    itemTableview.dataSource = self;
    
    if (!contentArray) {
        contentArray = [[NSMutableArray alloc] init];
    }
    
    if (!searchItemArray) {
        searchItemArray = [NSMutableArray new];
    }
    
    // デフォルトの通知センターを取得する
    [self reloadCellContent];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(reloadCellContent) name:@"Tuchi" object:nil];
    
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self selector:@selector(sakuzyo) name:@"Sakuzyo" object:nil];
    
    NSLog(@"viewDidLoad == %@",contentArray);
}


-(void)reloadCellContent{
    // ここに何かの処理を記述する
    NSData* classDataLoad = [[NSUserDefaults standardUserDefaults]  dataForKey:@"ItemArray"];
    contentArray = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
    [itemTableview reloadData];
    
    NSLog(@"result==%@",contentArray);
}

-(void)sakuzyo{
    sakuzyo=YES;
    NSString *message = [NSString stringWithFormat:@"%@を在庫から消去します",((Item *)contentArray[IndexPath]).name];
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"確認" message:message delegate:self cancelButtonTitle:@"はい" otherButtonTitles:nil, nil];
    alert.cancelButtonIndex = 1;
    [alert show];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSData *classDataLoad = [[NSUserDefaults standardUserDefaults]  dataForKey:@"ItemArray"];
    NSMutableArray *ContentArray = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
    NSData *classDataSave = [NSKeyedArchiver archivedDataWithRootObject:ContentArray];
    NSNotification *nc;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSLog(@"buttonIndex == %d", (int)buttonIndex);
    switch (buttonIndex) {
        case 0:
        {
            [contentArray removeObjectAtIndex:IndexPath];
            classDataSave = [NSKeyedArchiver archivedDataWithRootObject:contentArray];
            [[NSUserDefaults standardUserDefaults]setObject:classDataSave forKey:@"ItemArray"];
            [ud synchronize];
            
            [itemTableview reloadData];
            /*
             [itemTableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
             [itemTableview endUpdates];
             */
            sakuzyo=NO;
            break;
            
        }
        case 1:
            
            ((Item *)contentArray[IndexPath]).count=1;
            classDataSave = [NSKeyedArchiver archivedDataWithRootObject:contentArray];
            [[NSUserDefaults standardUserDefaults]setObject:classDataSave forKey:@"ItemArray"];
            nc = [NSNotification notificationWithName:@"Tuchi" object:self];
            [[NSNotificationCenter defaultCenter]postNotification:nc];
            [ud synchronize];
            [itemTableview reloadData];
            NSLog(@"数は%ld",(long)((Item *)contentArray[IndexPath]).count);
            NSNotification *noti_a=[NSNotification notificationWithName:@"stopreduce" object:self];
            [[NSNotificationCenter defaultCenter] postNotification:noti_a];
            break;
    }
}



- (void)viewDidAppear:(BOOL)animated {
    NSData* classDataLoad = [[NSUserDefaults standardUserDefaults]  dataForKey:@"ItemArray"];
    contentArray = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
    [itemTableview reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView ==  self.searchDisplayController.searchResultsTableView) {
        NSLog(@"%lu", (unsigned long)searchItemArray.count);
        return searchItemArray.count;
    } else {
        return contentArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    IndexPath = [NSIndexPath indexPathForRow:indexPath inSection:0];
    
    static NSString *cellIdentifier = @"ItemCell";
    cell = (ItemCell *)[itemTableview dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UIButton *upButton = (UIButton *)[cell viewWithTag:100];
    UIButton *downButton = (UIButton *)[cell viewWithTag:200];
    
    //編集ボタンが押されてない時はhidden YES
    if(zyouge==YES){
        upButton.hidden = NO;
        downButton.hidden = NO;
    }else{
        upButton.hidden = YES;
        downButton.hidden = YES;
    }
    

    
    Item *item;
    if (tableView ==  self.searchDisplayController.searchResultsTableView) {
        item = searchItemArray[indexPath.row];
    } else {
        item = contentArray[indexPath.row];
    }
    
    cell.nameLabel.text = item.name;
    cell.basyoLabel.text = item.basyo;
    cell.countLabel.text = [NSString stringWithFormat:@"%d個",(int)item.count];
    
    cell.tag = indexPath.row;
    
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    df.dateFormat = @"yyyy/MM/dd";
//    NSMutableArray *array =[[item.limitDateArray allKeys]mutableCopy];
    
    NSMutableArray *onlyKeyArray = [[item.limitDateArray allKeys] mutableCopy];
    NSMutableArray *arrKeys = [[onlyKeyArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy年 M月 d日"];
        NSDate *d1 = [df dateFromString:(NSString*) obj1];
        NSDate *d2 = [df dateFromString:(NSString*) obj2];
        return [d1 compare: d2];
    }]mutableCopy];
    
    for(int i;i<=contentArray.count-1;i++){
//        NSDate *today = [[NSDate alloc]init];
//        today = [NSDate date];
        NSData *classDataLoad = [[NSUserDefaults standardUserDefaults]dataForKey:@"ItemArray"];
        NSMutableArray *content_aArray = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
        NSMutableArray *onlyKeyArray = [[NSMutableArray alloc]init];
        onlyKeyArray = [[((Item *)content_aArray[i]).limitDateArray allKeys]mutableCopy];
//        NSDateFormatter *toint = [[NSDateFormatter alloc]init];
//        [toint setDateFormat:@"yyyyMd"];
//        NSDate *Date2 = [[NSDate alloc]init];
//        NSDateFormatter *df = [[NSDateFormatter alloc]init];
//        
//        NSString *Date1 = [toint stringFromDate:today];
//        NSInteger date1 = [Date1 intValue];
//        NSInteger date2 = [onlyKeyArray[0] intValue];
//        
//        int interval =date2 -date1;
        
        NSDate *date1 = [NSDate date];
        NSDateFormatter *toint = [[NSDateFormatter alloc]init];
        [toint setDateFormat:@"yyyy年M月d日"];
        NSDate *date2 = [toint dateFromString:onlyKeyArray[0]];
        float interval = [date1 timeIntervalSinceDate:date2];
        
        if([date1 isEqualToDate:date2]==YES){
            cell.kigenLabel.backgroundColor = [UIColor redColor];
        }else if([date1 earlierDate:date2]==date2){
            cell.kigenLabel.backgroundColor = [UIColor blackColor];
            cell.kigenLabel.textColor = [UIColor whiteColor];
        }else{
            if(interval<=3){
                cell.kigenLabel.backgroundColor = [UIColor redColor];
            }else{
                cell.kigenLabel.backgroundColor = [UIColor whiteColor];
            }
        }
        
        if(interval<=0){
            cell.kigenLabel.backgroundColor = [UIColor blackColor];
            cell.kigenLabel.textColor = [UIColor whiteColor];
        }else if(interval>0&&interval>3000){
            cell.kigenLabel.backgroundColor = [UIColor redColor];
        }else{
            cell.kigenLabel.backgroundColor = [UIColor whiteColor];
        }
        
    }
    
    cell.kigenLabel.text = arrKeys[0];
    
    return cell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
            //Segueの特定
        if ( [[segue identifier] isEqualToString:@"MainDetail"] ) {
            Detail *detail = segue.destinationViewController;
            //ここで遷移先ビューのクラスの変数receiveStringに値を渡している
            NSLog(@"passItem == %@", passItem);
            detail.receivedItems = passItem;
            detail.receivedIndexPath = passIndexPath;

        }
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    IndexPath = [NSIndexPath indexPathForRow:indexPath inSection:0];

    passItem = contentArray[indexPath.row];
    NSData *classDataLoad = [[NSUserDefaults standardUserDefaults]dataForKey:@"ItemArray"];
    NSMutableArray *contentArray_a = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
    
    passIndexPath = indexPath;
    [self performSegueWithIdentifier:@"MainDetail" sender:self];

}

#pragma mark - SearchBar Delegate
- (void)searchItem:(NSString *) searchText {
    // 検索処理
    for (Item *item in contentArray) {
        if ([searchText isEqualToString:item.name]) {
            
        }
    }
}

- (void)searchBarSearchButtonClicked: (UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self searchItem:searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *) searchText {
    NSLog(@"serch text=%@", searchText);
    if ([searchText length]!=0) {
        // インクリメンタル検索など
        [self filterContainsWithSearchText:searchText];
    }else {
        [itemTableview reloadData];
    }
}



#pragma mark - SearchDisplayController

- (void)filterContainsWithSearchText:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    NSLog(@"predicate == %@", predicate);
    
    contentArray = [[contentArray filteredArrayUsingPredicate:predicate] mutableCopy];
    NSLog(@"%@", searchItemArray);
    [itemTableview reloadData];
    NSData* classDataLoad = [[NSUserDefaults standardUserDefaults]  dataForKey:@"ItemArray"];
    contentArray = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
}

/*
- (BOOL)searchDisplayController:controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // 検索バーに入力された文字列を引数に、絞り込みをかけます
    [self filterContainsWithSearchText:searchString];
    
    // YESを返すとテーブルビューがリロードされます。
    // リロードすることでsearchItemArrayからテーブルビューを表示します
    return YES;
}
*/

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        
        [contentArray removeObjectAtIndex:indexPath.row];
        NSData *classDataSave = [NSKeyedArchiver archivedDataWithRootObject:contentArray];
        [[NSUserDefaults standardUserDefaults]setObject:classDataSave forKey:@"ItemArray"];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
    }
    
    
    
    
    // [tableView reloadRowsAtIndexPaths:[tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationAutomatic];
}


-(IBAction)sakuzyobutton{

        if(douka==NO){
        [self->itemTableview setEditing:YES animated:YES];
        douka=YES;
    }else{
        [self->itemTableview setEditing:NO animated:NO];
        douka=NO;
    }
}

-(IBAction)hensyuubutton{
    
    if (sakuzyoButton.enabled == NO) {
        sakuzyoButton.enabled = YES;
        zyouge=YES;
        sakuzyoButton.tintColor = [UIColor blueColor];
        [itemTableview reloadData];
    }else {
        sakuzyoButton.enabled = NO;
        sakuzyoButton.tintColor = [UIColor clearColor];
        zyouge=NO;
        if(douka==YES){
            [self->itemTableview setEditing:NO animated:NO];
            douka=NO;
        }
        [itemTableview reloadData];
    }
    
}


-(IBAction)UpButton:(UIButton *)buttonInfo{
    IndexPath = buttonInfo.superview.superview.tag;
}
-(IBAction)DownButton:(UIButton *)buttonInfo{
    IndexPath = buttonInfo.superview.superview.tag;
}



@end
