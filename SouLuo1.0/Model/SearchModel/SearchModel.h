//
//  SearchModel.h
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/22.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseModel.h"

@interface SearchModel : BaseModel


@property(nonatomic,copy)NSString *docid;
@property(nonatomic,copy)NSString *nid;//id
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *ptime;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *skipID;
@property(nonatomic,copy)NSString *dkeys;

@property(nonatomic,copy)NSString *skipType;
@property(nonatomic,copy)NSString * nextCursorMark;

-(id)initWithDictionary:(NSDictionary *)dic;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
