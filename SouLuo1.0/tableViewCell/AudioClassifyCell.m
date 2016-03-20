//
//  AudioClassifyCell.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/16.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "AudioClassifyCell.h"
#import "AudiotListModel.h"
#import "UIImageView+WebCache.h"

@implementation AudioClassifyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgsrc = [[UIImageView alloc]initWithFrame:CGRectMake(RATIO_WIDTH*10, RATIO_HEIGHT*10, RATIO_WIDTH*80, RATIO_WIDTH*80)];
//        [_imgsrc setBackgroundColor:[UIColor yellowColor]];
        _imgsrc.layer.cornerRadius = RATIO_WIDTH*80/2;
        _imgsrc.layer.masksToBounds = YES;
        [self.contentView addSubview:_imgsrc];
        
        _tnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(RATIO_WIDTH*100,RATIO_HEIGHT* 10, RATIO_WIDTH*200, RATIO_HEIGHT*30)];
//        [_tnameLabel setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:_tnameLabel];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(RATIO_WIDTH*100, RATIO_HEIGHT*40, RATIO_WIDTH*200, RATIO_HEIGHT*60)];
//        [_titleLabel setBackgroundColor:[UIColor yellowColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_titleLabel setTextColor:[UIColor lightGrayColor]];
        [_titleLabel setNumberOfLines:2];
        [self.contentView addSubview:_titleLabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(RATIO_WIDTH*26,RATIO_HEIGHT*26,RATIO_WIDTH*30,RATIO_WIDTH*30);
        [button setBackgroundColor:[UIColor blackColor]];
        
        [button setAlpha:0.7];
        button.layer.cornerRadius = RATIO_WIDTH*30/2;
        [self.imgsrc addSubview:button];
        
        UIImageView *imgeView = [[UIImageView alloc]initWithFrame:CGRectMake(RATIO_WIDTH*7, RATIO_HEIGHT*5, RATIO_WIDTH*20, RATIO_HEIGHT*20)];
        //        [imgeView setBackgroundColor:[UIColor whiteColor]];
        [imgeView setUserInteractionEnabled:YES];
        [imgeView setImage:[UIImage imageNamed:@"播放1.png"]];
        [button addSubview:imgeView];

    }
    return self;
}

-(void)getInfo:(AudiotListModel *)model
{
    [self.imgsrc sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]placeholderImage:[UIImage imageNamed:@"占112-92"]];
    self.tnameLabel.text = model.tname;
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
