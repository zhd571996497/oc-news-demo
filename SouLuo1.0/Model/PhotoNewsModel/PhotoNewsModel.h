//
//  PhotoNewsModel.h
//  SouLuo1.0
//
//  Created by ls on 15/9/23.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseModel.h"
//图片新闻详情
@interface PhotoNewsModel : BaseModel
//总标题
@property (nonatomic , copy)NSString *setname;
//图片网址
@property (nonatomic , copy)NSString *imgurl;
//图片标题
@property (nonatomic , copy)NSString *note;

@end
