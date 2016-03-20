//
//  RadiotListModel.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/14.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "AudiotListModel.h"

@implementation AudiotListModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
