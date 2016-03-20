//
//  MoviePlayerViewController.m
//  Lesson9.3-AVPlayer
//
//  Created by ls on 15/9/3.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "MoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import "MBProgressHUD.h"

#define TopViewHeight 44
#define BottomViewHeight 72
#define VolumeStep 0.02f
#define BrightnessStep 0.02f
#define MovieProgressStep 5.0f

#define IOS7 ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)


//定义手势类型枚举
typedef NS_ENUM(NSInteger, GestureType){
    GestureTypeOfNone = 0,
    GestureTypeOfVolume,//声音
    GestureTypeOfBrightness,//亮度
    GestureTypeOfProgress,//快进快退
};


//记住播放进度相关的数据库操作类
@interface DatabaseManager : NSObject

+ (id)defaultDatabaseManager;

- (void)addPlayRecordWithIdentifier:(NSString *)identifier progress:(CGFloat)progress;

- (CGFloat)getProgressByIdentifier:(NSString *)identifier;

@end


@interface MoviePlayerViewController ()

//影片地址数组
@property(nonatomic , strong)NSArray *movieURLList;
//影片时间数组
@property(nonatomic , strong)NSMutableArray *itemTimeList;
//屏幕亮度
@property(nonatomic , assign)CGFloat systemBrightness;
//总的视频时长(多段的加在一起)
@property(nonatomic , assign)CGFloat movieLength;
//创建AVPlayer
@property(nonatomic , strong)AVPlayer * avPlayer;
//播放进度条
@property(nonatomic , strong)UISlider *movieProgressSlider;
//显示当前播放时间
@property(nonatomic , strong)UILabel *currentLable;
//显示剩余播放时间
@property(nonatomic , strong)UILabel *remainingTimeLable;
//手势类型
@property(nonatomic , assign)GestureType gestureType;
//当前播放视频的下标
@property(nonatomic)NSInteger currentPlayItem;
//小菊花
@property(nonatomic , strong)MBProgressHUD *progressHUD;
#warning 不知道
@property (nonatomic,weak)id timeObserver;

//顶部视图
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIButton *returnBtn;
@property (nonatomic,strong)UILabel *titleLable;

//底部视图
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIButton *playBtn;
@property (nonatomic,strong)UIButton *backwardBtn;
@property (nonatomic,strong)UIButton *forwardBtn;
@property (nonatomic,strong)UIButton *fastBackwardBtn;
@property (nonatomic,strong)UIButton *fastForeardBtn;

//亮度
@property (nonatomic,strong)UIImageView *brightnessView;
//进度条调整亮度
@property (nonatomic,strong)UIProgressView *brightnessProgress;

#warning 快进显示的时间
@property (nonatomic,strong)UIView *progressTimeView;
@property (nonatomic,strong)UILabel *progressTimeLable_top;
@property (nonatomic,strong)UILabel *progressTimeLable_bottom;
//快进前滑块的值
@property (nonatomic,assign)CGFloat ProgressBeginToMove;

@property (nonatomic,assign)BOOL isFirstOpenPlayer;//第一次打开需要读取历史观看进度
//判断视频是否在播放
@property (nonatomic,assign)BOOL isPlaying;

//触摸开始时的坐标
@property (nonatomic,assign)CGPoint originalLocation;

@end

@implementation MoviePlayerViewController

-(instancetype)initLocalMovieWithURLList:(NSArray *)urlList
{
    self = [super init];
    if (self) {
        
        _isPlaying = YES;
        _isFirstOpenPlayer = NO;

        self.movieURLList = urlList;
        self.itemTimeList = [[NSMutableArray alloc]init];
        //判断播放的是网络视频还是本地视频
        _mode = MoviePlayerViewControllerModeLocal;

    }
    return self;
}

