//
//  PhotosetModel.m
//  SouLuo1.0
//
//  Created by ls on 15/9/18.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "PhotosetModel.h"

@implementation PhotosetModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    
     self.imgextra = [[NSMutableArray alloc]init];
    self = [super initWithDic:dic];
    if (self) {
        
    }
    return self;
}



@end
