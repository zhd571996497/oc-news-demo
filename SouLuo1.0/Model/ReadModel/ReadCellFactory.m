//
//  ReadCellFactory.m
//  SouLuo1.0
//
//  Created by dllo on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "ReadCellFactory.h"
#import "BaseModel.h"
#import "BaseTableViewCell.h"

@implementation ReadCellFactory

+(BaseTableViewCell *)cellForBaseModel:(BaseModel *)model
{
    NSString * className = [@"CellFor" stringByAppendingString:NSStringFromClass([model class])];
    
    Class class = NSClassFromString(className);
    BaseTableViewCell * cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([model class])];
    return cell;
}

+(CGFloat)heightForBaseModel:(BaseModel *)model
{
    NSString * className = [@"CellFor" stringByAppendingString:NSStringFromClass([model class])];
    if ([className isEqualToString:@"CellForImageToLeft"]) {
        return 130 * RATIO_HEIGHT;
    } else if ([className isEqualToString:@"CellForImageToFull"]) {
        return 240 * RATIO_HEIGHT;
    }
    return 0;
}

@end
