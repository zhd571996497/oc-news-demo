//
//  ListBar.m
//  SouLuo1.0
//
//  Created by ls on 15/9/15.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "ListBar.h"
#import "ColumnModel.h"
#import <CoreLocation/CoreLocation.h>//引入库
#import <MapKit/MapKit.h>
#import "Location.h"
#import "ColumnArraySingModel.h"
#define kDistanceBetweenItem 32
#define kExtraPadding 20
#define itemFont 13

@interface ListBar ()<LocationDelegate>

@property (nonatomic, assign) CGFloat maxWidth;//最大宽度
@property (nonatomic, strong) UIView *btnBackView;//背景
@property (nonatomic, strong) UIButton *btnSelect;//选择的按钮
@property (nonatomic, strong) NSMutableArray *btnLists;//按钮数组
@property (nonatomic , strong)ColumnArraySingModel *singleModel;
//@property (nonatomic, strong) NSMutableArray *btnModelArray;//存button Model的数组
@end

@implementation ListBar

-(NSMutableArray *)btnLists{
    if (_btnLists == nil) {
        _btnLists = [NSMutableArray array];
    }
    return _btnLists;
}


//-(instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.btnModelArray = [[NSMutableArray alloc]init];
//    }
//    return self;
//}

-(void)setVisibleItemList:(NSMutableArray *)visibleItemList{
    
    _visibleItemList = visibleItemList;
    
    _singleModel = [ColumnArraySingModel defaultColumnArraySingleModel];
    
   // if (!self.btnBackView) {
        self.btnBackView = [[UIView alloc] initWithFrame:CGRectMake(10,(self.frame.size.height-20)/2,46,20)];
        self.btnBackView.backgroundColor =MYCOLOR_GRB(202., 51, 54, 1);
        self.btnBackView.layer.cornerRadius = 5;
        [self addSubview:self.btnBackView];
        
        self.maxWidth = 20;
        self.backgroundColor = MYCOLOR_GRB(238., 238., 238., 1);
        //self.backgroundColor = [UIColor blueColor];
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 50);
        self.showsHorizontalScrollIndicator = NO;
        
   // }
    for (int i =0; i<visibleItemList.count; i++) {
        //创建按钮 visibleItemList 存按钮model的数组
        [self makeItemWithTitle:[visibleItemList[i] tname]];
    }
    self.contentSize = CGSizeMake(self.maxWidth, self.frame.size.height);
}

//根据按钮名字创建按钮
-(void)makeItemWithTitle:(NSString *)title{
    
    //NSLog(@"title ==== %@",title);
    CGFloat itemW = [self calculateSizeWithFont:itemFont Text:title].size.width;
    UIButton *item = [[UIButton alloc] initWithFrame:CGRectMake(self.maxWidth, 0, itemW, self.frame.size.height)];
    item.titleLabel.font = [UIFont systemFontOfSize:itemFont];
    [item setTitle:title forState:0];
    [item setTitleColor:MYCOLOR_GRB(111, 111, 111, 1) forState:UIControlStateNormal];
    [item setTitleColor:MYCOLOR_GRB(111.0, 111.0, 111.0,1) forState:UIControlStateHighlighted];
    
    [item setTitleColor:MYCOLOR_GRB(111, 111, 111, 1) forState:UIControlStateSelected];
    
    //[item setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [item addTarget:self
             action:@selector(itemClick:)
   forControlEvents:UIControlEventTouchUpInside];
    
    self.maxWidth += itemW+kDistanceBetweenItem;
    [self.btnLists addObject:item];
    [self addSubview:item];
    
    //创建默认按钮
    if (!self.btnSelect) {
        [item setTitleColor:[UIColor whiteColor] forState:0];
        self.btnSelect = item;
    }
    //设置滚动大小
    self.contentSize = CGSizeMake(self.maxWidth, self.frame.size.height);
    //NSLog(@"itemName ==== %@",item.titleLabel.text);
}

//计算按钮大小
-(CGRect)calculateSizeWithFont:(NSInteger)Font Text:(NSString *)Text{
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:Font]};
    //宽度
    CGRect size = [Text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height)
                                     options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attr
                                     context:nil];
    return size;
}

