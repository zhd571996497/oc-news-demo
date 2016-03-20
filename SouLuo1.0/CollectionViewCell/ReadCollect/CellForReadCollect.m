//
//  CellForReadCollect.m
//  SouLuo1.0
//
//  Created by dllo on 15/9/12.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "CellForReadCollect.h"
#import "UIImageView+WebCache.h"

@implementation CellForReadCollect

-(instancetype)initWithFrame:(CGRect)frame
{
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height / 6)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_titleLabel];
        
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _titleLabel.frame.size.height, width, height - _titleLabel.frame.size.height)];
        [self.contentView addSubview:_imgView];
    }
    return self;
}

-(void)getInfoForTitle:(NSString *)title Img:(NSString *)imgName
{
    [_titleLabel setText:title];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:[UIImage imageNamed:@"占112-92.png"]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
