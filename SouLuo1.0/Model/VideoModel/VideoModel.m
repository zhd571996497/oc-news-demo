//
//  VideoModel.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/10.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
