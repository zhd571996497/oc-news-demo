//
//  VideoView.h
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseView.h"
@class AVPlayerViewController;
@protocol VideoViewDelegate <NSObject>

-(void)pushAVPlayerController:(AVPlayerViewController *)AVPlayerVC;

@end

@interface VideoView : BaseView
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property(nonatomic , strong)NSArray * arr;
@property(nonatomic , assign)id<VideoViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array;
@end
