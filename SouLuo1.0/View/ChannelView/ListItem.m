//
//  ListItem.m
//  SouLuo1.0
//
//  Created by ls on 15/9/14.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "ListItem.h"
#import "ColumnModel.h"
#import "ColumnArraySingModel.h"
#define KDeleteWidth 6//删除按钮的宽
#define KItemFont 13 //字号
#define kItemSizeChangeAdded 2

@implementation ListItem

-(void)setButtonModel:(ColumnModel *)buttonModel{
    
 
    _buttonModel = buttonModel;
    
   // NSLog(@"--------%@",buttonModel.tname);
    [self setTitle:buttonModel.tname forState:UIControlStateNormal];
    [self setTitleColor:MYCOLOR_GRB(110, 110, 110, 1) forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:KItemFont];
    self.layer.cornerRadius = 4;
    self.layer.borderColor = [MYCOLOR_GRB(200, 200, 200, 200) CGColor];
    self.layer.borderWidth = 0.5;
    //self.backgroundColor = [UIColor whiteColor];
    //点击改变按钮的上下位置
    [self addTarget:self action:@selector(operationWithOutHidBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //设置拖拽手势
    self.gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureOperation:)];
    //设置长按手势
    self.longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)];
    self.longGesture.minimumPressDuration = 1;
    self.longGesture.allowableMovement = 20;
    [self addGestureRecognizer:self.longGesture];
    
    if (![buttonModel.tname isEqualToString:@"头条"]) {
        if ( nil == self.deleteBtn) {
            //设置删除按钮， 初始状态为隐藏并且关闭交互
            self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _deleteBtn.frame = CGRectMake(-KDeleteWidth + 2, -KDeleteWidth + 2, KDeleteWidth * 2, KDeleteWidth * 2);
            _deleteBtn.userInteractionEnabled = NO;
            [_deleteBtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            _deleteBtn.layer.cornerRadius = _deleteBtn.frame.size.width/2;
            _deleteBtn.hidden = YES;
            _deleteBtn.backgroundColor = MYCOLOR_GRB(110, 110, 110, 1.);
            [self addSubview:_deleteBtn];
        }
    }
    
    //设置显示按钮
    if (!self.hiddenBtn) {
        
        self.hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _hiddenBtn.frame = self.bounds;
        _hiddenBtn.hidden = NO;
        [_hiddenBtn addTarget:self action:@selector(operationWithHidBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_hiddenBtn];
    }
    
    //注册观察者 接收排序按钮的点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortButtonClick) name:@"sortBtnClick" object:nil];
    
}
//按钮的点击方法改变按钮的上下位置
-(void)operationWithOutHidBtn{
    if (![self.titleLabel.text isEqualToString:@"头条"]) {
        
        if (self.location == top) {
            //如果按钮在上面点击后去下面
            [self changeFromTopToBottom];
            
        }else if(self.location == bottom){
            //如果按钮在下面点击后去上面 显示删除按钮 并添加拖拽手势
            _deleteBtn.hidden = NO;
            
            [self addGestureRecognizer:self.gesture];
            //从下面去上面
            [self changeFromBottomToTop];
            
        }
        
        
    }
}

//从上面去下面
-(void)changeFromTopToBottom{
    //位置数组移除按钮
    [locateView removeObject:self];
    //下面数组插入按钮在第一个位置
    [bottomView insertObject:self atIndex:0];
    
    locateView = bottomView;//按钮的位置数组等于下面数组
    
    self.location = bottom;//记录按钮位置 在下面
    
    _deleteBtn.hidden = YES;//删除按钮隐藏
    
    [self removeGestureRecognizer:_gesture];//移除拖拽手势 按钮在下面时没有拖拽功能
    
    if (self.operationBlock) {
        /**
         *  根据改变位置执行相应的操作
         */
        self.operationBlock( FromTopToBottomHead, self.buttonModel ,0);
    }
    
    //动画更新按钮数组里的全部按钮位置
    [self animationForWholeView];
}

//判断按钮的坐标
-(void)animationForWholeView{
    
    //上面按钮
    for (int i = 0; i < topView.count; i++) {
        [self animationWithView:[topView objectAtIndex:i] frame:CGRectMake(padding + (padding+kItemW)*(i%itemPerLine), padding + (padding + kItemH)*(i/itemPerLine), kItemW, kItemH)] ;
    }
    
    //下面按钮
    for (int i = 0 ; i < bottomView.count; i++) {
       [ self animationWithView:[bottomView objectAtIndex:i] frame:CGRectMake(padding + (padding + kItemW)*(i%itemPerLine), [self topViewMaxY]+50+(kItemH + padding) * (i/itemPerLine), kItemW, kItemH)];
    }
   //改变“点击添加频道”view的坐标
    [self animationWithView:self.hitTextLabel frame:CGRectMake(0, [self topViewMaxY], SCREEN_WIDTH, 30)];

    [self p_creatCaches];
    
}

-(void)p_creatCaches{
    
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [arr lastObject];
    
    NSMutableArray *sortArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *listArray = [[NSMutableArray alloc]init];
    
    [[[ColumnArraySingModel defaultColumnArraySingleModel] columnArray] removeAllObjects];
    [[[ColumnArraySingModel defaultColumnArraySingleModel] columnSortArry] removeAllObjects];
    for (ListItem *item in topView) {
        [sortArray addObject:item.buttonModel];
   
        [[[ColumnArraySingModel defaultColumnArraySingleModel] columnArray] addObject:item.buttonModel];
    }
   
   // NSLog(@"kkkkkkkkkkkk     %ld",[[[ColumnArraySingModel defaultColumnArraySingleModel] columnArray] count]);
    
    for (ListItem *item in bottomView) {
        [listArray addObject:item.buttonModel];
        [[[ColumnArraySingModel defaultColumnArraySingleModel] columnSortArry] addObject:item.buttonModel];
    }
    
    NSString *sortFile = [path stringByAppendingString:@"/Caches/sort.plist"];
    [NSKeyedArchiver archiveRootObject:sortArray toFile:sortFile];
    
    NSString *listFile = [path stringByAppendingString:@"/Caches/list.plist"];
    [NSKeyedArchiver archiveRootObject:listArray toFile:listFile];
    
}


//使用动画改变按钮位置
-(void)animationWithView:(UIView *)view frame:(CGRect)frame{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [view setFrame:frame];
    } completion:nil];
}