-(instancetype)initNetMovieWithURL:(NSURL *)url{
    
    self = [super init];
    if (self) {
        
    
    //?? 正在播放
    _isPlaying = YES;
    
    _isFirstOpenPlayer = NO;
    
    _movieURL = url;
    
    //存视频的网址
    _movieURLList = @[url];
    
    _itemTimeList = [[NSMutableArray alloc]initWithCapacity:5];
    
    _mode = MoviePlayerViewControllerModeNetwork;
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"%s", __func__);
    
    //设置状态栏
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    /**
     *  respondsToSelector 判断是否响应了某个方法
 
     *  @param setNeedsStatusBarAppearanceUpdate 状态栏改变时调用的方法
     */
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        //隐藏状态栏
        [self prefersStatusBarHidden];
        
        //不直接调用，在程序运行时调用
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    self.view.backgroundColor = [UIColor blackColor];
  
    
    [self createAVPlayer];
    [self createBrightnessView];
    //显示进度时间
    [self createProgressTimeLable];
    
    
    //监控 app 活动状态，打电话/锁屏 时暂停播放
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
    
    //判断是否第一次打开
    if (![userd boolForKey:@"isFirstOpenMoviePlayerViewController"]) {
        //第一次打开，显示引导页
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
        btn.contentMode = UIViewContentModeScaleAspectFill;
        
        if (self.view.frame.size.height>500) {
            [btn setImage:[UIImage imageNamed:@"player_guide_1136.png"] forState:UIControlStateNormal];
        }else{
            [btn setImage:[UIImage imageNamed:@"player_guide_960.png"] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(firstCoverOnClick:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:btn];
        [userd setBool:YES forKey:@"isFirstOpenMoviePlayerViewController"];
        [userd synchronize];
        
    }

}





-(void)viewWillAppear:(BOOL)animated
{   //设置屏幕亮度
    self.systemBrightness = [UIScreen mainScreen].brightness;
}


- (void)createTopView{
    CGFloat titleLableWidth = 400;
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.height, TopViewHeight)];
    _topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    //添加返回按钮
    _returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, TopViewHeight)];
    [_returnBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_returnBtn setTitleColor:[UIColor colorWithRed:0.01f green:0.48f blue:0.98f alpha:1.00f] forState:UIControlStateNormal];
    [_returnBtn addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_returnBtn];
    
    //标题
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.height/2-titleLableWidth/2, 0, titleLableWidth, TopViewHeight)];
    _titleLable.backgroundColor = [UIColor clearColor];
    _titleLable.text = _movieTitle;
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:_titleLable];
    
    [self.view addSubview:_topView];
}
- (void)createBottomView{
    CGRect bounds = self.view.bounds;
    //底部视图
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, bounds.size.width-BottomViewHeight, bounds.size.height, BottomViewHeight)];
    _bottomView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.4f];
    
    // top
    CGFloat marginTop = 13;
    //开始暂停按钮
    _playBtn = [[UIButton alloc]initWithFrame:CGRectMake(bounds.size.height/2-20, marginTop-12, 40, 40)];
    [_playBtn setImage:[UIImage imageNamed:@"pause_nor.png"] forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(pauseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_playBtn];
    
    //快进按钮
    _fastBackwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(_playBtn.frame.origin.x-56-21, marginTop, 21, 16)];
    _fastBackwardBtn.tag = 1;
    [_fastBackwardBtn setImage:[UIImage imageNamed:@"fast_backward_nor.png"] forState:UIControlStateNormal];
    [_fastBackwardBtn addTarget:self action:@selector(fastAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_fastBackwardBtn];
    
    //快退按钮
    _fastForeardBtn = [[UIButton alloc]initWithFrame:CGRectMake(_playBtn.frame.origin.x+_playBtn.frame.size.width+56, marginTop, 21, 16)];
    _fastForeardBtn.tag = 2;
    [_fastForeardBtn setImage:[UIImage imageNamed:@"fast_forward_nor.png"] forState:UIControlStateNormal];
    [_fastForeardBtn addTarget:self action:@selector(fastAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_fastForeardBtn];
    
    //下一部
//    _forwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(_fastForeardBtn.frame.origin.x+_fastForeardBtn.frame.size.width+56, marginTop, 16, 16)];
//    _forwardBtn.tag = 1;
//    [_forwardBtn setImage:[UIImage imageNamed:@"forward_disable.png"] forState:UIControlStateNormal];
//    [_forwardBtn setImage:[UIImage imageNamed:@"forward_disable.png"] forState:UIControlStateHighlighted
//     ];
//    [_bottomView addSubview:_forwardBtn];
    
    // 上一部
//    _backwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(_fastBackwardBtn.frame.origin.x-56-16, marginTop, 16, 16)];
//    _backwardBtn.tag = 2;
//    [_backwardBtn setImage:[UIImage imageNamed:@"backward_disable.png"] forState:UIControlStateNormal];
//    [_backwardBtn setImage:[UIImage imageNamed:@"backward_disable.png"] forState:UIControlStateHighlighted];
//    [_bottomView addSubview:_backwardBtn];
    
    //判断 前进 后退 按钮是否可用
    if (_datasource) {
        if ([_datasource isHaveNextMovie]) {
            [_forwardBtn setImage:[UIImage imageNamed:@"forward_nor.png"] forState:UIControlStateNormal];
            [_forwardBtn addTarget:self action:@selector(forWordOrBackWardMovieAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([_datasource isHavePreviousMovie]) {
            [_backwardBtn setImage:[UIImage imageNamed:@"backward_nor.png"] forState:UIControlStateNormal];
            [_backwardBtn addTarget:self action:@selector(forWordOrBackWardMovieAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    //bottom
    CGFloat bottomOrigin_y = BottomViewHeight - 30;
    //当前时间
    _currentLable = [[UILabel alloc]initWithFrame:CGRectMake(0 , bottomOrigin_y, 63, 20)];
    _currentLable.font = [UIFont systemFontOfSize:13];
    _currentLable.textColor = [UIColor whiteColor];
    _currentLable.backgroundColor = [UIColor clearColor];
    _currentLable.textAlignment = NSTextAlignmentCenter;
    [_bottomView addSubview:_currentLable];
    
    //进度条
    _movieProgressSlider = [[UISlider alloc]initWithFrame:CGRectMake(63, bottomOrigin_y, bounds.size.height-126, 20)];//height 34
    [_movieProgressSlider setMinimumTrackTintColor:[UIColor whiteColor]];
    [_movieProgressSlider setMaximumTrackTintColor:[UIColor colorWithRed:0.49f green:0.48f blue:0.49f alpha:1.00f]];
    [_movieProgressSlider setThumbImage:[UIImage imageNamed:@"progressThumb.png"] forState:UIControlStateNormal];
    //触碰滑块触发
    [_movieProgressSlider addTarget:self action:@selector(scrubbingDidBegin) forControlEvents:UIControlEventTouchDown];
   
    //点击
    [_movieProgressSlider addTarget:self action:@selector(scrubbingDidEnd) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchCancel)];
    [_bottomView addSubview:_movieProgressSlider];
    
    //剩余时间
    _remainingTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.height-63, bottomOrigin_y, 63, 20)];
    _remainingTimeLable.font = [UIFont systemFontOfSize:13];
    _remainingTimeLable.textColor = [UIColor whiteColor];
    _remainingTimeLable.backgroundColor = [UIColor clearColor];
    _remainingTimeLable.textAlignment = NSTextAlignmentCenter;
    [_bottomView addSubview:_remainingTimeLable];
    
    [self.view addSubview:_bottomView];
}

//创建AVPlayer
-(void)createAVPlayer{
    /**
     *  AVPlayer 只能添加在AVPlayerLayer中才能显示将view 的layer层转化成AVPlyerLayer
     *  AVAudioSession 管理音频的类
     */
    //需引入AVfoundation 单例
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    //设置AVPlayer 的横屏后的frame
    CGRect playerFrame =CGRectMake(0, 0, self.view.layer.bounds.size.height, self.view.layer.bounds.size.width);
   
    
    //专门用来表示影片时间的类别  CGIimeMake(time,timeScale)
    //time 就是时间
    // timeScale 1秒需要有几个frame构成（fps）
    //秒  time / timeScale
    //视频的fps（帧率）是10，firstframe是第一帧的视频时间为0.1秒，lastframe是第10帧视频时间为1秒
    //或者换种写法   CMTime curFrame = CMTimeMake(第几帧， 帧率）
    //CMTimeMakeWithSeconds 和CMTimeMake 区别在于，第一个函数的第一个参数可以是float，其他一样
    //影片时间用CGTime
    __block CMTime totalTime = CMTimeMake(0, 0);
//    NSLog(@"%s", __func__);
    
    /**
     *  遍历视频地址数组
     *
     */
#warning 快速遍历enumerate需在调研
    [self.movieURLList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
//        NSLog(@"block");
        
        NSURL *url = (NSURL *)obj;
        
        //管理资源类
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
        //总共的电影时长
        
        
        //创建AVplayer
        self.avPlayer = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithURL: (NSURL *)_movieURLList[0]]];
        AVPlayerLayer *playerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
        playerLayer.frame = playerFrame;
#warning 不知道
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        
        [self.view.layer addSublayer:playerLayer];
        
        [self createTopView];
        [self createBottomView];
        //注册检测视频加载状态的通知
        [self.avPlayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
        //检测视频是否播放到结尾
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

       
        //设置视频的总时长(多个视频一共)
        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        
//        NSLog(@"before avplayer");
            totalTime.value += playerItem.asset.duration.value;
            totalTime.timescale = playerItem.asset.duration.timescale;
        
            //存储时间的数组每个视频的时长
            [_itemTimeList addObject:[NSNumber numberWithDouble:(double)playerItem.asset.duration.value/totalTime.timescale]];
//            NSLog(@"time length:%@", [NSNumber numberWithDouble:(double)playerItem.asset.duration.value/totalTime.timescale]);
            self.movieLength = (CGFloat)totalTime.value/totalTime.timescale;
            
            [self.avPlayer play];//播放
            
            
//            NSLog(@"creat avplayer");
           
            
            
#pragma mark- 设置显示时间
            //这里为了避免timer双重引用引起的内存泄漏
            /**
             *block对于其变量都会形成strong reference，对于self也会形成strong reference ，而如果self本身对block也是 strong reference 的话，就会形成 strong reference 循环，造成内存泄露，为了防止这种情况发生，在block外部应该创建一个week（__block） reference。
             
             所以在block内如果有self的话，一般都会在block外面加一句_block typeof(self)bself = self;
             
             __block typeof(self) bself = self;
             
             [self methodThatTakesABlock:^ {
             
             [bself doSomething];
             }
             */
            __weak typeof(_avPlayer) player_ = _avPlayer;
            __weak typeof(_movieProgressSlider) movieProgressSlider_ = _movieProgressSlider;
            __weak typeof(_currentLable) currentLable_ = _currentLable;
            __weak typeof(_remainingTimeLable) remainingTimeLable_ = _remainingTimeLable;
            __weak typeof(_itemTimeList) itemTimeList_ = _itemTimeList;
            
            typeof(_movieLength) *movieLength_ = &_movieLength;//取址
            
            //手势类型
            typeof(_gestureType) *gestureType_ = &_gestureType;
            
            //当前播放视频的下标
            typeof(_currentPlayItem) *currentPlayItem_ = &_currentPlayItem;
            
            /**
             
             用于监听每秒的状态，- (id)addPeriodicTimeObserverForInterval:(CMTime)interval queue:(dispatch_queue_t)queue usingBlock:(void(^)(CMTimetime))block;此方法就是关键，interval参数为响应的间隔时间，这里设为每秒都响应，queue是队列，传NULL代表在主线程执行。可以更新一个UI，比如进度条的当前时间等
             */
            self.timeObserver = [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(3, 30) queue:NULL usingBlock:^(CMTime time) {
                if ((*gestureType_) != GestureTypeOfProgress) {
                    //获取当前时间
                    CMTime currentTime = player_.currentItem.currentTime;
                    
                    // 当前播放的视频 的时间转化成秒数
                    double currentPlayTime = (double)currentTime.value/currentTime.timescale;
                    //当前播放的资源 当前播放视频的下标
                    NSInteger currentTemp = *currentPlayItem_;
                    
                    //主要用于分段显示
                    while (currentTemp > 0) {
                        
                        //itemTimeList_ 播放时间数组
                        //计算当前时间和以前时间的总和
                        currentPlayTime += [(NSNumber *)itemTimeList_[currentTemp-1]doubleValue];
                        --currentTemp;
                    }
                    
                    //剩下时间
                    CGFloat remainingTime = (*movieLength_) - currentPlayTime;
                    movieProgressSlider_.value = currentPlayTime/(*movieLength_);
                    
                    //计算时间 //将秒数转化成几分几秒
                    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:currentPlayTime];
                    NSDate *remainingDate = [NSDate dateWithTimeIntervalSince1970:remainingTime];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                    //设置时区
                    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
                    
                    [formatter setDateFormat:(currentPlayTime/3600 >= 1)?@"h:mm:ss":@"mm:ss" ];
                    //用字符串表示当前播放时间
                    NSString *currentTimeStr = [formatter stringFromDate:currentDate];
                    
                    //剩余播放时间
                    [formatter setDateFormat:(remainingTime/3600>=1)? @"h:mm:ss":@"mm:ss"];
                    NSString *remainingTimeStr = [NSString stringWithFormat:@"-%@",[formatter stringFromDate:remainingDate]];
                    
                    currentLable_.text = currentTimeStr;
                    remainingTimeLable_.text = remainingTimeStr;
                }
                
            }];
            
            
            
            
            //隐藏顶部和底部视图
            [self performSelector:@selector(hidenControlBar) withObject:nil afterDelay:3];
            
            [self.view bringSubviewToFront:_topView];
            [self.view bringSubviewToFront:_bottomView];
           
        }];
    }];
   
    
    // 小菊花
    self.progressHUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:_progressHUD];
    [_progressHUD show:YES];
}

