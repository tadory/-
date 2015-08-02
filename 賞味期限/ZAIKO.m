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
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(reloadCellContent) name:@"Tuchi" object:nil];
    
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self selector:@selector(sakuzyo) name:@"Sakuzyo" object:nil];
}


-(void)reloadCellContent{
    // ここに何かの処理を記述する
    NSData* classDataLoad = [[NSUserDefaults standardUserDefaults]  dataForKey:@"ItemArray"];
    contentArray = [NSKeyedUnarchiver unarchiveObjectWithData:classDataLoad];
    [itemTableview reloadData];
}

-(void)sakuzyo{
    sakuzyo=YES;
    NSString *message = [NSString stringWithFormat:@"%@を在庫から消去しますか？",((Item *)contentArray[IndexPath]).name];
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"確認" message:message delegate:self cancelButtonTitle:@"いいえ" otherButtonTitles:@"はい", nil];
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
            ((Item *)contentArray[IndexPath]).count=1;
            classDataSave = [NSKeyedArchiver archivedDataWithRootObject:contentArray];
            [[NSUserDefaults standardUserDefaults]setObject:classDataSave forKey:@"ItemArray"];
            nc = [NSNotification notificationWithName:@"Tuchi" object:self];
            [[NSNotificationCenter defaultCenter]postNotification:nc];
            [ud synchronize];
            [itemTableview reloadData];
            NSLog(@"数は%ld",(long)((Item *)contentArray[IndexPath]).count);
            break;
        case 1:
            
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
    ItemCell *cell = (ItemCell *)[itemTableview dequeueReusableCellWithIdentifier:cellIdentifier];
    
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
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy/MM/dd";
    
    cell.kigenLabel.text = [df stringFromDate:item.limitDate];
    
    return cell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
            //Segueの特定
        if ( [[segue identifier] isEqualToString:@"MainDetail"] ) {
            Detail *detail = segue.destinationViewController;
            //ここで遷移先ビューのクラスの変数receiveStringに値を渡している
            detail.receivedItems = passItem;

        }
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    IndexPath = [NSIndexPath indexPathForRow:indexPath inSection:0];

    passItem = contentArray[indexPath.row];
    //IndexPath = indexPath;
    NSLog(@"%d", passItem);
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
