//
//  AudioPlayMessage.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/16.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "AudioPlayMessage.h"

static AudioPlayMessage *meg = nil;

@implementation AudioPlayMessage

+(AudioPlayMessage *)message
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        meg = [[AudioPlayMessage alloc]init];
    });
    return meg;
}

@end
