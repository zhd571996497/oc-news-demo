//
//  SetView.h
//  SouLuo1.0
//
//  Created by dllo on 15/9/17.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseView.h"

@interface SetView : BaseView

//清除缓存
@property(nonatomic,strong)UIButton * clearImgBtn;
@property(nonatomic,strong)UIButton * clearTextBtn;
//夜间模式
@property(nonatomic,strong)UIButton * nightImgBtn;
@property(nonatomic,strong)UIButton * nightTextBtn;
//搜索
@property(nonatomic,strong)UIButton * searchImgBtn;
@property(nonatomic,strong)UIButton * searchTextBtn;
//关于我们
@property(nonatomic,strong)UIButton * aboutImgBtn;
@property(nonatomic,strong)UIButton * aboutTextBtn;

@end
