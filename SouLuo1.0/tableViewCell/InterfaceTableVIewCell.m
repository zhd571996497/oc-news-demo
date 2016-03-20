//
//  InterfaceTableVIewCell.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/16.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "InterfaceTableVIewCell.h"
#import "AudiotListModel.h"

@implementation InterfaceTableVIewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(RATIO_WIDTH*10, RATIO_HEIGHT*10, RATIO_WIDTH*300, RATIO_HEIGHT*30)];
//        [_titleLabel setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

-(void)getInfo:(AudiotListModel *)model
{
    self.titleLabel.text = model.title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