//按钮的点击方法
-(void)itemClick:(UIButton *)sender{
    
    if (self.btnSelect != sender) {
        
        [self.btnSelect setTitleColor:MYCOLOR_GRB(111, 111, 111, 1) forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor whiteColor] forState:0];
        self.btnSelect = sender;
        ColumnModel *model = [[ColumnModel alloc]init];
       // NSLog(@"senderName = %@",sender.titleLabel.text);
        if ([sender.titleLabel.text isEqualToString:@"本地"] && [CLLocationManager locationServicesEnabled] ) {
            
            [Location defaultLacation].delegate = self;
            [[Location defaultLacation] selectLoaction];
            
            
        }
        
        for (ColumnModel *btnModel in self.visibleItemList) {
            if ([btnModel.tname isEqualToString:sender.titleLabel.text]) {
               
                model = btnModel;
            }
        }
        
        if (self.listBarItemClickBlock) {
            self.listBarItemClickBlock(model,[self findIndexOfListsWithTitle:sender.titleLabel.text]);
        }
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect btnBackViewRect = self.btnBackView.frame;
        
        btnBackViewRect.size.width = sender.frame.size.width+kExtraPadding;
        self.btnBackView.frame = btnBackViewRect;
        CGFloat changeW = sender.frame.origin.x-(btnBackViewRect.size.width-sender.frame.size.width)/2-10;
        /**
         *
         *  每次距离最初始的坐标点移动的距离，不论移动几次都是以最初的坐标为参考点
         *  @param changeW x轴每次移动的距离
         *  @param 0       y轴每次移动的距离
         *
         *  @return 移动的坐标
         */
        self.btnBackView.transform  = CGAffineTransformMakeTranslation(changeW, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint changePoint;
            
            
            //scrollView滑动的偏移量
            if (sender.frame.origin.x >= SCREEN_WIDTH - 150 && sender.frame.origin.x < self.contentSize.width-200){
                
                changePoint = CGPointMake(sender.frame.origin.x - 200, 0);
            }
            else if (sender.frame.origin.x >= self.contentSize.width-200 ){
                
                changePoint = CGPointMake(self.contentSize.width-350, 0);
            }
            else{
                changePoint = CGPointMake(0, 0);
            }
            self.contentOffset = changePoint;
        }];
    }];
}

//定位代理
-(void)locationCityName:(NSString *)cityName{
    
    ColumnModel *locModel = nil;
    
   // NSLog(@"cityName =======  %@",cityName);
    
    for (ColumnModel *model in _singleModel.columnArray) {
        if ([model.tname isEqualToString:@"本地"]) {
            if ([cityName hasSuffix:@"市"]) {
                
                model.tname = [cityName substringToIndex:2];
            }else{
                model.tname = cityName;
            }
            locModel = model;

        }
    }
    
    
    for ( UIView *view in self.subviews) {
        [view removeFromSuperview];
       
    }
    
    [_visibleItemList removeAllObjects];
    [_btnLists removeAllObjects];
    
    [self setVisibleItemList:_singleModel.columnArray];
    
    [self creatCacheFile];
   // NSLog(@"model.tname  %@",locModel.tname);
    
    UIButton *locButton = nil;
    for (NSObject *obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)obj;
            if (locModel.tname == button.titleLabel.text) {
                
                locButton = button;
            }
        }
    }
    
    [self changeBackView:locButton];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"location" object:nil userInfo:@{@"locModel":locModel}];

}


-(void)changeBackView:(UIButton *)sender{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect btnBackViewRect = self.btnBackView.frame;
        
        btnBackViewRect.size.width = sender.frame.size.width+kExtraPadding;
        self.btnBackView.frame = btnBackViewRect;
        CGFloat changeW = sender.frame.origin.x-(btnBackViewRect.size.width-sender.frame.size.width)/2-10;
        /**
         *
         *  每次距离最初始的坐标点移动的距离，不论移动几次都是以最初的坐标为参考点
         *  @param changeW x轴每次移动的距离
         *  @param 0       y轴每次移动的距离
         *
         *  @return 移动的坐标
         */
        self.btnBackView.transform  = CGAffineTransformMakeTranslation(changeW, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint changePoint;
            
            
            //scrollView滑动的偏移量
            if (sender.frame.origin.x >= SCREEN_WIDTH - 150 && sender.frame.origin.x < self.contentSize.width-200){
                
                changePoint = CGPointMake(sender.frame.origin.x - 200, 0);
            }
            else if (sender.frame.origin.x >= self.contentSize.width-200 ){
                
                changePoint = CGPointMake(self.contentSize.width-350, 0);
            }
            else{
                changePoint = CGPointMake(0, 0);
            }
            self.contentOffset = changePoint;
        }];
    }];
    
}

