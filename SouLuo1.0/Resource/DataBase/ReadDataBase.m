//
//  ReadDataBase.m
//  SouLuo1.0
//
//  Created by dllo on 15/9/15.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "ReadDataBase.h"
#import "ReadDetailModel.h"
static ReadDataBase * dataBaseHandle = nil;
@implementation ReadDataBase

+(ReadDataBase *)shareDataBaseHandle
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBaseHandle = [[ReadDataBase alloc]init];
    });
    return dataBaseHandle;
}

static sqlite3 *db;
-(void)openDB
{
    NSString * filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *sqlitePath = [filePath stringByAppendingString:@"/SouLuo.sqlite"];
//    NSLog(@"文件路径 = %@",sqlitePath);
    if (db != nil) {
//        NSLog(@"数据库已经开启");
        return;
    }
    
    //打开数据库方法
    int result = sqlite3_open([sqlitePath UTF8String], &db);
    
    if (result == SQLITE_OK) {
//        NSLog(@"数据库开启成功");
    } else {
//        NSLog(@"数据库开启失败");
    }
}

-(void)createTable
{
    //创建建表SQL语句
    NSString *createSql = @"CREATE TABLE IF NOT EXISTS souluo_readDetail_collect(number INTEGER PRIMARY KEY AUTOINCREMENT,docid TEXT,title TEXT,source TEXT,ptime TEXT,src TEXT,body TEXT)";
    
    //执行sql语句
    int result = sqlite3_exec(db, [createSql UTF8String], NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
//        NSLog(@"创建表成功");
        
    } else {
        
//        NSLog(@"创建表失败");
    }
    
}

-(void)insertReadDetailSelectInfo:(NSString *)docid infoTitle:(NSString *)title infoImgSrc:(NSString *)src
{
    //创建插入信息的sql语句
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO souluo_readDetail_collect (docid,title,src)VALUES('%@','%@','%@')",docid,title,src];
    //执行sql语句
    int result = sqlite3_exec(db, [insertSql UTF8String], NULL, NULL, NULL);
    
    if (result != SQLITE_OK) {
//        NSLog(@"插入信息失败");
    }else{
//        NSLog(@"插入信息成功");
        
    }
}

-(NSMutableArray *)selectReadDetailSelectInfo
{
    //创建查询sql语句
    NSString * selectSql = @"SELECT * FROM souluo_readDetail_collect";
    //创建数据库指针对象
    sqlite3_stmt *stmt = nil;
    
    //将数据库对象、SQL语句、指针对象关联在一起
    //参数1：数据库对象
    //参数2：查询语句
    //参数3：查询语句字数限制（-1为不限制）
    //参数4：数据库指针对象
    //参数5：nil
    int result = sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &stmt, nil);
    
    //创建学生信息存放大数组
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    if (result != SQLITE_OK) {
//        NSLog(@"查询失败");
    }else {
//        NSLog(@"查询成功");
    }
    
    
    //循环遍历查询数据信息表格一行
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        //取出每一行数据
        int number = sqlite3_column_int(stmt, 0);
        const unsigned char *docid = sqlite3_column_text(stmt, 1);
        const unsigned char *title = sqlite3_column_text(stmt, 2);
        const unsigned char *src = sqlite3_column_text(stmt, 5);
        
        
        NSString *docidString = [NSString stringWithUTF8String:(const char *)docid];
        NSString *titleString = [NSString stringWithUTF8String:(const char *)title];
        NSString *srcString = [NSString stringWithUTF8String:(const char *)src];;
        
        ReadDetailModel *readDetailModel = [[ReadDetailModel alloc]init];
        readDetailModel.docid = docidString;
        readDetailModel.title = titleString;
        readDetailModel.src= srcString;
        readDetailModel.fuctionStatues = @"select";
        //查询结果存入数组
        [array addObject:readDetailModel];
        
    }
    sqlite3_finalize(stmt);
    return array;
    
}

-(void)deleteReadDetailSelectInfo:(NSString *)docid
{
    //创建删除阅读详情的sql语句
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM souluo_readDetail_collect WHERE docid = '%@'",docid ];
    
    //执行sql语句
    int result = sqlite3_exec(db, [deleteSql UTF8String], NULL, NULL, NULL);
    
    if (result != SQLITE_OK) {
//        NSLog(@"删除失败");
    }else{
//        NSLog(@"删除成功");
    }
    
}

-(int)selectReadDetailSelectInfoByRid:(NSString *)docid
{
    //创建查询sql语句
    NSString * selectSql = [NSString stringWithFormat:@"SELECT * FROM souluo_readDetail_collect WHERE docid = '%@'",docid];
//    NSLog(@"SQL---%@",selectSql);
    //创建数据库指针对象
    sqlite3_stmt *stmt = nil;
    
    int i = 0;
    
    //将数据库对象、SQL语句、指针对象关联在一起
    //参数1：数据库对象
    //参数2：查询语句
    //参数3：查询语句字数限制（-1为不限制）
    //参数4：数据库指针对象
    //参数5：nil
    int result = sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &stmt, nil);
    
    
    
    if (result != SQLITE_OK) {
//        NSLog(@"查询docid失败");
        
    }else {
//        NSLog(@"查询docid成功");
        
    }
    
    
    //    NSLog(@"------%d--------",sqlite3_step(stmt) == SQLITE_ROW);
    
    //    //循环遍历查询数据信息表格一行
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        i = 1;
        
        
    }
    sqlite3_finalize(stmt);
    return i;
    
    
}

-(void)closeDB
{
    if (db) {
        int result = sqlite3_close(db);
        db = nil;
        if (result != SQLITE_OK) {
//            NSLog(@"关闭数据库失败");
        }else{
//            NSLog(@"数据库关闭成功");
        }
    }
    
}


@end
