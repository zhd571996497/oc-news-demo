//
//  BaseTableViewCell.h
//  SouLuo1.0
//
//  Created by ls on 15/9/9.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseModel;

@interface BaseTableViewCell : UITableViewCell

@property(nonatomic, strong)BaseModel * baseModel;

@end