#warning 注册KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *playerItem = (AVPlayerItem*)object;
        if (playerItem.status == AVPlayerStatusReadyToPlay) {
            //视频加载完成,去掉等待
            [_progressHUD hide:YES];
            
            //获取上次播放进度,仅对本地有效
//            if (!_isFirstOpenPlayer) {
//                CGFloat progress = [[DatabaseManager defaultDatabaseManager] getProgressByIdentifier:_movieTitle];
//                _movieProgressSlider.value = progress;
//                _isFirstOpenPlayer = YES;
//                [self scrubbingDidEnd];
//            }
//        }
        } else if (AVPlayerItemStatusFailed == playerItem.status) {
            [self.avPlayer.currentItem removeObserver:self forKeyPath:@"status" context:nil];
        }
    //    if ([keyPath isEqualToString:@"loadedTimeRanges"]){
    //        float bufferTime = [self availableDuration];
    //        NSLog(@"缓冲进度%f",bufferTime);
    //        float durationTime = CMTimeGetSeconds([[_player currentItem] duration]);
    //        NSLog(@"缓冲进度：%f , 百分比：%f",bufferTime,bufferTime/durationTime);
    //    }
   }
}

//调节亮度
- (void)createBrightnessView{
    _brightnessView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.height/2-63, self.view.frame.size.width/2-63, 125, 125)];
    _brightnessView.image = [UIImage imageNamed:@"video_brightness_bg.png"];
    //设置亮度
    _brightnessProgress = [[UIProgressView alloc]initWithFrame:CGRectMake(_brightnessView.frame.size.width/2-40, _brightnessView.frame.size.height-30, 80, 10)];
    _brightnessProgress.trackImage = [UIImage imageNamed:@"video_num_bg.png"];
    _brightnessProgress.progressImage = [UIImage imageNamed:@"video_num_front.png"];
    _brightnessProgress.progress = [UIScreen mainScreen].brightness;
    [_brightnessView addSubview:_brightnessProgress];
    [self.view addSubview:_brightnessView];
    _brightnessView.alpha = 0;
}

