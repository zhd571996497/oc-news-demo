//
//  Location.h
//  SouLuo1.0
//
//  Created by ls on 15/9/13.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
//定位
@protocol LocationDelegate <NSObject>

-(void)locationCityName:(NSString *)cityName;
@end

@interface Location : NSObject

@property(nonatomic , assign)id<LocationDelegate>delegate;

+(Location *)defaultLacation;

-(void)selectLoaction;


@end
