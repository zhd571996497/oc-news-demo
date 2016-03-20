//
//  CellForNewsModel.m
//  SouLuo1.0
//
//  Created by ls on 15/9/18.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "CellForNewsModel.h"
#import "UIImageView+WebCache.h"
#import "NewsModel.h"

@interface CellForNewsModel ()

@property(nonatomic , strong)UILabel *titleLabel;

@property(nonatomic , strong)UILabel *digestlabel;

@property(nonatomic , strong)UIImageView *photoImage;

@end
@implementation CellForNewsModel

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 80)];
        [self.contentView addSubview:_photoImage];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, SCREEN_WIDTH - 130, 20)];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:_titleLabel];
        
        self.digestlabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 40, SCREEN_WIDTH - 130, 50)];
        _digestlabel.font = [UIFont systemFontOfSize:12];
        _digestlabel.numberOfLines = 0;
        [self.contentView addSubview:_digestlabel];
        
    }
    return self;
    
}


-(void)setBaseModel:(BaseModel *)baseModel{
    
    NewsModel *newsModel = (NewsModel *)baseModel;
    [_photoImage sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc ] placeholderImage:nil];
    [_titleLabel setText:newsModel.title];
    _digestlabel.text = newsModel.digest;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
