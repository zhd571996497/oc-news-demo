//
//  MusicViewController.m
//  SouLuo1.0
//
//  Created by ls on 15/9/9.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "MusicViewController.h"
#import "AudioPlay.h"
#import "AudioPlayMessage.h"
#import "AudiotListModel.h"
#import "DRNRealTimeBlurView.h"

@interface MusicViewController ()

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _play = [AudioPlay sharHandleController];
    
    
    self.playindex = [AudioPlayMessage message].index;
    
//    NSLog(@"width == %f, height == %f",width, height);
    
    
}

-(void)audioPlay
{
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [image setImage:[UIImage imageNamed:@"beijing3"]];
    [self.view addSubview:image];
    [image setUserInteractionEnabled:YES];
    DRNRealTimeBlurView * blurView = [[DRNRealTimeBlurView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [image addSubview:blurView];//毛玻璃的根视图，自己定义
    blurView.alpha = 0.8;
    
    _stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_stopButton setFrame:CGRectMake(SCREEN_WIDTH/2-15,RATIO_HEIGHT*70,RATIO_WIDTH*30 ,RATIO_HEIGHT*30)];
    //    [stopButton setBackgroundColor:[UIColor purpleColor]];
    [_stopButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [_stopButton setImage:[UIImage imageNamed:@"zanting.png"] forState:UIControlStateNormal];
    [_stopButton setImage:[UIImage imageNamed:@"1bofang.png"] forState:UIControlStateSelected];
    [blurView addSubview:_stopButton];
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextButton setFrame:CGRectMake(SCREEN_WIDTH/2+85,RATIO_HEIGHT*70,RATIO_WIDTH*30 ,RATIO_HEIGHT*30)];
    //    [nextButton setBackgroundColor:[UIColor purpleColor]];
    [_nextButton addTarget:self action:@selector(xButton) forControlEvents:UIControlEventTouchUpInside];
    [_nextButton setImage:[UIImage imageNamed:@"xiayishou.png"] forState:UIControlStateNormal];
    [blurView addSubview:_nextButton ];
    
    _upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upButton setFrame:CGRectMake(SCREEN_WIDTH/2-115,RATIO_HEIGHT*70,RATIO_WIDTH*30,RATIO_HEIGHT*30)];
    [_upButton addTarget:self action:@selector(sButton) forControlEvents:UIControlEventTouchUpInside];
    [_upButton setImage:[UIImage imageNamed:@"shangyishou.png"] forState:UIControlStateNormal];
    [blurView addSubview:_upButton];
    
    _timeSlider = [[UISlider alloc]initWithFrame:CGRectMake(RATIO_WIDTH*5, RATIO_HEIGHT*160, RATIO_WIDTH*365, RATIO_HEIGHT*5)];
    [_timeSlider setContinuous:YES];
    //    _timeSlider.minimumTrackTintColor = [UIColor cyanColor];
    _timeSlider.maximumTrackTintColor = [UIColor lightGrayColor];
    //    [progress addTarget:self action:@selector(PlaySlider) forControlEvents:UIControlEventValueChanged];
    _timeSlider.minimumValue = 0.0;
    _timeSlider.maximumValue = 50;
    [blurView addSubview:_timeSlider];
    
    
    _titleLabel.text=[AudioPlayMessage message].title;
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [blurView addSubview:_titleLabel];
    
    self.myTime=[NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(track) userInfo:nil repeats:YES];
    
    //开始时间
    _current = [[UILabel alloc] initWithFrame:CGRectMake(RATIO_WIDTH*5,RATIO_HEIGHT*180, RATIO_WIDTH*50, RATIO_HEIGHT*25)];
    _current.font =[UIFont boldSystemFontOfSize:14.0f];
    _current.textAlignment = NSTextAlignmentCenter;
    _current.textColor = [UIColor whiteColor];
    _current.text = @"00:00";
    [blurView addSubview:_current];
    //总长
    _total = [[UILabel alloc] initWithFrame:CGRectMake(RATIO_WIDTH*320,RATIO_HEIGHT*180,RATIO_WIDTH*50,RATIO_HEIGHT*20)];
    _total.font =[UIFont boldSystemFontOfSize:14.0f];
    _total.textAlignment = NSTextAlignmentCenter;
    _total.textColor = [UIColor whiteColor];
    _total.text = @"00:00";
    [blurView addSubview:_total];

}

//进度条
-(void)track
{
    if (_timeSlider) {
        
        _timeSlider.maximumValue = _play.duration;
        _timeSlider.value = _play.progress;
        
        NSInteger pMin = (NSInteger)_play.progress / 60;
        NSInteger pSec = (NSInteger)_play.progress % 60;
        
        NSInteger dMin = (NSInteger)_play.duration / 60;
        NSInteger dSec = (NSInteger)_play.duration % 60;
        
        _current.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)pMin, (long)pSec];
        _total.text=[NSString stringWithFormat:@"%02ld:%02ld" , (long)dMin, (long)dSec];
    }
    
    
}
//上一首点击
-(void)sButton
{
    if ([AudioPlayMessage message].urlArray .count!= 0) {
        self.playindex--;
        
        //        如果是第一首歌 再点上一首播放最后一首
        if (-1 == self.playindex) {
            self.playindex = [AudioPlayMessage message].urlArray .count -1;
        }
        
        
        
        AudiotListModel *lismModel = [[AudioPlayMessage message].urlArray objectAtIndex:self.playindex];
        [self nameget:lismModel];
        
        
        [_play play:lismModel.url];
        
        
    }
}
//暂停 继续按钮
-(void)button:(UIButton *)btn
{
    if (btn.selected == NO)
    {
        btn.selected = YES;
        
        [_play pause];
    }
    else
    {
        [_play resume];
        
        
        btn.selected = NO;
    }
}
//传值
-(void)nameget:(AudiotListModel *)model{
    _titleLabel.text=model.title;
}
//下一首
-(void)xButton
{
    if ([AudioPlayMessage message].urlArray .count!= 0) {
        self.playindex ++;
        
        if ([AudioPlayMessage message].urlArray .count == self.playindex) {
            self.playindex = 0;
        }
        
        
        //  赋值
        AudiotListModel *lismModel = [[AudioPlayMessage message].urlArray objectAtIndex:self.playindex];
        [self nameget:lismModel];
        
        [_play play:lismModel.url];
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
