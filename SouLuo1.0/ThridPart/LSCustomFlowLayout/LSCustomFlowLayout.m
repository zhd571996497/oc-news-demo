//
//  LSCustomFlowLayout.m
//  众享
//
//  Created by ls on 15/8/27.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import "LSCustomFlowLayout.h"

@interface LSCustomFlowLayout ()
//最大列高
@property(nonatomic , assign)CGFloat maxLength;
//存储item布局属性的数组
@property(nonatomic , retain)NSMutableArray * receiveArray;

@end

@implementation LSCustomFlowLayout


-(id)init
{
    self = [super init];
    if (self) {
        
        self.receiveArray = [[NSMutableArray alloc]init];
        
        
    }
    return self;
}

/**  自动调用 第一个调用
 初始化一个UICollectionViewLayout 实例后，自动被调用，以保证layout实例正确
 *   首先，-(void)prepareLayout将被调用，默认下该方法什么没做，但是在自己的子类实现中，一般在该方法中设定一些必要的layout的结构和初始需要的参数等。
 */
-(void)prepareLayout
{
    [super prepareLayout];
    
    // collectionView刷新后将就得属性清空
    [_receiveArray removeAllObjects];
    
    [self calueLatorHeight];
}

//重新设置layout 添加到receiveArray数组里 并计算高度
-(void)calueLatorHeight
{
    
#pragma mark- supplentaryView
    
    UICollectionViewLayoutAttributes * headerAttributes = nil;
    /*
     self.delegate respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]
     判断某方法是否被响应
     */
    if ([self.delegate respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)])
    { // 判断是否存在
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        
        headerAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        
    }
    
    
#pragma mark - mark- supplentaryVIew
    
    
#pragma mark - cell
    
    //section 等于 0时 item的个数
    NSInteger num =[self.collectionView numberOfItemsInSection:0];
    
    //左右的列高
    CGFloat offLeft = headerAttributes.size.height;
    
    CGFloat offRight = headerAttributes.size.height;
    
    //每个section的边界大小
    UIEdgeInsets edge =  [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
    
    //行间距
    CGFloat line = [self.delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:0];
    
    //列间距
    CGFloat list =[self.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:0];
    
    
    
    for (int i = 0; i < num ; i ++) {
        
        NSIndexPath * index =[NSIndexPath indexPathForItem:i inSection:0];
        
        //返回每个item的属性
        UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
        
        
        //item 的大小
        CGSize size =  [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:index];
        
        if (size.width > (self.collectionView.frame.size.width - edge.left - edge.right - list)/2) {
            
            //            attributes.center = CGPointMake(self.collectionView.frame.size.width / 2, offLeft + line + attributes.size.height/2);
            
            attributes.frame = CGRectMake(edge.left, offLeft + line, size.width, size.height);
            
            offLeft  += size.height + line;
            
        }else {
            
            //将item放置在 列 的 高度 最小 的 那列
            if (offLeft <= offRight) {
                //左侧
                attributes.frame = CGRectMake(edge.left, offLeft + line, size.width, size.height);
                
                offLeft += size.height + line;
                
            }else{
                //右侧
                attributes.frame = CGRectMake(size.width + list + edge .left,offRight + line, size.width, size.height);
                
                offRight += size.height + line;
            }
            
        }
        
        [self.receiveArray addObject:attributes];
        
        
    }
    
#pragma mark - mark - cell
    
    //根据item的 下标放置 item所在的列
    //        if ( i % 2 == 0) {
    //            //设置第一列 item 的 frame
    //            attributes.frame = CGRectMake(10, 0 + offLeft, RealWidth , realHeight)
    //            ;
    //            //左侧 列 的总高度
    //            offLeft += realHeight;
    //        }else{
    //            attributes.frame = CGRectMake(RealWidth + 20, offRight, RealWidth, realHeight);
    //            offRight += realHeight;
    //        }
    //
    
    
    
    //计算collectionView的总高度
    if (offRight > offLeft) {
        self.maxLength = offRight + edge.bottom;
    }else{
        self.maxLength = offLeft + edge.bottom;
    }
    
}


/**
 
 
 返回rect中的所有的元素的布局属性
 返回的是包含UICollectionViewLayoutAttributes的NSArray
 
 UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
 layoutAttributesForCellWithIndexPath:
 layoutAttributesForSupplementaryViewOfKind:withIndexPath:
 layoutAttributesForDecorationViewOfKind:withIndexPath:
 
 */
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSMutableArray * currentArray = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes * att in self.receiveArray) {
        
        //判断att的rect 是否在 参数rect里
        if (CGRectIntersectsRect(att.frame, rect) || CGRectContainsRect(att.frame, rect)) {
            
            //返回rect中的所有的元素的布局元素
            [currentArray addObject:att];
        }
    }
    
    
    
    if ([self.delegate respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)])
    { // 判断是否存在
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        
        UICollectionViewLayoutAttributes *  attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        [currentArray addObject:attributes];
    }
    
    
    
    
    return currentArray;
}


//返回 supplenentaryView的属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    if([elementKind isEqual:UICollectionElementKindSectionHeader])
    {
        attributes.size = [self.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:0];
        
        attributes.center = CGPointMake(self.collectionView.frame.size.width/2, attributes.size.height/2);
    }else{
        attributes.size = CGSizeMake(0, 0);
        attributes.center = CGPointMake(0, 0);
    }
    
    return attributes;
}





//返回对应于 indexPath 的位置的cell 的布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_receiveArray objectAtIndex:indexPath.item];
}


//返回collectionView的内容的尺寸
-(CGSize)collectionViewContentSize
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, _maxLength);
}




@end
