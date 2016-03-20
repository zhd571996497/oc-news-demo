//
//  DeleteBar.m
//  SouLuo1.0
//
//  Created by ls on 15/9/14.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "DeleteBar.h"

@interface DeleteBar()
@property (nonatomic , strong)UILabel *myChannel;
@end

@implementation DeleteBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeNewBar];//设置排序栏
        //初始隐藏
        self.hidden = YES;
    }
    return self;
}

-(void)makeNewBar{
    
    self.backgroundColor = MYCOLOR_GRB(238, 238, 238, 1);
    
    self.myChannel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 30)];
    _myChannel.font = [UIFont systemFontOfSize:14];
    _myChannel.textColor = [UIColor blackColor];
    _myChannel.text = @"我的频道";
    [self addSubview:_myChannel];
    
    if (!self.hitText) {
        self.hitText = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_myChannel.frame)+10, 10, 100, 11)];
        _hitText.font = [UIFont systemFontOfSize:11];
        _hitText.text = @"拖拽可以排序";
        _hitText.textColor = MYCOLOR_GRB(170, 170, 170, 1);
        _hitText.hidden = YES;
        [self addSubview:_hitText];
    }
    
    if (!self.sortBtn) {
        self.sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sortBtn setFrame:CGRectMake(SCREEN_WIDTH - 100, 5, 50, 20)];
        _sortBtn.layer.masksToBounds = YES;
        _sortBtn.layer.cornerRadius = 5;
        _sortBtn.layer.borderWidth = 0.5;
        _sortBtn.layer.borderColor = [[UIColor redColor] CGColor];
        [_sortBtn setTitle:@"排序" forState:UIControlStateNormal];
        [_sortBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _sortBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _sortBtn.layer.borderColor = [[UIColor redColor]CGColor];
        [_sortBtn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sortBtn];
    }
}
//排序按钮点击方法
-(void)sortBtnClick:(UIButton *)sender{
    
    if (sender.selected) {
        [sender setTitle:@"排序" forState:UIControlStateNormal];
        self.hitText.hidden = YES;
    }else{
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        self.hitText.hidden = NO;
    }
    sender.selected = !sender.selected;
    
    //消息中心
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sortBtnClick" object:sender userInfo:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