//计算点“击添加频道”view的Y轴坐标
-(CGFloat)topViewMaxY{
    CGFloat y = 0;
    y = ((topView.count - 1)/itemPerLine + 1)*(kItemH + padding) + padding;
    return y;
    
}

//按钮从下面去上面
-(void)changeFromBottomToTop{
    
    [locateView removeObject:self];//先从位置数组中移除
    //添加到上面数组中
    [topView insertObject:self atIndex:topView.count];
    
    locateView = topView;//位置数组等于上面数组
    
    self.location = top;//记录位置在上面
    if (self.operationBlock) {
        
        self.operationBlock(FromBottomToTopLast,self.buttonModel,0);
    }
    //更新按钮位置
    [self animationForWholeView];
}

//拖拽手势
- (void)panGestureOperation:(UIPanGestureRecognizer *)pan{
    [self.superview exchangeSubviewAtIndex:[self.superview.subviews indexOfObject:self] withSubviewAtIndex:[[self.superview subviews] count] - 1];
    
    //在拖拽时连续变化的坐标 也就是改变距离
    CGPoint translation = [pan translationInView:pan.view];
    
    //拖拽后新的位置的中心点 连续改变
    CGPoint center = pan.view.center;
    center.x += translation.x;
    center.y += translation.y;
    pan.view.center = center;
    
    [pan setTranslation:CGPointZero inView:pan.view];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            //触摸开始时按钮变大4个，坐标改变两个
            CGRect itemFrame = self.frame;
            [self setFrame:CGRectMake(itemFrame.origin.x-kItemSizeChangeAdded, itemFrame.origin.y-kItemSizeChangeAdded, itemFrame.size.width+kItemSizeChangeAdded*2, itemFrame.size.height+kItemSizeChangeAdded*2)];
        }
            break;
            //改变时
        case UIGestureRecognizerStateChanged:{
            //判断按钮是否在上面
            BOOL InTopView = [self whetherInAreaWithArray:topView Point:center];
            if (InTopView) {
                //行下标
                NSInteger indexX = (center.x <= kItemW+2*padding)? 0 : (center.x - kItemW-2*padding)/(padding+kItemW) + 1;
                //列下标
                NSInteger indexY = (center.y <= kItemH+2*padding)? 0 : (center.y - kItemH-2*padding)/(padding+kItemH) + 1;
                //总的下标
                NSInteger index = indexX + indexY*itemPerLine;
                
                index = (index == 0)? 1:index;
                
                [locateView removeObject:self];//从位置数组中移除
                
                [topView insertObject:self atIndex:index];//更换下标
                
                locateView = topView;//重新赋值
                
                [self animationForTopView];//更新按钮位置
                
                if (self.operationBlock) {
                    /**
                     *  拖拽时调用
                     */
                    self.operationBlock(FromTopToTop,self.buttonModel,(int)index);
                }
            }
            //如果按钮位置不在上面但是在 [self TopViewMaxY]+50以上
            else if (!InTopView && center.y < [self topViewMaxY]+50) {
                [locateView removeObject:self];//从位置数组中移除
                [topView insertObject:self atIndex:topView.count];//直接放入上面数组中
                locateView = topView;
                //更新上面按钮位置
                [self animationForTopView];
                
                if (self.operationBlock) {
                    
                    self.operationBlock(FromTopToTopLast,self.buttonModel,0);
                }
            }
            //如果移动到下面
            else if (center.y > [self topViewMaxY]+50){
                //从上面转移到下面
                [self changeFromTopToBottom];
            }
        }
            break;
            //手势执行结束时
        case UIGestureRecognizerStateEnded:
            //更新按钮位置
            [self animationForWholeView];
            break;
        default:
            break;
    }
}

