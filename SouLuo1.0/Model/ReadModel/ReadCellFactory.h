//
//  ReadCellFactory.h
//  SouLuo1.0
//
//  Created by dllo on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BaseModel;
@class BaseTableViewCell;

@interface ReadCellFactory : NSObject

//返回cell的类型
+(BaseTableViewCell *)cellForBaseModel:(BaseModel *)model;

//返回不同cell的行高
+(CGFloat)heightForBaseModel:(BaseModel *)model;

@end
