//
//  ListItem.h
//  SouLuo1.0
//
//  Created by ls on 15/9/14.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ColumnModel;
/**
 button所处位置
 */
typedef enum {
    top = 0,
    bottom = 1
}itemLocation;
/**
 *  长按button时调用
 */
typedef void(^LongPressBlock)();
/**
 *  根据按钮点击类型执行对应的操作
 *  type : 类型
    按钮的model类
    按钮的下标
 */
typedef void(^OperationBlock) (animateType type, ColumnModel *model, int index);
//栏目button
@interface ListItem : UIButton
{
    @public
    NSMutableArray *locateView;//位置数组
    
    NSMutableArray *topView;//上面按钮数组

    NSMutableArray *bottomView;//下面按钮数组
}
//点击加载频道View 通过button来改变坐标
@property (nonatomic , strong) UIView *hitTextLabel;

@property (nonatomic , strong) UIButton *deleteBtn;//删除button
//在button上面在覆盖一个button
@property (nonatomic , strong) UIButton *hiddenBtn;//显示按钮
//button所在位置
@property (nonatomic , assign) itemLocation location;
//button的名字
@property (nonatomic , copy)NSString *itemName;
//button的model类
@property (nonatomic , strong)ColumnModel *buttonModel;

@property (nonatomic , copy) LongPressBlock longPressBlock;

@property (nonatomic , copy) OperationBlock operationBlock;
//拖拽手势
@property (nonatomic , strong) UIPanGestureRecognizer *gesture;
//长按手势
@property (nonatomic , strong) UILongPressGestureRecognizer *longGesture;

@end
