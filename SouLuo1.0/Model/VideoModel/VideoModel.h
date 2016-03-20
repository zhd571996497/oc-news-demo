//
//  VideoModel.h
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/10.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseModel.h"

@interface VideoModel : BaseModel

@property(nonatomic,strong)NSString *videosource;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)NSInteger playCount;
@property(nonatomic,strong)NSString *replyid;
@property(nonatomic,retain)NSString *descriptionPro;//description
@property(nonatomic,strong)NSString *mp4_url;
@property(nonatomic,assign)NSInteger length;
@property(nonatomic,assign)NSInteger playersize;
@property(nonatomic,strong)NSString *vid;
@property(nonatomic,retain)NSString *ptime;
@property(nonatomic,assign)NSInteger replyCount;
@property(nonatomic,strong)NSString *videoid;
@property(nonatomic,strong)NSString *tid;

-(id)initWithDic:(NSDictionary *)dic;

@end
