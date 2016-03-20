//
//  RadiotListModel.h
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/14.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseModel.h"

@interface AudiotListModel : BaseModel

@property(nonatomic,strong)NSString *tname;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *imgsrc;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *docid;
@property(nonatomic,strong)NSString *cid;
@property(nonatomic,strong)NSString *tid;

@property(nonatomic,strong)NSString *url_mp4;

-(id)initWithDic:(NSDictionary *)dic;

@end