//长按手势
-(void)longPress{
    
    if (self.hiddenBtn.hidden == NO) {
        if (self.longPressBlock) {
            //将语法块置空
            self.longPressBlock();
        }
        //添加拖拽手势
        if (self.location == top) {
            [self addGestureRecognizer:self.gesture];
        }
    }
}

//判断按钮是否在上面
- (BOOL)whetherInAreaWithArray:(NSMutableArray *)array Point:(CGPoint)point{
    //判断数组最后一个行和列
    int row = (array.count%itemPerLine == 0)? itemPerLine : array.count%itemPerLine;
    int column =  (int)(array.count-1)/itemPerLine+1;
    
    if ((point.x > 0 && point.x <=SCREEN_WIDTH &&point.y > 0 && point.y <= (kItemH + padding)*(column-1)+padding)||
        (point.x > 0 && point.x <= (row*(padding+kItemW)+padding)&& point.y > (kItemH + padding)*(column -1)+padding && point.y <= (kItemH+padding) * column+padding)){
        return YES;
    }
    return NO;
}


//上面按钮位置交换
- (void)animationForTopView{
    for (int i = 0; i < topView.count; i++){
        if ([topView objectAtIndex:i] != self){
            //更新按钮位置
            [self animationWithView:[topView objectAtIndex:i] frame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine), padding+(kItemH + padding)*(i/itemPerLine), kItemW, kItemH)];
        }
    }
}

//显示按钮点击方法
-(void)operationWithHidBtn{
    //如果显示按钮未隐藏说明不是排序状态
    //上面按钮不动，下面按钮点击会去上面
    if (!self.hiddenBtn.hidden) {
        //如果button在上面
        if (self.location == top) {
            //设置title颜色
            [self setTitleColor:[UIColor redColor] forState:0];
            
            if (self.operationBlock) {
                /**
                 *  topViewClick 类型 点击
                 按钮栏目名字
                 下标
                 */
                self.operationBlock(topViewClick,self.buttonModel,0);
            }
            
            [self animationForWholeView];
        }
        //如果button在下面
        else if (self.location == bottom){
            
            [self changeFromBottomToTop];
        }
    }
}

//排序消息中心
-(void)sortButtonClick{
        //如果button在上面添加删除按钮
        if (self.location == top){
            self.deleteBtn.hidden = !self.deleteBtn.hidden;
        }
        
        self.hiddenBtn.hidden = !self.hiddenBtn.hidden;
    if (![self.titleLabel.text isEqualToString:@"头条"]) {
        
        
        //如果有拖拽移除
        if (self.gestureRecognizers) {
            [self removeGestureRecognizer:self.gesture];
        }
        //如果button在上面并且显示按钮隐藏添加拖拽手势
        if (self.hiddenBtn.hidden && self.location == top) {
            [self addGestureRecognizer:self.gesture];
        }
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
