//
//  ColumnView.m
//  SouLuo1.0
//
//  Created by ls on 15/9/10.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "ColumnView.h"

@implementation ColumnView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewLayout *flowLayout = [[UICollectionViewLayout alloc]init];
        
        self.columnCollection = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
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
