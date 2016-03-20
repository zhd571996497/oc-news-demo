//
//  ArrowButton.h
//  SouLuo1.0
//
//  Created by ls on 15/9/14.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
//下拉图标
typedef void (^ArrowBtnClick)();
@interface ArrowButton : UIButton
//点击下拉图标时调用
@property (nonatomic , copy)ArrowBtnClick arrowBtnClick;

@end
