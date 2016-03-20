//
//  CellForReadCollect.h
//  SouLuo1.0
//
//  Created by dllo on 15/9/12.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface CellForReadCollect : BaseCollectionViewCell

@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UIImageView * imgView;
-(void)getInfoForTitle:(NSString *)title Img:(NSString *)imgName;

@end
