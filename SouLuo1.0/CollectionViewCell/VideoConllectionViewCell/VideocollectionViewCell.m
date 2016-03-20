//
//  VideocollectionViewCell.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "VideocollectionViewCell.h"
#import "VideoModel.h"
#import "UIImageView+WebCache.h"

@implementation VideocollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(RATIO_WIDTH*10, RATIO_HEIGHT*10,RATIO_WIDTH*345, RATIO_HEIGHT*30)];
//        [_titleLabel setBackgroundColor:[UIColor redColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:17]];
        [self.contentView addSubview:_titleLabel];
        
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(RATIO_WIDTH*10, RATIO_HEIGHT*40, RATIO_WIDTH*345, RATIO_HEIGHT*30)];
//        [_descriptionLabel setBackgroundColor:[UIColor yellowColor]];
        [_descriptionLabel setFont:[UIFont systemFontOfSize:15]];
        [_descriptionLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_descriptionLabel];
        
        _coverImg = [[UIImageView alloc]initWithFrame:CGRectMake(RATIO_WIDTH*10, RATIO_HEIGHT*80, RATIO_WIDTH*335,RATIO_HEIGHT*200)];
//        [_coverImg setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:_coverImg];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(RATIO_WIDTH*135,RATIO_HEIGHT*80, RATIO_WIDTH*50, RATIO_HEIGHT*50);
        [button setBackgroundColor:[UIColor blackColor]];
        [button setAlpha:0.8];
        button.layer.cornerRadius = RATIO_WIDTH*48/2;
        [self.coverImg addSubview:button];
        
        UIImageView *imgeView = [[UIImageView alloc]initWithFrame:CGRectMake(RATIO_WIDTH*16, RATIO_HEIGHT*15, RATIO_WIDTH*20, RATIO_HEIGHT*20)];
//        [imgeView setBackgroundColor:[UIColor whiteColor]];
        [imgeView setUserInteractionEnabled:YES];
        [imgeView setImage:[UIImage imageNamed:@"播放1"]];
        [button addSubview:imgeView];
        
    }
    return self;
}

-(void)getWithModel:(VideoModel *)model
{
    self.titleLabel.text = model.title;
    self.descriptionLabel.text = model.descriptionPro;
    [self.coverImg sd_setImageWithURL:[NSURL URLWithString:model.cover]placeholderImage:[UIImage imageNamed:@"占335-200"]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
