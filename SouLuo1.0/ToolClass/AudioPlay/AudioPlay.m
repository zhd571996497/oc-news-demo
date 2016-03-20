//
//  AudioPlay.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/16.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "AudioPlay.h"

@implementation AudioPlay

+(instancetype)sharHandleController
{
    static AudioPlay *play = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        play = [[AudioPlay alloc]init];
    });
    return play;
}

@end
