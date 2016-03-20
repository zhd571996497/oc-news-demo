//
//  LsDate.h
//  NSDate-8.8
//
//  Created by ls on 15/8/16.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LsDate : NSObject


+(NSString*)weekdayStringFromDate:(NSDate*)inputDate;

#pragma mark- 根据时间间隔获取时间
//获取具体时间
+(NSString *)getDayTime:(int)dayDelay;
//获取年
+(NSString *)getDayYear:(int)dayDelay;
//获取月
+(NSString *)getDayMonth:(int)dayDelay;
//获取日
+(NSString *)getDayDay:(int)dayDelay;
//获取时
+(NSString *)getDayHour:(int)dayDelay;
//获取分
+(NSString *)getDayMinute:(int)dayDelay;
//获取秒
+(NSString *)getDaySecond:(int)dayDelay;
//获取星期
+(NSString *)getDayWeek:(int)dayDelay;
//年月日
+(NSString *)getDayYTD:(int)dayDelay;
//月日
+(NSString *)getDayMD:(int)dayDelay;
//时分秒
+(NSString *)getDayHMS:(int)dayDelay;
//时分
+(NSString *)getDayHM:(int)dayDelay;

#pragma mark- mark -根据时间间隔获取时间


#warning 分割线


#pragma mark- 根据date返回时间
//获取年
+(NSString *)getDateYear:(NSDate *)dateNow;
//获取月
+(NSString *)getDateMonth:(NSDate *)dateNow;
//获取日
+(NSString *)getDateDay:(NSDate *)dateNow;
//获取时
+(NSString *)getDateHour:(NSDate *)dateNow;
//获取分
+(NSString *)getDateMinute:(NSDate *)dateNow;
//获取秒
+(NSString *)getDateSecond:(NSDate *)dateNow;
//获取星期
+(NSString *)getDateWeek:(NSDate *)dateNow;
//年月日
+(NSString *)getDateYTD:(NSDate *)dateNow;
//月日
+(NSString *)getDateMD:(NSDate *)dateNow;
//时分秒
+(NSString *)getDateHMS:(NSDate *)dateNow;
//时分
+(NSString *)getDateHM:(NSDate *)dateNow;

#pragma mark- mark-根据date返回时间

#pragma mark- 跟据时间戳返回时间

+(NSString *)getDate:(CGFloat)second;

@end
