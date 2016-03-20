//
//  CellForImageToLeft.m
//  SouLuo1.0
//
//  Created by dllo on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "CellForImageToLeft.h"
#import "ImageToLeft.h"
#import "UIImageView+WebCache.h"

@interface CellForImageToLeft ()

@property(nonatomic, strong)UIView * bgView;
@property(nonatomic, strong)UIImageView * imgView;
@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UILabel * sourceLabel;

@end

@implementation CellForImageToLeft

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //清除点击灰色背景
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(10 * RATIO_WIDTH, 10 * RATIO_HEIGHT, SCREEN_WIDTH - 20 * RATIO_WIDTH, 120 * RATIO_HEIGHT)];
        [_bgView setBackgroundColor:[UIColor whiteColor]];;
        [self.contentView addSubview:_bgView];
        
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10 * RATIO_HEIGHT, SCREEN_WIDTH / 3, 95 * RATIO_HEIGHT)];
        [_bgView addSubview:_imgView];
        
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.frame.size.width + 10 * RATIO_WIDTH, _imgView.frame.origin.y, _bgView.frame.size.width - _imgView.frame.size.width - 15 * RATIO_WIDTH, 45 * RATIO_HEIGHT)];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_titleLabel setNumberOfLines:2];
        [_bgView addSubview:_titleLabel];
        
        
        _sourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.frame.origin.x, 90 * RATIO_HEIGHT, _titleLabel.frame.size.width - 10 * RATIO_WIDTH, 20 * RATIO_HEIGHT)];
        [_sourceLabel setTextAlignment:NSTextAlignmentRight];
        [_sourceLabel setFont:[UIFont systemFontOfSize:11]];
        [_bgView addSubview:_sourceLabel];
    }
    return self;
}

-(void)setBaseModel:(BaseModel *)baseModel
{
    [super setBaseModel:baseModel];
    ImageToLeft * left = (ImageToLeft *)baseModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:left.img] placeholderImage:[UIImage imageNamed:@"占125-95.png"]];
    [_titleLabel setText:left.title];
    [_sourceLabel setText:left.source];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
