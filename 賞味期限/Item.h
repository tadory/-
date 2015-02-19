//
//  Item.h
//  賞味期限
//
//  Created by 田所　龍 on 2015/02/19.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *basyo;
@property (nonatomic, strong) NSDate *limitDate;

@end
