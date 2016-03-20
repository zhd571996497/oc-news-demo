//
//  Height.m
//  Practice7.9News
//
//  Created by ls on 15/7/9.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import "Height.h"

@implementation Height

+(CGFloat)heightForText:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize
{
    
    CGRect  rect = [text boundingRectWithSize:CGSizeMake(width, 3000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.height;
    
}

@end
