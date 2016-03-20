//
//  DetailViewController.h
//  SouLuo1.0
//
//  Created by ls on 15/9/9.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseViewController.h"
@class BaseModel;
//新闻详情
@interface DetailViewController : BaseViewController

@property(nonatomic, strong)BaseModel * model;
//数据库准备数据
@property(nonatomic, copy)NSString * docid;//当前新闻id
@property(nonatomic, copy)NSString * newsTitle;//当前新闻标题
@property(nonatomic, copy)NSString * imageSrc;//当前新闻图片
@property(nonatomic,retain)UIButton *collectBtn;

@end
