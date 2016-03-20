//
//  DetailsList.m
//  SouLuo1.0
//
//  Created by ls on 15/9/14.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "DetailsList.h"
#import "ListItem.h"
#import "ColumnModel.h"
@interface DetailsList ()

@property (nonatomic,strong) UIView *sectionHeaderView;//更多标签视图
//存全部item
@property (nonatomic,strong) NSMutableArray *allItems;

@property (nonatomic,strong) ListItem *itemSelect;
@end

@implementation DetailsList

//重写listAllset方法
-(void)setListAll:(NSMutableArray *)listAll{
   
    _listAll = listAll;
    self.showsVerticalScrollIndicator = NO;
    self.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    self.backgroundColor = [UIColor whiteColor];
    
    NSArray *listTop = listAll[0];
    NSArray *listBottom = listAll[1];
    
    //    self.backgroundColor = [UIColor yellowColor];
#pragma 点击添加频道标签
    self.sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,padding+(padding + kItemH)*((listTop.count -1)/itemPerLine+1),SCREEN_WIDTH, 30)];
    self.sectionHeaderView.backgroundColor = MYCOLOR_GRB(238., 238., 238., 1.);
    
    UILabel *moreText = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
    moreText.text = @"点击添加频道";
    moreText.font = [UIFont systemFontOfSize:14];
    [self.sectionHeaderView addSubview:moreText];
    [self addSubview:self.sectionHeaderView];
    
    __weak typeof(self) unself = self;
    NSInteger count1 = listTop.count;//上面按钮数量
    
    //循环创建栏目按钮
    for (int i = 0; i < count1; i++) {
        //栏目按钮
        ListItem *item = [[ListItem alloc] initWithFrame:CGRectMake(padding+(padding+kItemW)*(i% itemPerLine), padding+(kItemH + padding)*(i/itemPerLine), kItemW, kItemH)];
        
        item.longPressBlock = ^(){
            
            if (unself.longPressedBlock) {
                unself.longPressedBlock();
            }
        };
        
        item.operationBlock = ^(animateType type, ColumnModel *model, int index){
            if (self.opertionFromItemBlock) {
                self.opertionFromItemBlock(type,model,index);
            }
        };
    
        item.buttonModel = listTop[i];//名字
       // NSLog(@"-------%@",item.itemName);
        item.location = top;//位置
        
        [self.topView addObject:item];//添加到数组中
        
        item->locateView = self.topView;//两个指针指向同一块内存
        item->topView = self.topView;
        item->bottomView = self.bottomView;
        
        item.hitTextLabel = self.sectionHeaderView;
        
        [self addSubview:item];
        
        [self.allItems addObject:item];
        
        if (!self.itemSelect) {//设置点击按钮 默认为第一个
           
            [item setTitleColor:[UIColor redColor] forState:0];
           
            self.itemSelect = item;
        }
    }
    
    NSInteger count2 = listBottom.count;//下面按钮数量
    
    for (int i=0; i<count2; i++) {
        ListItem *item = [[ListItem alloc] initWithFrame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine),CGRectGetMaxY(self.sectionHeaderView.frame)+padding+(kItemH+padding)*(i/itemPerLine), kItemW, kItemH)];
        item.operationBlock = ^(animateType type, ColumnModel *model, int index){
            if (self.opertionFromItemBlock) {
                self.opertionFromItemBlock(type,model,index);
            }
        };
        item.buttonModel = listBottom[i];
        item.location = bottom;
        item.hitTextLabel = self.sectionHeaderView;
        [self.bottomView addObject:item];
        item->locateView = self.bottomView;
        item->topView = self.topView;
        item->bottomView = self.bottomView;
        [self addSubview:item];
        [self.allItems addObject:item];
    }
    
    self.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.sectionHeaderView.frame)+padding+(kItemH+padding)*((count2-1)/4+1) + 50);
}

-(void)itemRespondFromListBarClickWithItemModel:(ColumnModel *)buttonModel{
//    NSLog(@"buttonModel.tname = %@",buttonModel.tname);
    
    for (int i = 0 ; i < self.allItems.count; i++) {
        
        ListItem *item = (ListItem *)self.allItems[i];
        if ([buttonModel.tname isEqualToString:item.buttonModel.tname]) {
            //设置点击按钮
            
            [self.itemSelect setTitleColor:MYCOLOR_GRB(110., 110., 110., 1) forState:UIControlStateNormal];
            
            [item setTitleColor:[UIColor redColor] forState:0];
            
            self.itemSelect = item;
        }
    }
}


//重写get
-(NSMutableArray *)allItems{
    if (_allItems == nil) {
        _allItems = [NSMutableArray array];
    }
    return _allItems;
}

-(NSMutableArray *)topView{
    if (_topView == nil) {
        _topView = [NSMutableArray array];
    }
    return _topView;
}

-(NSMutableArray *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [NSMutableArray array];
    }
    return _bottomView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
