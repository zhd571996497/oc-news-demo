//
//  CollectionViewAndScrollView.m
//  SouLuo1.0
//
//  Created by ls on 15/9/15.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "CollectionViewAndScrollView.h"
#import "ListBar.h"
#import "ArrowButton.h"
#import "DeleteBar.h"
#import "DetailsList.h"
#import "ColumnModel.h"
#import "ColumnArraySingModel.h"
#import "Location.h"
#define kListBarH 30
#define kArrowW 40
#define kAnimationTime 0.8

@interface CollectionViewAndScrollView ()

@property (nonatomic , strong)NSMutableArray *sortArray;

@property (nonatomic , strong)UIScrollView *sortScroView;

@property (nonatomic , strong)ArrowButton *arrow;//下拉按钮

@property (nonatomic , strong)DetailsList *detailsList;//栏目页面

@property (nonatomic , strong)DeleteBar *deleteBar;//排序栏

@property (nonatomic, strong)NSMutableArray *sortBtnSelectArray;//类别选中数组
@property (nonatomic , strong)ColumnArraySingModel *singleModel;

@property (nonatomic , strong)NSMutableArray *listBottom;
@end

@implementation CollectionViewAndScrollView

-(instancetype)initWithFrame:(CGRect)frame sortArray:(NSArray *)sortArray listArray:(NSArray *)listArray{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.sortArray = [NSMutableArray arrayWithArray:sortArray];
        
        self.listBottom = [NSMutableArray arrayWithArray:listArray];
        
        __weak typeof(self) unself = self;
        
        if (!self.listBar) {
            //栏目条
            self.listBar = [[ListBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kListBarH)];
            self.listBar.visibleItemList = self.sortArray;
            
            //点击栏目页的按钮时调用的方法
            self.listBar.arrowChange = ^(){
                
                if (unself.arrow.arrowBtnClick) {
                    unself.arrow.arrowBtnClick();
                }
            };
            
#pragma 栏目条按钮点击调用方法,collectionView滑动到对应的cell
            //点击栏目条上的按钮时调用
            self.listBar.listBarItemClickBlock = ^( ColumnModel *model, NSInteger itemIndex){
                
                //设置排序页的点击按钮
                [unself.detailsList itemRespondFromListBarClickWithItemModel:model];
                //移动位置
                unself.contentCollectView.contentOffset = CGPointMake(itemIndex * unself.contentCollectView.frame.size.width, 0);
            
            };
            
            [self addSubview:self.listBar];
        }

#pragma 排序栏
        //排序栏
        self.deleteBar = [[DeleteBar alloc]initWithFrame:self.listBar.frame];
        [self addSubview:self.deleteBar];
        
#pragma 栏目页
        //栏目页 初始时隐藏
        self.detailsList = [[DetailsList alloc]initWithFrame:CGRectMake(0, kListBarH - SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - kListBarH - 113)];
        unself.detailsList.hidden = YES;
        
        self.detailsList.backgroundColor = [UIColor whiteColor];
        
        self.detailsList.listAll = [NSMutableArray arrayWithObjects:_sortArray,_listBottom,nil];
        
        //长按按钮触发相当于点击排序按钮
        self.detailsList.longPressedBlock = ^(){
            //排序按钮的点击方法
            [unself.deleteBar sortBtnClick:unself.deleteBar.sortBtn];
        };
        
        //根据点击类型，按钮model， 下标
        self.detailsList.opertionFromItemBlock = ^(animateType type, ColumnModel *model, int index){
            [unself.listBar operationFromBlock:type columnModel:model index:index];
        };
        [self addSubview:self.detailsList];
        
#pragma 下拉按钮
        
        self.arrow = [[ArrowButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - kArrowW, 0, kArrowW, kListBarH)];
        
        //点击下拉按钮显示栏目页
        self.arrow.arrowBtnClick = ^(){
            
            unself.deleteBar.hidden = !unself.deleteBar.hidden;
        
            if (YES == unself.deleteBar.hidden) {
                [unself.contentCollectView reloadData];
            }
            [UIView animateWithDuration:kAnimationTime animations:^{
                CGAffineTransform rotation = unself.arrow.imageView.transform;
                unself.arrow.imageView.transform = CGAffineTransformRotate(rotation,M_PI);
                unself.detailsList.hidden = !unself.detailsList.hidden;
                unself.detailsList.transform = (unself.detailsList.frame.origin.y<0)?CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT):CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
             
                
            }];
        };
        
        [self addSubview:self.arrow];
        
    }
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height-30);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;//?
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _contentCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-30) collectionViewLayout:flowLayout];
    
    [_contentCollectView setPagingEnabled:YES];
    
    [_contentCollectView setBackgroundColor:[UIColor whiteColor]];
    
    [self insertSubview:_contentCollectView atIndex:0];
    
    return self;
}



/**
 *  sortScrView按钮点击方法
 *
 *  @param button sortScrView上的按钮
 */
-(void) btnClick:(UIButton *)button
{
    for (UIButton *btn in _sortBtnSelectArray) {
        if (button == btn) {
            btn.selected = YES;
        }else {
            btn.selected = NO;
        }
        
        
    }
    CGFloat xlen = self.frame.size.width;
    
    //    [_contentCollectView setContentOffset:CGPointMake((xlen * button.tag), 0) animated:YES];
    [_contentCollectView setContentOffset:CGPointMake((xlen * (button.tag-1)), 0)];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
