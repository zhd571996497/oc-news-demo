//
//  DetailsList.h
//  SouLuo1.0
//
//  Created by ls on 15/9/14.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ColumnModel;
/**
 *  长按手势时调用
 */
typedef void(^LongPressedBlock) ();
/**
 *  根据按钮的点击类型执行相应的操作
 *
 *  @param type  按钮点击的类型
 *  @param item  button 的model类
 *  @param index button的下标
 */
typedef void(^OpertionFromItemBlock) (animateType type, ColumnModel *model, int index);
//栏目页面
@interface DetailsList : UIScrollView
//上面button数组
@property (nonatomic , strong) NSMutableArray *topView;
//下面button数组
@property (nonatomic , strong) NSMutableArray *bottomView;
//存上面和下面butonModel
@property (nonatomic , strong) NSMutableArray *listAll;

@property (nonatomic , copy) LongPressedBlock longPressedBlock;

@property (nonatomic , copy) OpertionFromItemBlock opertionFromItemBlock;

//选择选中的按钮
-(void)itemRespondFromListBarClickWithItemModel:(ColumnModel *)buttonModel;
@end
