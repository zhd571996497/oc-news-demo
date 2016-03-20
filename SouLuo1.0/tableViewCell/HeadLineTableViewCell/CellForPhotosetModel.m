//
//  CellForPhotosetModel.m
//  SouLuo1.0
//
//  Created by ls on 15/9/18.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "CellForPhotosetModel.h"
#import "PhotosetModel.h"
#import "UIImageView+WebCache.h"
@interface CellForPhotosetModel ()

@property (nonatomic , strong)UILabel *titleLabel;

@property (nonatomic , strong)UIImageView *leftImage;

@property (nonatomic , strong)UIImageView *midImage;

@property (nonatomic , strong)UIImageView *rightImage;

@end

@implementation CellForPhotosetModel

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 25 , 15)];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_titleLabel];
        
        CGFloat width = (SCREEN_WIDTH - 30)/3;
        CGFloat height = 80 * width/115;
        CGFloat xLen = 10;
        self.leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(xLen, 35, width, height)];
        [self.contentView addSubview:_leftImage];
        
        xLen += width + 5;
        self.midImage = [[UIImageView alloc]initWithFrame:CGRectMake(xLen, 35, width, height)];
        [self.contentView addSubview:_midImage];
        
        xLen += width + 5;
        self.rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(xLen, 35, width, height)];
        [self.contentView addSubview:_rightImage];
        
    }
    return self;
}

-(void)setBaseModel:(BaseModel *)baseModel
{
    PhotosetModel *photosetModel = (PhotosetModel *)baseModel;
    
    _titleLabel.text = photosetModel.title;

    [_leftImage sd_setImageWithURL:[NSURL URLWithString:photosetModel.imgsrc] placeholderImage:nil];
    NSArray *pcArray = photosetModel.imgextra;
    if (pcArray.count > 1) {
        
        [_midImage sd_setImageWithURL:[NSURL URLWithString:pcArray[0][@"imgsrc"]] placeholderImage:nil];
    }
    if (pcArray.count > 2) {
        
        [_rightImage sd_setImageWithURL:[NSURL URLWithString:pcArray[1][@"imgsrc"] ] placeholderImage:nil];
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
