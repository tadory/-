//
//  Item.m
//  賞味期限
//
//  Created by 田所　龍 on 2015/02/19.
//  Copyright (c) 2015年 田所　龍. All rights reserved.
//

#import "Item.h"

@implementation Item

@synthesize name;
@synthesize count;
@synthesize basyo;
@synthesize limitDate;


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:name forKey:@"NAME"];
    [aCoder encodeInteger:count forKey:@"COUNT"];
    [aCoder encodeObject:basyo forKey:@"BASYO"];
    [aCoder encodeObject:limitDate forKey:@"LIMITTIME"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    name = [aDecoder decodeObjectForKey:@"NAME"];
    count = [aDecoder decodeIntegerForKey:@"COUNT"];
    basyo = [aDecoder decodeObjectForKey:@"BASYO"];
    limitDate = [aDecoder decodeObjectForKey:@"LIMITTIME"];
    
    return self;
}


@end