//快进时间
- (void)createProgressTimeLable{
    _progressTimeView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.height/2-100, self.view.bounds.size.width/2-30, 200, 60)];
    _progressTimeLable_top = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    _progressTimeLable_top.textAlignment = NSTextAlignmentCenter;
    _progressTimeLable_top.textColor = [UIColor whiteColor];
    _progressTimeLable_top.backgroundColor = [UIColor clearColor];
    _progressTimeLable_top.font = [UIFont systemFontOfSize:25];
    _progressTimeLable_top.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    _progressTimeLable_top.shadowOffset = CGSizeMake(1.0, 1.0);
    [_progressTimeView addSubview:_progressTimeLable_top];
    
    _progressTimeLable_bottom = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 200, 30)];
    _progressTimeLable_bottom.textAlignment = NSTextAlignmentCenter;
    _progressTimeLable_bottom.textColor = [UIColor whiteColor];
    _progressTimeLable_bottom.backgroundColor = [UIColor clearColor];
    _progressTimeLable_bottom.font = [UIFont systemFontOfSize:25];
    _progressTimeLable_bottom.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    _progressTimeLable_bottom.shadowOffset = CGSizeMake(1.0, 1.0);
    [_progressTimeView addSubview:_progressTimeLable_bottom];
    
    [self.view addSubview:_progressTimeView];
}

