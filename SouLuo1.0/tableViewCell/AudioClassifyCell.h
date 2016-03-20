//
//  AudioClassifyCell.h
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/16.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseTableViewCell.h"
@class AudiotListModel;

@interface AudioClassifyCell : BaseTableViewCell

@property(nonatomic,strong)UIImageView *imgsrc;
@property(nonatomic,strong)UILabel *tnameLabel;
@property(nonatomic,strong)UILabel *titleLabel;

-(void)getInfo:(AudiotListModel *)model;

@end
