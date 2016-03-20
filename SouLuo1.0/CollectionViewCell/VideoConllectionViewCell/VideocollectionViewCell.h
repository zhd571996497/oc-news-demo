//
//  VideocollectionViewCell.h
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseCollectionViewCell.h"
@class VideoModel;

@interface VideocollectionViewCell : BaseCollectionViewCell

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *descriptionLabel;
@property(nonatomic,strong)UIImageView *coverImg;

-(void)getWithModel:(VideoModel *)model;

@end
