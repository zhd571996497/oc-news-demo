//
//  CellFactory.m
//  SouLuo1.0
//
//  Created by ls on 15/9/18.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "CellFactory.h"
#import "BaseTableViewCell.h"
#import "BaseModel.h"
@implementation CellFactory

+(BaseTableViewCell *)cellForModel:(BaseModel *)baseModel{
    
    // 类名拼接, 将Model的类名拼接成对应的cell 的cell的类名
    NSString *className = [@"CellFor" stringByAppendingString:NSStringFromClass([baseModel class])];
    
    //将cell 类名 转化成 类对象(cell的类)
    Class class = NSClassFromString(className);
    
    //创建对应的cell对象用父类的指针指向cell
    BaseTableViewCell *cell = [[class alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BaseModel class])];//用类名做标识符
    return cell;

}

@end
