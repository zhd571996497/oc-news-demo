//
//  AudioCollectionViewCell.h
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/15.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "AudiocListModel.h"
#import "AudiotListModel.h"

@interface AudioCollectionViewCell : BaseCollectionViewCell

@property(nonatomic,strong)UILabel *cnameLabel;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)UILabel *titleLabelOne;
@property(nonatomic,strong)UILabel *tnameLabelOne;
@property(nonatomic,strong)UIImageView *imgsrcOne;

@property(nonatomic,strong)UILabel *titleLabelTwo;
@property(nonatomic,strong)UILabel *tnameLabelTwo;
@property(nonatomic,strong)UIImageView *imgsrcTwo;

@property(nonatomic,strong)UILabel *titleLabelThree;
@property(nonatomic,strong)UILabel *tnameLabelThree;
@property(nonatomic,strong)UIImageView *imgsrcThree;

@property(nonatomic,strong)UIButton *buttonOne;
@property(nonatomic,strong)UIButton *buttonTwo;
@property(nonatomic,strong)UIButton *buttonThree;

@property(nonatomic,strong)UIButton *button1;
@property(nonatomic,strong)UIButton *button2;
@property(nonatomic,strong)UIButton *button3;

@property(nonatomic,strong)UIImageView *imageView1;
@property(nonatomic,strong)UIImageView *imageView2;
@property(nonatomic,strong)UIImageView *imageView3;

-(void)Info:(AudiocListModel *)model;


@end
