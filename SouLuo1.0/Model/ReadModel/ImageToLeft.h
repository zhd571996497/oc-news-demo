//
//  ImageToLeft.h
//  SouLuo1.0
//
//  Created by dllo on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseModel.h"

@interface ImageToLeft : BaseModel

//@property(nonatomic, copy)NSString * docid;//与id、replyid内容一样
@property(nonatomic, copy)NSString * rid;//id
@property(nonatomic, copy)NSString * img;//图片
@property(nonatomic, copy)NSString * pixel;//图片大小
@property(nonatomic, copy)NSString * ptime;//发布时间
//@property(nonatomic, copy)NSString * replyid;//与id、docid内容一样
@property(nonatomic, copy)NSString * source;//来源
@property(nonatomic, copy)NSString * title;//标题

-(id)initWithDic:(NSDictionary *)dic;

@end
