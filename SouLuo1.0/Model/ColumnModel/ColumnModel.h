//
//  ColumnModel.h
//  SouLuo1.0
//
//  Created by ls on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseModel.h"
//首页栏目model
@interface ColumnModel : BaseModel<NSCoding>
//栏目名字
@property(nonatomic , strong)NSString *tname;
//是否是第一个栏目
@property(nonatomic , assign)BOOL headLine;
//请求数据用参数
@property(nonatomic , strong)NSString *ename;
//请求数据用参数
@property(nonatomic , strong)NSString *tid;
//?
@property(nonatomic , strong)NSString *cid;
//角标
@property(nonatomic , strong)NSString *tag;
//点击量
@property(nonatomic , strong)NSString *subnum;
//推荐
@property(nonatomic , strong)NSNumber *recommendOrder;
//
@property(nonatomic , strong)NSString *topicid;
//是否是地方新闻
@property(nonatomic , assign)BOOL isLocation;
@end
