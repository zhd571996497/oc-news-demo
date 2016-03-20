//
//  ColumnArraySingModel.m
//  SouLuo1.0
//
//  Created by ls on 15/9/17.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "ColumnArraySingModel.h"

@implementation ColumnArraySingModel

-(instancetype)init{
    self = [super init];
    if (self) {
        self.columnArray = [[NSMutableArray alloc]init];
        self.columnSortArry = [[NSMutableArray alloc]init];
    }
    return self;
}

+(ColumnArraySingModel *)defaultColumnArraySingleModel{
    
    static ColumnArraySingModel *singModel =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        singModel = [[ColumnArraySingModel alloc]init];
        
    });
    
    
    return singModel;
}

@end
