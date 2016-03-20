//
//  ReadDataBase.h
//  SouLuo1.0
//
//  Created by dllo on 15/9/15.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface ReadDataBase : NSObject

+(ReadDataBase *)shareDataBaseHandle;
-(void)openDB;//开启数据库
-(void)createTable;//创建表格
-(void)insertReadDetailSelectInfo:(NSString *)docid infoTitle:(NSString *)title infoImgSrc:(NSString *)src;//插入信息
-(void)deleteReadDetailSelectInfo:(NSString *)docid;//删除信息
-(NSMutableArray *)selectReadDetailSelectInfo;//查询信息
-(int)selectReadDetailSelectInfoByRid:(NSString *)docid;//通过id值查询信息
-(void)closeDB;//关闭数据库

@end
