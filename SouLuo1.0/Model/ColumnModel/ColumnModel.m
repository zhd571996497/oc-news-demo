//
//  ColumnModel.m
//  SouLuo1.0
//
//  Created by ls on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "ColumnModel.h"

@implementation ColumnModel

//反序列化
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.tname = [aDecoder decodeObjectForKey:@"tname"];
        self.headLine = [aDecoder decodeBoolForKey:@"headLine"];
        self.ename = [aDecoder decodeObjectForKey:@"ename"];
        self.tid = [aDecoder decodeObjectForKey:@"tid"];
        self.cid = [aDecoder decodeObjectForKey:@"cid"];
        self.tag = [aDecoder decodeObjectForKey:@"tag"];
        self.subnum = [aDecoder decodeObjectForKey:@"subnum"];
        self.recommendOrder = [aDecoder decodeObjectForKey:@"recommendOrder"];
        self.topicid = [aDecoder decodeObjectForKey:@"topicid"];
        self.isLocation = [aDecoder decodeBoolForKey:@"isLocation"];
        
    }
    return self;
}

//序列化
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.tname forKey:@"tname"];
    [aCoder encodeBool:self.headLine forKey:@"headLine"];
    [aCoder encodeObject:self.ename forKey:@"ename"];
    [aCoder encodeObject:self.tid forKey:@"tid"];
    [aCoder encodeObject:self.cid forKey:@"cid"];
    [aCoder encodeObject:self.tag forKey:@"tag"];
    [aCoder encodeObject:self.subnum forKey:@"subnum"];
    [aCoder encodeObject:self.recommendOrder forKey:@"recommendOrder"];
    [aCoder encodeObject:self.topicid forKey:@"topicid"];
    [aCoder encodeBool:self.isLocation forKey:@"isLocation"];
}

@end
