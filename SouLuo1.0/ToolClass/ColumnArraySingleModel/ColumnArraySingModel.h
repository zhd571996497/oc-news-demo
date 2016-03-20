//
//  ColumnArraySingModel.h
//  SouLuo1.0
//
//  Created by ls on 15/9/17.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
//存储栏目按钮的数组
@interface ColumnArraySingModel : NSObject

+(ColumnArraySingModel *)defaultColumnArraySingleModel;

@property (nonatomic , strong)NSMutableArray *columnSortArry;

@property (nonatomic , strong)NSMutableArray *columnArray;

@end

