//
//  LsDate.m
//  NSDate-8.8
//
//  Created by ls on 15/8/16.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import "LsDate.h"

@implementation LsDate


+(NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/BeiJing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


+(NSString *)getDayTime:(int)dayDelay
{
    
    
    NSDate *dateNow;
    
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    
    long day=[comps day];//获取日期对应的长整形字符串
    
    long year=[comps year];//获取年对应的长整形字符串
    
    long month=[comps month];//获取月对应的长整形字符串
    
    long hour=[comps hour];//获取小时对应的长整形字符串
    
    long minute=[comps minute];//获取月对应的长整形字符串
    
    long second=[comps second];//获取秒对应的长整形字符串
    
    NSString *time =[NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld:%ld",year,month,day,hour,minute,second];//把日期长整形转成对应的汉字字符串
    
    
    return time;
    
}

+(NSString *)getDayYear:(int)dayDelay{
    
 
    NSDate *dateNow;
    
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
     long year=[comps year];//获取年对应的长整形字符串
    
      NSString * DateYear =[NSString stringWithFormat:@"%ld",year];//把日期长整形转成对应的汉字字符串
    
     return DateYear;
    
}


//获取月
+(NSString *)getDayMonth:(int)dayDelay
{
    
 
    
    NSDate *dateNow;
    
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    

    
     long month=[comps month];//获取月对应的长整形字符串
    
    NSString * dateMonth =[NSString stringWithFormat:@"%ld",month];//把日期长整形转成对应的汉字字符串
    
        return dateMonth;
    
}

//获取日
+(NSString *)getDayDay:(int)dayDelay
{
    
    NSDate *dateNow;
    
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    
    long day=[comps day];//获取日期对应的长整形字符串
    
    
    NSString *dateDay =[NSString stringWithFormat:@"%ld",day];//把日期长整形转成对应的汉字字符串
 
    
    return dateDay;
    
}

//获取时
+(NSString *)getDayHour:(int)dayDelay
{
    
    
    NSDate *dateNow;
    
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
  
    
    long hour=[comps hour];//获取小时对应的长整形字符串
    NSString *dateHour =[NSString stringWithFormat:@"%ld",hour];//把日期长整形转成对应的汉字字符串
    
    return dateHour;
    
}

//获取分
+(NSString *)getDayMinute:(int)dayDelay
{
    
    
    NSDate *dateNow;
    
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];

    long minute=[comps minute];//获取月对应的长整形字符串
    
    
    NSString *dateMinute =[NSString stringWithFormat:@"%ld",minute];//把日期长整形转成对应的汉字字符串
    

    return dateMinute;
    
}

//获取秒
+(NSString *)getDaySecond:(int)dayDelay
{
    
    NSDate *dateNow;
    
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
  
    
    long second=[comps second];//获取秒对应的长整形字符串
    
    NSString *dateSecond =[NSString stringWithFormat:@"%ld",second];//把日期长整形转成对应的汉字字符串
 
    
    return dateSecond;
    
}

//获取星期
+(NSString *)getDayWeek:(int)dayDelay
{
    
    NSString *weekDay;
    NSDate *dateNow;
    
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    long weekNumber = [comps weekday]; //获取星期对应的长整形字符串
    
    
    switch (weekNumber) {
            
        case 1:
            
            weekDay=@"星期日";
            
            break;
            
        case 2:
            
            weekDay=@"星期一";
            
            break;
            
        case 3:
            
            weekDay=@"星期二";
            
            break;
            
        case 4:
            
            weekDay=@"星期三";
            
            break;
            
        case 5:
            
            weekDay=@"星期四";
            
            break;
            
        case 6:
            
            weekDay=@"星期五";
            
            break;
            
        case 7:
            
            weekDay=@"星期六";
            
            break;
            
            
            
        default:
            
            break;
            
    }
    
  
    return weekDay;
    
}

//年月日
+(NSString *)getDayYTD:(int)dayDelay
{
    
    
    NSDate *dateNow;
    
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    
    long day=[comps day];//获取日期对应的长整形字符串
    
    long year=[comps year];//获取年对应的长整形字符串
    
    long month=[comps month];//获取月对应的长整形字符串
    
      NSString * YTD =[NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];//把日期长整形转成对应的汉字字符串
    
    return YTD;
    
}

//月日
+(NSString *)getDayMD:(int)dayDelay;
{
    
    
    NSDate *dateNow;
    
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    
    long day=[comps day];//获取日期对应的长整形字符串
    
    
    long month=[comps month];//获取月对应的长整形字符串
    
    NSString * MD =[NSString stringWithFormat:@"%ld-%ld",month,day];//把日期长整形转成对应的汉字字符串
    
    return MD;
    
}

//时分秒
+(NSString *)getDayHMS:(int)dayDelay;
{
    
    
    NSDate *dateNow;
    
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    long hour=[comps hour];//获取小时对应的长整形字符串
    
    long minute=[comps minute];//获取月对应的长整形字符串
    
    long second=[comps second];//获取秒对应的长整形字符串
    
    NSString * time =[NSString stringWithFormat:@"%ld:%ld:%ld",hour,minute,second];//把日期长整形转成对应的汉字字符串
    
        return time;
    
}

//时分
+(NSString *)getDayHM:(int)dayDelay;
{
    
    
    NSDate *dateNow;
    
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    long hour=[comps hour];//获取小时对应的长整形字符串
    
    long minute=[comps minute];//获取月对应的长整形字符串
    
    
    NSString * time =[NSString stringWithFormat:@"%ld:%ld",hour,minute];//把日期长整形转成对应的汉字字符串
    
    return time;
    
}


#pragma mark- mark -根据时间间隔获取时间


#warning 分割线


#pragma mark- 根据date返回时间
+(NSString *)getDateTime:(NSDate *)dateNow
{
    
    
    
   
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    
    long day=[comps day];//获取日期对应的长整形字符串
    
    long year=[comps year];//获取年对应的长整形字符串
    
    long month=[comps month];//获取月对应的长整形字符串
    
    long hour=[comps hour];//获取小时对应的长整形字符串
    
    long minute=[comps minute];//获取月对应的长整形字符串
    
    long second=[comps second];//获取秒对应的长整形字符串
    
    NSString *time =[NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld:%ld",year,month,day,hour,minute,second];//把日期长整形转成对应的汉字字符串
    
    
    return time;
    
}

+(NSString *)getDateYear:(NSDate *)dateNow{
    
       NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    long year=[comps year];//获取年对应的长整形字符串
    
    NSString * DateYear =[NSString stringWithFormat:@"%ld",year];//把日期长整形转成对应的汉字字符串
    
    return DateYear;
    
}


//获取月
+(NSString *)getDateMonth:(NSDate *)dateNow
{
    
    
    
      NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    
    
    long month=[comps month];//获取月对应的长整形字符串
    
    NSString * dateMonth =[NSString stringWithFormat:@"%ld",month];//把日期长整形转成对应的汉字字符串
    
    return dateMonth;
    
}

//获取日
+(NSString *)getDateDay:(NSDate *)dateNow
{
  
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    
    long day=[comps day];//获取日期对应的长整形字符串
    
    
    NSString *dateDay =[NSString stringWithFormat:@"%ld",day];//把日期长整形转成对应的汉字字符串
    
    
    return dateDay;
    
}

//获取时
+(NSString *)getDateHour:(NSDate *)dateNow
{
    
  
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    
    
    long hour=[comps hour];//获取小时对应的长整形字符串
    NSString *dateHour =[NSString stringWithFormat:@"%ld",hour];//把日期长整形转成对应的汉字字符串
    
    return dateHour;
    
}

//获取分
+(NSString *)getDateMinute:(NSDate *)dateNow
{
    
    
   
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    long minute=[comps minute];//获取月对应的长整形字符串
    
    
    NSString *dateMinute =[NSString stringWithFormat:@"%ld",minute];//把日期长整形转成对应的汉字字符串
    
    
    return dateMinute;
    
}

//获取秒
+(NSString *)getDateSecond:(NSDate *)dateNow
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    
    
    long second=[comps second];//获取秒对应的长整形字符串
    
    NSString *dateSecond =[NSString stringWithFormat:@"%ld",second];//把日期长整形转成对应的汉字字符串
    
    
    return dateSecond;
    
}

//获取星期
+(NSString *)getDateWeek:(NSDate *)dateNow
{
    
    NSString *weekDay;

      NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    long weekNumber = [comps weekday]; //获取星期对应的长整形字符串
    
    
    switch (weekNumber) {
            
        case 1:
            
            weekDay=@"星期日";
            
            break;
            
        case 2:
            
            weekDay=@"星期一";
            
            break;
            
        case 3:
            
            weekDay=@"星期二";
            
            break;
            
        case 4:
            
            weekDay=@"星期三";
            
            break;
            
        case 5:
            
            weekDay=@"星期四";
            
            break;
            
        case 6:
            
            weekDay=@"星期五";
            
            break;
            
        case 7:
            
            weekDay=@"星期六";
            
            break;
            
            
            
        default:
            
            break;
            
    }
    
    
    return weekDay;
    
}

//年月日
+(NSString *)getDateYTD:(NSDate *)dateNow
{
    
     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    
    long day=[comps day];//获取日期对应的长整形字符串
    
    long year=[comps year];//获取年对应的长整形字符串
    
    long month=[comps month];//获取月对应的长整形字符串
    
    NSString * YTD =[NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];//把日期长整形转成对应的汉字字符串
    
    return YTD;
    
}

//月日
+(NSString *)getDateMD:(NSDate *)dateNow
{
    
   
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    
    long day=[comps day];//获取日期对应的长整形字符串
    
    
    long month=[comps month];//获取月对应的长整形字符串
    
    NSString * MD =[NSString stringWithFormat:@"%ld-%ld",month,day];//把日期长整形转成对应的汉字字符串
    
    return MD;
    
}

//时分秒
+(NSString *)getDateHMS:(NSDate *)dateNow
{
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    long hour=[comps hour];//获取小时对应的长整形字符串
    
    long minute=[comps minute];//获取月对应的长整形字符串
    
    long second=[comps second];//获取秒对应的长整形字符串
    
    NSString * time =[NSString stringWithFormat:@"%ld:%ld:%ld",hour,minute,second];//把日期长整形转成对应的汉字字符串
    
    return time;
    
}

//时分
+(NSString *)getDateHM:(NSDate *)dateNow
{
    
    

    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    long hour=[comps hour];//获取小时对应的长整形字符串
    
    long minute=[comps minute];//获取月对应的长整形字符串
    
    
    NSString * time =[NSString stringWithFormat:@"%ld:%ld",hour,minute];//把日期长整形转成对应的汉字字符串
    
    return time;
    
}
#pragma mark- mark-根据date返回时间

#pragma mark- 跟据时间戳返回时间

+(NSString *)getDate:(CGFloat)second
{
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:second];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * localString =[formatter stringFromDate:date];
    
    return localString;
    
}






@end
