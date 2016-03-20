//
//  CollectView.m
//  SouLuo1.0
//
//  Created by dllo on 15/9/11.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "CollectView.h"

@implementation CollectView

-(id)initWithFrame:(CGRect)frame
{
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    self = [super initWithFrame:frame];
    if (self) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 40) / 3, (SCREEN_WIDTH - 40) / 3);
        _flowLayout.minimumLineSpacing = 10;
        //不要加适配
        [_flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
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
