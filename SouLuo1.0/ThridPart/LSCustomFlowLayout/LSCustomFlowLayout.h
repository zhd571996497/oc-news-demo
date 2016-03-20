//
//  LSCustomFlowLayout.h
//  众享
//
//  Created by ls on 15/8/27.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FlowLayoutDelegate <UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@required

//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

//边界大小
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

//列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

//行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;


@optional

//supplementaryView headerView大小

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

-(UICollectionReusableView * )collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

@end

@interface LSCustomFlowLayout : UICollectionViewFlowLayout

@property(nonatomic , retain)id<FlowLayoutDelegate>delegate;

@end