//隐藏顶部和底部
- (void)hidenControlBar{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect topFrame = _topView.frame;
        CGRect bottomFrame = _bottomView.frame;
        topFrame.origin.y = -TopViewHeight;
        bottomFrame.origin.y = self.view.frame.size.width;
        _topView.frame = topFrame;
        _bottomView.frame = bottomFrame;
    }];
}


#pragma mark- 监控app活动状态

/*
 *程序活动的动作
 */
- (void)becomeActive{
    [self pauseBtnClick];
}
/*
 *程序不活动的动作
 */
- (void)resignActive{
    [self pauseBtnClick];
}

//播放/暂停
- (void)pauseBtnClick
{
    _isPlaying = !_isPlaying;
    if (_isPlaying) {
        [self.avPlayer play];
        [_playBtn setImage:[UIImage imageNamed:@"pause_nor.png"] forState:UIControlStateNormal];
        
    }else{
        [self.avPlayer pause];
        [_playBtn setImage:[UIImage imageNamed:@"play_nor.png"] forState:UIControlStateNormal];
    }
}

#pragma mark- mark- 监控app活动状态


#pragma mark- 快退/快进

// 点击快进快退按钮触发 快退／快进
- (void)fastAction:(UIButton *)btn{
    if (btn.tag == 1) {
        [self movieProgressAdd:-MovieProgressStep];
    }else if (btn.tag == 2){
        [self movieProgressAdd:MovieProgressStep];
    }
}

//快进／快退
- (void)movieProgressAdd:(CGFloat)step{
    _movieProgressSlider.value += (step/_movieLength);
    [self scrubberIsScrolling];
}


//按动滑块
-(void)scrubbingDidBegin
{
    _gestureType = GestureTypeOfProgress;
    _ProgressBeginToMove = _movieProgressSlider.value;
    _progressTimeView.hidden = NO;
}

