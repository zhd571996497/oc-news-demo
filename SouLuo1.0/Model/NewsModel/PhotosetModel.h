//
//  PhotosetModel.h
//  SouLuo1.0
//
//  Created by ls on 15/9/18.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseModel.h"

@interface PhotosetModel : BaseModel

//下页接口id //将其拆开
@property (nonatomic , strong)NSString *skipID;
//标题
@property (nonatomic , strong)NSString *title;
//简介
@property (nonatomic , strong)NSString *digest;
//发布时间
@property (nonatomic , strong)NSString *ptime;
//来源
@property (nonatomic , strong)NSString *source;
//照片网址
@property (nonatomic , strong)NSString *imgsrc;
//照片网址数组
@property (nonatomic , strong)NSMutableArray *imgextra;

@end