//创建栏目按钮本地缓存
-(void)creatCacheFile{
    
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [arr lastObject];
    
    NSString *sortFile = [path stringByAppendingString:@"/Caches/sort.plist"];
    [NSKeyedArchiver archiveRootObject:_singleModel.columnArray toFile:sortFile];
    
    NSString *listFile = [path stringByAppendingString:@"/Caches/list.plist"];
    [NSKeyedArchiver archiveRootObject:_singleModel.columnSortArry toFile:listFile];
}

//根据名字找到下标
-(NSInteger)findIndexOfListsWithTitle:(NSString *)title{
    
    for (int i =0; i < self.visibleItemList.count; i++) {
        
        if ([title isEqualToString:[self.visibleItemList[i] tname]]) {
            return i;
        }
    }
    return 0;
}

//随着collectionView的滑动改变选中的button
-(void)itemClickByScrollerWithIndex:(NSInteger)index{
    UIButton *item = (UIButton *)self.btnLists[index];
    [self itemClick:item];
}

//根据类型判断button的状态 按钮名字 下标执行对应的操作
-(void)operationFromBlock:(animateType)type columnModel:(ColumnModel *)columnModel index:(int)index{
    
    switch (type) {
            //点击按钮
        case topViewClick:
            //调用点击方法
            [self itemClick:self.btnLists[[self findIndexOfListsWithTitle:columnModel.tname]]];
            if (self.arrowChange) {
                self.arrowChange();
            }
            break;
            
        case FromTopToTop:
            [self switchPositionWithbuttonModel:columnModel index:index];
            break;
        case FromTopToTopLast:
            [self switchPositionWithbuttonModel:columnModel index:self.visibleItemList.count-1];
            break;
            //去下面移除button
        case FromTopToBottomHead:
            if ([self.btnSelect.titleLabel.text isEqualToString:columnModel.tname]) {
                [self itemClick:self.btnLists[0]];
            }
            [self removeItemWithbuttonModel:columnModel];
            [self resetFrame];
            break;
            //冲下面去上面
        case FromBottomToTopLast:
            [self.visibleItemList addObject:columnModel];
            [self makeItemWithTitle:columnModel.tname];
            break;
        default:
            break;
    }
}

//移除按钮
-(void)removeItemWithbuttonModel:(ColumnModel *)buttonModel{
    NSInteger index = [self findIndexOfListsWithTitle:buttonModel.tname];
    UIButton *select_button = self.btnLists[index];
    [self.btnLists[index] removeFromSuperview];
    [self.btnLists removeObject:select_button];
    [self.visibleItemList removeObject:buttonModel];
}


-(void)switchPositionWithbuttonModel:(ColumnModel *)columnModel index:(NSInteger)index{
    /**
     *  btnList 按钮数组
     */
    UIButton *button = self.btnLists[[self findIndexOfListsWithTitle:columnModel.tname]];
    [self.visibleItemList removeObject:columnModel];
    [self.btnLists removeObject:button];
    [self.visibleItemList insertObject:columnModel atIndex:index];
    [self.btnLists insertObject:button atIndex:index];
    [self itemClick:self.btnSelect];//点击
    [self resetFrame];//重置坐标
}

//重设button坐标
-(void)resetFrame{
    
    self.maxWidth = 20;
    for (int i = 0; i < self.visibleItemList.count; i++) {
        [UIView animateWithDuration:0.0001 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            CGFloat itemW = [self calculateSizeWithFont:itemFont Text:[self.visibleItemList[i] tname]].size.width;
            
            [[self.btnLists objectAtIndex:i] setFrame:CGRectMake(self.maxWidth, 0, itemW, self.frame.size.height)];
            
            self.maxWidth += kDistanceBetweenItem + itemW;
            
        } completion:^(BOOL finished){
        }];
    }
    self.contentSize = CGSizeMake(self.maxWidth, self.frame.size.height);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
