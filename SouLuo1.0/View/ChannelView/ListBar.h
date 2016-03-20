//
//  ListBar.h
//  SouLuo1.0
//
//  Created by ls on 15/9/15.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ColumnModel;
typedef void (^ListBarItemClickBlock)(ColumnModel *model, NSInteger itemIndex);
//栏目条
@interface ListBar : UIScrollView

//点击排序页的按钮时可能调用的方法
@property (nonatomic,copy) void(^arrowChange)();

//点击栏目按钮时调用
@property (nonatomic,copy)ListBarItemClickBlock listBarItemClickBlock;
//存按钮model类的数组
@property (nonatomic,strong) NSMutableArray *visibleItemList;

-(void)operationFromBlock:(animateType)type columnModel:(ColumnModel *)columnModel index:(int)index;

-(void)itemClickByScrollerWithIndex:(NSInteger)index;

@end
