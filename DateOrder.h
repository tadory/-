//
//  DateOrder.h
//  賞味期限
//
//  Created by 田所　龍 on 2015/07/13.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateOrder : NSObject

-(NSComparisonResult)compareWithDate:(DateOrder *)date;
@property NSComparisonResult compareWithDate;
@property (strong, nonatomic) NSString *text1;
@property (strong, nonatomic) NSDate *date1;

@end
