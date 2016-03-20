//
//  AFNetWoringYu.m
//  demoForNetWorking
//
//  Created by 张诗雨 on 14/12/27.
//  Copyright (c) 2014年 张诗雨. All rights reserved.
//

#import "AFNetWoringYu.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
@implementation AFNetWoringYu

- (void)netWorkWithURL:(NSString *)urlStr body:(NSString*)body resultBlock:(void (^)(id))block
{
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    request.HTTPMethod = @"POST";
    // 需要提交的表单
    NSString *bodyStr = body;
    // 将bodyStr转为NSData类型
    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    // 设置请求body(NSData类型)
    request.HTTPBody = bodyData;
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding]; //请求的数据
        id reuselt = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        block(reuselt);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init] ;
    [queue addOperation:op];
    
    
}
+ (void)netWorkWithURL:(NSString *)urlStr body:(NSString*)body resultBlock:(void(^)(id))block
{
    AFNetWoringYu *yu = [[AFNetWoringYu alloc] init];
    [yu netWorkWithURL:urlStr body:body resultBlock:block];
//    [yu release];
    
}

@end
