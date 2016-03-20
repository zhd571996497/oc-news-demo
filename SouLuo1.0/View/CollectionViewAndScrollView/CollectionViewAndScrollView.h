//
//  CollectionViewAndScrollView.h
//  SouLuo1.0
//
//  Created by ls on 15/9/15.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseView.h"
#import "ListBar.h"
@class ArrowButton;
@class DeleteBar;
@class DetailsList;
@interface CollectionViewAndScrollView : BaseView

@property (nonatomic , strong)UICollectionView *contentCollectView;

@property (nonatomic , strong)ListBar *listBar;//栏目条

-(instancetype)initWithFrame:(CGRect)frame sortArray:(NSArray *)sortArray listArray:(NSArray *)listArray;

@end
