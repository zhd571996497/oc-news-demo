//
//  ReadViewController.m
//  SouLuo1.0
//
//  Created by ls on 15/9/9.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "ReadViewController.h"
#import "ReadView.h"
#import "CollectView.h"
#import "BaseModel.h"
#import "CellForImageToLeft.h"
#import "CellForImageToFull.h"
#import "ReadCellFactory.h"
#import "DetailViewController.h"
#import "CellForReadCollect.h"
#import "ReadDetailModel.h"
#import "ReadDataBase.h"

@interface ReadViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic, strong)UISegmentedControl * segment;
@property(nonatomic, strong)ReadView * myReadView;
@property(nonatomic, strong)CollectView * myCollectView;
@property(nonatomic, strong)NSMutableArray * collectArray;
@property(nonatomic, strong)UILabel * emptyLabel;

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = MYCOLOR_GRB(234, 234, 234, 1);
    
    self.segment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"推荐阅读", @"我的收藏", nil]];
    [self.segment setFrame:CGRectMake((SCREEN_WIDTH - 160)/2, 6, 160, 30)];
    self.segment.backgroundColor = MYCOLOR_GRB(69, 162, 215, 1);
    [self.segment setTintColor:[UIColor whiteColor]];
    [self.segment setSelectedSegmentIndex:0];
    self.segment.layer.cornerRadius = 5;
    [self.segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:self.segment];
//   推荐阅读View
    self.myReadView = [[ReadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.myReadView.tableView.delegate = self;
    self.myReadView.tableView.dataSource = self;
    [self.view addSubview:self.myReadView];
//   我的收藏View
    self.myCollectView = [[CollectView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113)];
    self.myCollectView.backgroundColor = [UIColor cyanColor];
    self.myCollectView.collectionView.delegate = self;
    self.myCollectView.collectionView.dataSource = self;
    [self.myCollectView.collectionView registerClass:[CellForReadCollect class] forCellWithReuseIdentifier:@"reuseId"];
    
    _emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250 * RATIO_WIDTH, 40)];
    [_emptyLabel setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    [_emptyLabel setText:@"还没有收藏任何东西呦"];
    [_emptyLabel setTextAlignment:NSTextAlignmentCenter];
    [_emptyLabel setNumberOfLines:0];
    [_emptyLabel setFont:[UIFont boldSystemFontOfSize:18]];
    
}
#pragma mark- 视图即将出现
-(void)viewWillAppear:(BOOL)animated
{
    [self.segment setHidden:NO];
    self.collectArray = [NSMutableArray array];
    [[ReadDataBase shareDataBaseHandle]openDB];
    _collectArray = [[ReadDataBase shareDataBaseHandle]selectReadDetailSelectInfo];
    [_myCollectView.collectionView reloadData];
   
    if (0 == _collectArray.count) {
        if (1 == _segment.selectedSegmentIndex) {
            
            [self.view addSubview:_emptyLabel];
        }
    } else {
        [_emptyLabel removeFromSuperview];
    }

}
#pragma mark- segment点击方法
-(void)segmentChange:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0) {
        [self.view addSubview:self.myReadView];
        [_emptyLabel removeFromSuperview];
        [self.myCollectView removeFromSuperview];
    } else {
        [self.myReadView removeFromSuperview];
        [self.view addSubview:self.myCollectView];
        if (0 == _collectArray.count) {
    
            [self.view addSubview:_emptyLabel];
        }
    }
}
#pragma mark- UITableViewDelegate、UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myReadView.modelArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //利用cell工厂返回对应的cell高度
    if (indexPath.row < _myReadView.modelArray.count) {
        BaseModel * model = [self.myReadView.modelArray objectAtIndex:indexPath.row];
        return [ReadCellFactory heightForBaseModel:model];
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //利用cell工厂返回对应的cell
    if (indexPath.row < _myReadView.modelArray.count) {
        BaseModel * model = [_myReadView.modelArray objectAtIndex:indexPath.row];
        BaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([model class])];
        if (nil == cell) {
            cell = [ReadCellFactory cellForBaseModel:model];
        }
        [cell setBaseModel:model];
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * detail = [[DetailViewController alloc]init];
    if (indexPath.row < _myReadView.modelArray.count) {
        //将基类Model传过去，在下一个controller里面判断点击的是哪个Model
        BaseModel * model = [_myReadView.modelArray objectAtIndex:indexPath.row];
        [detail setModel:model];
    }
    [self.navigationController pushViewController:detail animated:YES];
    [self.segment setHidden:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

#pragma mark- UICollectionDelegate、DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collectArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellForReadCollect * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseId" forIndexPath:indexPath];
    if (indexPath.row < _collectArray.count) {
        ReadDetailModel * model = [_collectArray objectAtIndex:indexPath.row];
        [cell getInfoForTitle:model.title Img:model.src];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * detail = [[DetailViewController alloc]init];
    if (indexPath.row < _collectArray.count) {
        ReadDetailModel * model = [_collectArray objectAtIndex:indexPath.row];
        [detail setDocid:model.docid];
    }
    [self.navigationController pushViewController:detail animated:YES];
    [self.segment setHidden:YES];
}

#pragma mark-
-(void)viewWillDisappear:(BOOL)animated
{
    [[ReadDataBase shareDataBaseHandle]closeDB];
}
#pragma mark-
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
