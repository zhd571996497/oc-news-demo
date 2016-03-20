//
//  ReadDetailModel.h
//  SouLuo1.0
//
//  Created by dllo on 15/9/12.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>

@interface ReadDetailModel : BaseModel

@property(nonatomic, copy)NSString * title;//标题
@property(nonatomic, copy)NSString * source_url;//有的接口里面有，可以直接webView请求，没有就拼接HTML
@property(nonatomic, copy)NSString * source;//来源
@property(nonatomic, copy)NSString * ptime;//发布时间
@property(nonatomic, copy)NSString * body;//内容
@property(nonatomic, copy)NSMutableArray * img;//图片数组
@property(nonatomic, copy)NSString * docid;
/**
 *  数据库里面
 */
@property(nonatomic, copy)NSString * fuctionStatues;//当前状态
@property(nonatomic, copy)NSString * src;//取img数组里面第一个图片

@property(nonatomic, assign)CGFloat titleHeight;

@end
