//
//  RadiocListModel.h
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/14.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseModel.h"

@interface AudiocListModel : BaseModel

@property(nonatomic,strong)NSMutableArray *tlist;
@property(nonatomic,strong)NSString *cname;
@property(nonatomic,strong)NSString *cid;

-(id)initWithDic:(NSDictionary *)dic;

@end
