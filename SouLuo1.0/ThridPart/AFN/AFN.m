//
//  AFN.m
//  休闲影糖2
//
//  Created by dllo on 15/4/13.
//  Copyright (c) 2015年 🐭🐂🐯🐰🐲🐍🐴🐑🐵🐔🐶🐷. All rights reserved.
//

#import "AFN.h"

@implementation AFN


+ (void)urlString:(NSString *)urlString getAFNdata:(GetAFN)getAFNdata
{
    
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    
    NSString *url_string = [NSString stringWithString:urlString];
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/x-javascript",nil];
    [manager.requestSerializer setValue:@"_ntes_nnid=afd18223c2147c8605c3305df7714099,1435984456353; _ntes_nuid=afd18223c2147c8605c3305df7714099; vjlast=1437024511.1441791022.23; vjuids=3d4c1f26.14e9555e43e.0.6e62d743" forHTTPHeaderField:@"Cookie"];

#pragma 本地缓存
    
    //本地缓存设置，沙盒路径设置
    NSArray * path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString * pathString = path.lastObject;
    
    
    NSString *pathLast =[NSString stringWithFormat:@"/Caches/com.hackemist.SDWebImageCache.default/%lu.text", (unsigned long)[url_string hash]];
    
    //创建字符串文件存储路径
    NSString *PathName =[pathString stringByAppendingString:pathLast];
    //第一次进入判断有没有文件夹，如果没有就创建一个
    NSString * textPath = [pathString stringByAppendingFormat:@"/Caches/com.hackemist.SDWebImageCache.default"];
    if (![[NSFileManager defaultManager]fileExistsAtPath:textPath]) {
        
        [[NSFileManager defaultManager]createDirectoryAtPath:textPath withIntermediateDirectories:YES attributes:nil error:nil];
    }


    
    [manager GET:url_string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [netWorkManager stopMonitoring];
        
        NSData * data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        
        [data writeToFile:PathName atomically:YES];
        

        getAFNdata(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString * cachePath = PathName;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            
            
            //从本地读缓存文件
            NSData * data =[NSData dataWithContentsOfFile:cachePath];
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            getAFNdata(responseObject);
        }
        //NSLog(@"失败==== %@",error);
        
    }];
}



@end
