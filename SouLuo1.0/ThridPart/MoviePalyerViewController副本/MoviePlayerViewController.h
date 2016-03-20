//
//  MoviePlayerViewController.h
//  Lesson9.3-AVPlayer
//
//  Created by ls on 15/9/3.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

@protocol MoviePlayerViewControllerDelegate <NSObject>

- (void)movieFinished:(CGFloat)progress;

@end

@protocol MoviePlayerViewControllerDataSource <NSObject>

//key of dictionary
#define KTitleOfMovieDictionary @"title"
#define KURLOfMovieDicTionary @"url"

@required

- (NSDictionary *)nextMovieURLAndTitleToTheCurrentMovie;
- (NSDictionary *)previousMovieURLAndTitleToTheCurrentMovie;
- (BOOL)isHaveNextMovie;
- (BOOL)isHavePreviousMovie;

@end


//视频播放界面
@interface MoviePlayerViewController : UIViewController

typedef enum {
    MoviePlayerViewControllerModeNetwork = 0,
    MoviePlayerViewControllerModeLocal
} MoviePlayerViewControllerMode;

@property (nonatomic,strong,readonly)NSURL *movieURL;
@property (nonatomic,strong,readonly)NSArray *movieURLList;
@property (readonly,nonatomic,copy)NSString *movieTitle;
@property (nonatomic, assign) id<MoviePlayerViewControllerDelegate> delegate;
@property (nonatomic, assign) id<MoviePlayerViewControllerDataSource> datasource;
@property (nonatomic, assign) MoviePlayerViewControllerMode mode;
@property(nonatomic,strong)VideoModel *model;

//自定义初始化方法
-(instancetype)initLocalMovieWithURLList:(NSArray *)urlList;

-(instancetype)initNetMovieWithURL:(NSURL *)url;
@end
