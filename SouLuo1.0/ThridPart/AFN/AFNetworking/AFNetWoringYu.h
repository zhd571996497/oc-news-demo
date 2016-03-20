//
//  AFNetWoringYu.h
//  demoForNetWorking
//
//  Created by 张诗雨 on 14/12/27.
//  Copyright (c) 2014年 张诗雨. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AFNetWoringYu : NSObject
///  网络请求数据
+ (void)netWorkWithURL:(NSString *)urlStr body:(NSString*)body resultBlock:(void(^)(id))block;
@end