//拖动进度条
-(void)scrubberIsScrolling
{
    //更新视频前要移除KVO否则会crash
     [self.avPlayer.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    
    if (_mode == MoviePlayerViewControllerModeNetwork) {
        [self.view addSubview:_progressHUD];
        [_progressHUD show:YES];
    }
    //拖动滑块后的当前时间
    double currentTime = floor(_movieLength *_movieProgressSlider.value);
    //NSLog(@"sliderValue = %f  sliderMaxValue = %f",_movieProgressSlider.value,_movieProgressSlider.maximumValue);
    int i = 0;
   
    //视频时间 现在为数组第0个视频的时间
    double temp = [((NSNumber *)_itemTimeList[i]) doubleValue];
    
    while (currentTime > temp) {
        ++i;
        //当前视频和以前视频的时间总和
        temp += [((NSNumber *)_itemTimeList[i]) doubleValue];
    }
   // NSLog(@"%ld",_currentPlayItem);
    
    //如果视频快进到下一个视频就将当前的playerItem替换成快进后的playerItem
    if (i != _currentPlayItem) {
        
        [_avPlayer replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:(NSURL *)_movieURLList[i]]];
        //        [_player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        _currentPlayItem = i;
    }
    
    //减去当前视频的时间
    temp -= [((NSNumber *)_itemTimeList[i]) doubleValue];
    
    [self updateProfressTimeLable];//刷新进度时间
    
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(currentTime-temp, 1);
    [self.avPlayer seekToTime:dragedCMTime completionHandler:
     ^(BOOL finish){
         if (_isPlaying == YES){
             [self.avPlayer play];
         }
         if (_mode == MoviePlayerViewControllerModeNetwork) {
             [_progressHUD hide:YES];
         }

     }];
    
    
    
    [self.avPlayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}


//释放滑块
-(void)scrubbingDidEnd
{
    _gestureType = GestureTypeOfNone;
    _progressTimeView.hidden = YES;
    [self scrubberIsScrolling];
}

//刷新进度时间
- (void)updateProfressTimeLable{
    double currentTime = floor(_movieLength *_movieProgressSlider.value);
    /**
     *  abs 获取绝对值
     *
     *  @param _movieProgressSlider.value-_ProgressBeginToMove 改变的时间
     *
     *  @return 改变的时间
     */
    double changeTime = floor(_movieLength*ABS(_movieProgressSlider.value-_ProgressBeginToMove));
    //转成秒数
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:currentTime];
    NSDate *changeDate = [NSDate dateWithTimeIntervalSince1970:changeTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    [formatter setDateFormat:(currentTime/3600>=1)? @"h:mm:ss":@"mm:ss"];
    NSString *currentTimeStr = [formatter stringFromDate:currentDate];
    
    [formatter setDateFormat:(changeTime/3600>=1)? @"h:mm:ss":@"mm:ss"];
    NSString *changeTimeStr = [formatter stringFromDate:changeDate];
    
    //快进时间
    _progressTimeLable_top.text = currentTimeStr;
    
    _progressTimeLable_bottom.text = [NSString stringWithFormat:@"[%@ %@]",(_movieProgressSlider.value-_ProgressBeginToMove) < 0? @"-":@"+",changeTimeStr];
    
}

#pragma mark- mark -快退/快进

#pragma mark - 点击活动

//声音增加
- (void)volumeAdd:(CGFloat)step{
    [MPMusicPlayerController applicationMusicPlayer].volume += step;;
}
//亮度增加
- (void)brightnessAdd:(CGFloat)step{
    [UIScreen mainScreen].brightness += step;
    _brightnessProgress.progress = [UIScreen mainScreen].brightness;
}

//首次打开引导的点击消失
- (void)firstCoverOnClick:(UIButton *)button{
    [button removeFromSuperview];
}

//上一部／下一部
- (void)forWordOrBackWardMovieAction:(UIButton *)btn{
    _movieProgressSlider.value = 0.f;
    [self.view addSubview:_progressHUD];
    [_progressHUD show:YES];
    //下一部
    [_avPlayer.currentItem removeObserver:self forKeyPath:@"status"];
    NSDictionary *dic = nil;
    if (btn.tag == 1) {
        dic = [_datasource nextMovieURLAndTitleToTheCurrentMovie];
    }else if(btn.tag == 2){
        dic = [_datasource previousMovieURLAndTitleToTheCurrentMovie];
    }
    _movieURL = (NSURL *)[dic objectForKey:KURLOfMovieDicTionary];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:_movieURL];
    [_avPlayer replaceCurrentItemWithPlayerItem:playerItem];
    _movieTitle = [dic objectForKey:KTitleOfMovieDictionary];
    _titleLable.text = _movieTitle;
    //注册检测视频加载状态的通知
   // [_avPlayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //检测上一部/下一部电影的存在性
    if (_datasource && [_datasource isHaveNextMovie]) {
        [_forwardBtn setImage:[UIImage imageNamed:@"forward_nor.png"] forState:UIControlStateNormal];
        [_forwardBtn addTarget:self action:@selector(forWordOrBackWardMovieAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_forwardBtn setImage:[UIImage imageNamed:@"forward_disable.png"] forState:UIControlStateNormal];
        [_forwardBtn setImage:[UIImage imageNamed:@"forward_disable.png"] forState:UIControlStateHighlighted];
        [_forwardBtn removeTarget:self action:@selector(forWordOrBackWardMovieAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (_datasource && [_datasource isHavePreviousMovie]) {
        [_backwardBtn setImage:[UIImage imageNamed:@"backward_nor.png"] forState:UIControlStateNormal];
        [_backwardBtn addTarget:self action:@selector(forWordOrBackWardMovieAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_backwardBtn setImage:[UIImage imageNamed:@"backward_disable.png"] forState:UIControlStateNormal];
        [_backwardBtn setImage:[UIImage imageNamed:@"backward_disable.png"] forState:UIControlStateHighlighted];
        [_backwardBtn removeTarget:self action:@selector(forWordOrBackWardMovieAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

//视频播放到结尾
- (void)playerItemDidReachEnd:(NSNotification *)notification{
    //_currentPlayingItem+1 == _movieURLList.count 判断播放是否为最后一个，如果是就返回上一个界面，否则播放下一个
   
    
    
    if (_currentPlayItem+1 == _movieURLList.count) {
        [self popView];
    }else{
        
        [self.avPlayer.currentItem removeObserver:self forKeyPath:@"status" context:nil];
        // 播放下一个
        ++_currentPlayItem;
        [_avPlayer replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:_movieURLList[_currentPlayItem]]];
        if (_isPlaying == YES){
            [_avPlayer play];
        }
        //[_avPlayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
}

//返回事件
- (void)popView
{
    
    [self.avPlayer.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    //保存本次播放进度
  //  [[DatabaseManager defaultDatabaseManager] addPlayRecordWithIdentifier:_movieTitle progress:_movieProgressSlider.value];
    
    [_avPlayer removeTimeObserver:_timeObserver];
    [_avPlayer replaceCurrentItemWithPlayerItem:nil];//自动移除 observer
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    [self dismissViewControllerAnimated:YES completion:^{
        self.timeObserver = nil;
        self.avPlayer = nil;
        [UIScreen mainScreen].brightness = _systemBrightness;
        if ([_delegate respondsToSelector:@selector(movieFinished:)]) {
            [_delegate movieFinished:_movieProgressSlider.value];
        }
    }];
}

#pragma mark - mark - 点击活动


#pragma mark touch event

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    //滑动后的坐标
    CGPoint currentLocation = [touch locationInView:self.view];
    
    CGFloat offset_x = currentLocation.x - _originalLocation.x;
    CGFloat offset_y = currentLocation.y - _originalLocation.y;
    /**
     *  判断两个坐标是否一样
     */
    if (CGPointEqualToPoint(_originalLocation,CGPointZero)) {
        _originalLocation = currentLocation;
        return;
    }
    _originalLocation = currentLocation;
    
    //判断是调节亮度或声音或进度
    CGRect frame = [UIScreen mainScreen].bounds;
    if (_gestureType == GestureTypeOfNone) {
        //通过手指触摸在哪个区域和滑动方向确定是要做什么操作
        if ((currentLocation.x > frame.size.height*0.8) && (ABS(offset_x) <= ABS(offset_y))){
            
            _gestureType = GestureTypeOfVolume;
        }else if ((currentLocation.x < frame.size.height*0.2) && (ABS(offset_x) <= ABS(offset_y))){
            _gestureType = GestureTypeOfBrightness;
        }else if ((ABS(offset_x) > ABS(offset_y))) {
            _gestureType = GestureTypeOfProgress;
            _progressTimeView.hidden = NO;
        }
    }
  
    if ((_gestureType == GestureTypeOfProgress) && (ABS(offset_x) > ABS(offset_y))) {
          //调进度
        if (offset_x > 0) {
            //            NSLog(@"横向向右");
            _movieProgressSlider.value += 0.005;
        }else{
            //            NSLog(@"横向向左");
            _movieProgressSlider.value -= 0.005;
        }
        
        [self updateProfressTimeLable];
        
    }else if ((_gestureType == GestureTypeOfVolume) && (currentLocation.x > frame.size.height*0.8) && (ABS(offset_x) <= ABS(offset_y))){
        //调声音
        if (offset_y > 0){
            [self volumeAdd:-VolumeStep];
        }else{
            [self volumeAdd:VolumeStep];
        }
    }else if ((_gestureType == GestureTypeOfBrightness) && (currentLocation.x < frame.size.height*0.2) && (ABS(offset_x) <= ABS(offset_y))){
        //调亮度
        if (offset_y > 0) {
            _brightnessView.alpha = 1;
            [self brightnessAdd:-BrightnessStep];
        }else{
            _brightnessView.alpha = 1;
            [self brightnessAdd:BrightnessStep];
        }
    }
}
//点击时触发
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //CGRectZero：是一个高度为零，宽度为零，原点位置也为零，需要创建边框但还不确定边框大小和位置时，可以使用此常量
    _originalLocation = CGPointZero;
    
    _ProgressBeginToMove = _movieProgressSlider.value;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    if (_gestureType == GestureTypeOfNone && !CGRectContainsPoint(_bottomView.frame, point) && !CGRectContainsPoint(_topView.frame, point)) {
        //这说明是轻拍收拾，隐藏／现实状态栏
        [UIView animateWithDuration:0.25 animations:^{
            CGRect topFrame = _topView.frame;
            CGRect bottomFrame = _bottomView.frame;
            if (topFrame.origin.y<0) {
                //显示
                topFrame.origin.y = 0;
                bottomFrame.origin.y = self.view.frame.size.height-BottomViewHeight;
#warning 播放后隐藏底部和顶部
               // [self performSelector:@selector(hidenControlBar) withObject:nil afterDelay:3];
            }else{
                //隐藏
                topFrame.origin.y = -TopViewHeight;
                bottomFrame.origin.y = self.view.frame.size.height;
            }
            _topView.frame = topFrame;
            _bottomView.frame = bottomFrame;
        }];
    }else if (_gestureType == GestureTypeOfProgress){
        //如果手势是快进 点击后将手势置空
        _gestureType = GestureTypeOfNone;
        _progressTimeView.hidden = YES;
        [self scrubberIsScrolling];
    }else{
        //其他
        _gestureType = GestureTypeOfNone;
        _progressTimeView.hidden = YES;
        if (_brightnessView.alpha) {
            [UIView animateWithDuration:1 animations:^{
                _brightnessView.alpha = 0;
            }];
        }
    }
}




#pragma mark- 系统相关设置
// 隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES
}

//横屏
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
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



/*
 * DatabaseManager
 * 通过把播放过的影片的进度信息保存在plist 文件中，实现记住播放历史的功能
 * plist 文件采用队列形式，队列长度为50
 */

NSString *const MoviePlayerArchiveKey_identifier = @"identifier";
NSString *const MoviePlayerArchiveKey_date = @"date";
NSString *const MoviePlayerArchiveKey_progress = @"progress";

NSInteger const MoviePlayerArchiveKey_MaxCount = 50;

@implementation DatabaseManager
- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (DatabaseManager *)defaultDatabaseManager{
    static DatabaseManager *manager = nil;
    if (manager == nil) {
        manager = [[DatabaseManager alloc]init];
    }
    return manager;
}
+ (NSString *)pathOfArchiveFile{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath lastObject];
    NSString *plistFilePath = [documentPath stringByAppendingPathComponent:@"/playRecord.plist"];
    return plistFilePath;
}
- (void)addPlayRecordWithIdentifier:(NSString *)identifier progress:(CGFloat)progress{
    
    NSMutableArray *recardList = [[NSMutableArray alloc]initWithContentsOfFile:[DatabaseManager pathOfArchiveFile]];
    if (!recardList) {
        recardList = [[NSMutableArray alloc]init];
    }
    if (recardList.count==MoviePlayerArchiveKey_MaxCount) {
        [recardList removeObjectAtIndex:0];
    }
    
    NSDictionary *dic = @{MoviePlayerArchiveKey_identifier:identifier,MoviePlayerArchiveKey_date:[NSDate date],MoviePlayerArchiveKey_progress:@(progress)};
    [recardList addObject:dic];
    [recardList writeToFile:[DatabaseManager pathOfArchiveFile] atomically:YES];
}

- (CGFloat)getProgressByIdentifier:(NSString *)identifier{
    NSMutableArray *recardList = [[NSMutableArray alloc]initWithContentsOfFile:[DatabaseManager pathOfArchiveFile]];
    __block CGFloat progress = 0;
    [recardList enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = obj;
        if ([dic[MoviePlayerArchiveKey_identifier] isEqualToString:identifier]) {
            progress = [dic[MoviePlayerArchiveKey_progress] floatValue];
            *stop = YES;
        }
    }];
    if (progress > 0.9 || progress < 0.05) {
        return 0;
    }
    return progress;
}
@end

