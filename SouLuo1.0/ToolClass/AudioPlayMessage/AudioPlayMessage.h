//
//  AudioPlayMessage.h
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/16.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioPlayMessage : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)NSArray *urlArray;
@property(nonatomic,strong)NSString *url;

+(AudioPlayMessage *)message;

@end
