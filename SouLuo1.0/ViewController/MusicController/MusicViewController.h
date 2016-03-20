//
//  MusicViewController.h
//  SouLuo1.0
//
//  Created by ls on 15/9/9.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseViewController.h"
@class AudioPlay;
//电台
@interface MusicViewController : BaseViewController

@property(nonatomic,strong)AudioPlay *play;//播放器
@property(nonatomic,strong)UISlider *timeSlider;//进度条
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *singerLabel;
@property(nonatomic,strong)UILabel *current;//开始时间
@property(nonatomic,strong)UILabel *total;//时间总长
@property(nonatomic,strong)NSTimer *myTime;//进度条的时间
@property(nonatomic,assign)NSInteger playindex;//歌曲的下标
@property(nonatomic,strong)UIButton *upButton;//上一首
@property(nonatomic,strong)UIButton *nextButton;//下一首
@property(nonatomic,strong)UIButton *stopButton;//暂停

-(void)audioPlay;

@end
