//
//  DateOrder.m
//  賞味期限
//
//  Created by 田所　龍 on 2015/07/13.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import "DateOrder.h"

@implementation DateOrder

//@synthesize compareWithDate;

-(NSComparisonResult)compareWithDate:(DateOrder *)date{
    
    NSComparisonResult result=[self.date1 compare:date.date1];
    switch (result) {
        case NSOrderedAscending:
            result = NSOrderedDescending;
            break;
        case NSOrderedDescending:
            result = NSOrderedAscending;
            break;
        case NSOrderedSame:
            break;
    }
    return  result;
}


@end
