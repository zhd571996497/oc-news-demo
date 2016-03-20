//
//  HomeCollectionViewCell.h
//  SouLuo1.0
//
//  Created by ls on 15/9/17.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "BaseCollectionViewCell.h"
@class DetailTextNewsViewController;
@class DetailPhotoNewsViewController;
@protocol HomeCollectionViewHeadDelegate <NSObject>

@optional

-(void)pushDetailTextNewsController:(DetailTextNewsViewController *)newsController;
-(void)pushdetailPhotoNewsController:(DetailPhotoNewsViewController *)photoNewsController;

@end
@class ColumnModel;
@interface HomeCollectionViewHeadCell : BaseCollectionViewCell

@property (nonatomic , strong)ColumnModel *columnModel;

@property (nonatomic , assign)id<HomeCollectionViewHeadDelegate>delegate;
@end
