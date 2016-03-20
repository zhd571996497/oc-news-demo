//
//  ArrowButton.m
//  SouLuo1.0
//
//  Created by ls on 15/9/14.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "ArrowButton.h"

@implementation ArrowButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"Arrow.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"Arrow.png"] forState:UIControlStateHighlighted];
        self.backgroundColor = MYCOLOR_GRB(238., 238., 238, 1.);
        [self addTarget:self action:@selector(ArrowClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)ArrowClick
{
    if (self.arrowBtnClick) {
        self.arrowBtnClick();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
