//
//  VideoView.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "VideoView.h"
#import "VideocollectionViewCell.h"
#import "VideoModel.h"
#import "AVPlayerViewController.h"

@implementation VideoView

-(id)initWithFrame:(CGRect)frame array:(NSArray *)array
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.arr = array;

    [self setBackgroundColor:[UIColor yellowColor]];
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    设置item大小，每个小模块的大小
    [self.flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH - 20,300)];
    //    设置行间距
    _flowLayout.minimumLineSpacing = 10;
    
    //    设置列间距
    _flowLayout.minimumInteritemSpacing = 0;
    
    //    设置item上下左右间距  1:距离navigation的距离 2：距离左侧的距离 3：距离下端距离  4：距离右侧的距离
    //    设置item上下左右间距
    [self.flowLayout setSectionInset:UIEdgeInsetsMake(10,10, 49, 10)];
    
//    //    集合视图
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:self.flowLayout];
    [self.collectionView setBackgroundColor:[UIColor lightGrayColor]];
    //隐藏滑轮
    self.collectionView.showsVerticalScrollIndicator = NO;
//    [self.collectionView setDataSource:self];
//    [self.collectionView setDelegate:self];
    [self addSubview:self.collectionView];
    //    注册cell
    [self.collectionView registerClass:[VideocollectionViewCell class] forCellWithReuseIdentifier:@"reuseId"];
}
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
