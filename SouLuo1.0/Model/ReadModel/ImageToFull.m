//
//  ImageToFull.m
//  SouLuo1.0
//
//  Created by dllo on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "ImageToFull.h"

@implementation ImageToFull

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
