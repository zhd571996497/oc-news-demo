//
//  HeadCycleModel.h
//  SouLuo1.0
//
//  Created by ls on 15/9/17.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseModel.h"

@interface HeadCycleModel : BaseModel

//标题
@property (nonatomic , strong)NSString *title;
//类型
@property (nonatomic , strong)NSString *tag;
//新闻地址
@property (nonatomic , strong)NSString *imgsrc;
//下页接口
@property (nonatomic , strong)NSString *url;
//子标题
@property (nonatomic , strong)NSString *subtitl;
//有可能需要的下页接口
@property (nonatomic , strong)NSString *skipID;

@end
