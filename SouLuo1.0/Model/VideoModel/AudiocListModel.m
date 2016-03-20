//
//  RadiocListModel.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/14.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "AudiocListModel.h"

@implementation AudiocListModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.tlist = [[NSMutableArray alloc]init];
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.tlist = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
