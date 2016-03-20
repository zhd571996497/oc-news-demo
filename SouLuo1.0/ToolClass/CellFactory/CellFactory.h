//
//  CellFactory.h
//  SouLuo1.0
//
//  Created by ls on 15/9/18.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseTableViewCell;
@class BaseModel;
//cell工厂
@interface CellFactory : NSObject

+(BaseTableViewCell *)cellForModel:(BaseModel *)baseModel;

@end
