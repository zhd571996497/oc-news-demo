//
//  DeleteBar.h
//  SouLuo1.0
//
//  Created by ls on 15/9/14.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseView.h"
//排序栏
@interface DeleteBar : BaseView
//拖拽可以排序Label
@property (nonatomic , strong)UILabel *hitText;
//排序Button
@property (nonatomic , strong)UIButton *sortBtn;
//按钮改变标题 和点击方法
-(void)sortBtnClick:(UIButton *)sender;
@end
