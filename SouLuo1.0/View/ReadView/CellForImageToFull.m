//
//  CellForImageToFull.m
//  SouLuo1.0
//
//  Created by dllo on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "CellForImageToFull.h"
#import "ImageToFull.h"
#import "UIImageView+WebCache.h"

@interface CellForImageToFull ()

@property(nonatomic, strong)UIView * bgView;
@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UIImageView * leftImgView;
@property(nonatomic, strong)UIImageView * topImgView;
@property(nonatomic, strong)UIImageView * bottomImgView;
@property(nonatomic, strong)UILabel * sourceLabel;

@end

@implementation CellForImageToFull

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //清除点击灰色背景
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(10 * RATIO_WIDTH, 10 * RATIO_HEIGHT, SCREEN_WIDTH - 20 * RATIO_WIDTH, 230 * RATIO_HEIGHT)];
        [_bgView setBackgroundColor:[UIColor whiteColor]];;
        [self.contentView addSubview:_bgView];
        
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 * RATIO_WIDTH, 5 * RATIO_HEIGHT, SCREEN_WIDTH - 30 * RATIO_WIDTH, 30 * RATIO_HEIGHT)];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_bgView addSubview:_titleLabel];
        
        
        _leftImgView = [[UIImageView alloc]init];
        [_bgView addSubview:_leftImgView];
        
        
        _topImgView = [[UIImageView alloc]init];
        [_bgView addSubview:_topImgView];
        
        
        _bottomImgView = [[UIImageView alloc]init];
        [_bgView addSubview:_bottomImgView];
        
        
        _sourceLabel = [[UILabel alloc]init];
        [_sourceLabel setFont:[UIFont systemFontOfSize:11]];
        [_bgView addSubview:_sourceLabel];
        
    }
    return self;
}

-(void)setBaseModel:(BaseModel *)baseModel
{
    [super setBaseModel:baseModel];
    ImageToFull * full = (ImageToFull *)baseModel;
    [_titleLabel setText:full.title];
    
    
    if (0 == full.imgnewextra.count) {
        
        [_leftImgView setFrame:CGRectMake(2 * RATIO_WIDTH, 40 * RATIO_HEIGHT, SCREEN_WIDTH - 24 * RATIO_WIDTH, 162 * RATIO_HEIGHT)];
        [_leftImgView sd_setImageWithURL:[NSURL URLWithString:full.img] placeholderImage:[UIImage imageNamed:@"占350-170.png"]];
        [_topImgView setFrame:CGRectZero];
        [_bottomImgView setFrame:CGRectZero];
        
    } else if (1 == full.imgnewextra.count) {
        
        [_leftImgView setFrame:CGRectMake(2 * RATIO_WIDTH, 40 * RATIO_HEIGHT, (SCREEN_WIDTH - 26 * RATIO_WIDTH) / 2, 162 * RATIO_HEIGHT)];
        [_leftImgView sd_setImageWithURL:[NSURL URLWithString:full.img] placeholderImage:[UIImage imageNamed:@"占175-165.png"]];
        [_topImgView setFrame:CGRectMake(_leftImgView.frame.size.width + _leftImgView.frame.origin.x + 2 * RATIO_WIDTH, 40 * RATIO_HEIGHT, (SCREEN_WIDTH - 26 * RATIO_WIDTH) / 2, 162 * RATIO_HEIGHT)];
        [_topImgView sd_setImageWithURL:[NSURL URLWithString:[[full.imgnewextra objectAtIndex:0] objectForKey:@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"占175-165.png"]];
        [_bottomImgView setFrame:CGRectZero];
        
    } else {
        
        [_leftImgView setFrame:CGRectMake(2 * RATIO_WIDTH, 40 * RATIO_HEIGHT, 211 * RATIO_WIDTH, 162 * RATIO_HEIGHT)];
        [_leftImgView sd_setImageWithURL:[NSURL URLWithString:full.img] placeholderImage:[UIImage imageNamed:@"占210-170.png"]];
        [_topImgView setFrame:CGRectMake(_leftImgView.frame.size.width + _leftImgView.frame.origin.x + 2 * RATIO_WIDTH, 40 * RATIO_HEIGHT, 138 * RATIO_WIDTH, 80 * RATIO_HEIGHT)];
        [_topImgView sd_setImageWithURL:[NSURL URLWithString:[[full.imgnewextra objectAtIndex:0] objectForKey:@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"占120-85.png"]];
        [_bottomImgView setFrame:CGRectMake(_topImgView.frame.origin.x, _leftImgView.frame.origin.y + 82 * RATIO_HEIGHT, 138 * RATIO_WIDTH, 80 * RATIO_HEIGHT)];
        [_bottomImgView sd_setImageWithURL:[NSURL URLWithString:[[full.imgnewextra objectAtIndex:1] objectForKey:@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"占120-85.png"]];
    }

    [_sourceLabel setFrame:CGRectMake(5 * RATIO_WIDTH, _leftImgView.frame.origin.y + _leftImgView.frame.size.height + 10 * RATIO_HEIGHT, 300 * RATIO_WIDTH, 8 * RATIO_HEIGHT)];
    [_sourceLabel setText:full.source];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
