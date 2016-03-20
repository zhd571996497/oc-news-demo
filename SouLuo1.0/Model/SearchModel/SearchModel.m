//
//  SearchModel.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/22.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel


//@synthesize docid = _docid;
//
//-(void)setDocid:(NSString *)docid{
//    
//    _docid = docid;
//}

-(id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
