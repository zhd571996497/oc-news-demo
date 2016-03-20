//
//  HomeViewController.m
//  SouLuo1.0
//
//  Created by ls on 15/9/9.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "HomeViewController.h"
#import <CoreLocation/CoreLocation.h>//引入库
#import <MapKit/MapKit.h>
#import "CollectionViewAndScrollView.h"
#import "HomeCollectionViewHeadCell.h"
#import "DetailTextNewsViewController.h"
#import "DetailPhotoNewsViewController.h"
#import "AFN.h"
#import "ColumnModel.h"
#import "ColumnArraySingModel.h"
#import "Location.h"

#import "AppDelegate.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,HomeCollectionViewHeadDelegate>


@property(nonatomic , strong)CollectionViewAndScrollView *collectionViewAndScrollview;

@property(nonatomic , strong)NSMutableArray *columnArray;

@property(nonatomic , strong)NSMutableArray *listArray;

@property(nonatomic , strong)NSMutableArray *sortArray;

@property(nonatomic , strong)ColumnArraySingModel *singleModel;

@property(nonatomic , strong)Location *location;
//定位的城市名
@property(nonatomic , copy)NSString *cityName;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新闻";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.columnArray = [[NSMutableArray alloc]init];
    self.listArray = [[NSMutableArray alloc]init];
    self.sortArray = [[NSMutableArray alloc]init];
    self.singleModel =  [ColumnArraySingModel defaultColumnArraySingleModel];
    [self LoadColumnData];
    
    self.location = [Location defaultLacation];
    //[self.location setDelegate:self];
    [self.location selectLoaction];
    
    /**
     * 抽屉按钮
     */
    UIBarButtonItem * leftSliderBar = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"抽屉.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(leftSliderClick)];
    self.navigationItem.leftBarButtonItem = leftSliderBar;
}

#pragma mark- 点击打开抽屉
/**
 *  点击打开抽屉
 */
-(void)leftSliderClick
{
    // 通过app 回到主Window用来显示抽屉的VC
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // 由关闭状态打开抽屉
    if (appDelegate.leftSlideVC.closed)
    {
        [appDelegate.leftSlideVC openLeftView];
    }
    //关闭抽屉
    else
    {
        [appDelegate.leftSlideVC closeLeftView];
    }
}

-(void)creatCollectionViewAndScrollview{
    
    self.collectionViewAndScrollview = [[CollectionViewAndScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 113) sortArray:self.sortArray listArray:self.listArray];
    
    [_collectionViewAndScrollview.contentCollectView setDataSource:self];
    [_collectionViewAndScrollview.contentCollectView setDelegate:self];
   
        
        [_collectionViewAndScrollview.contentCollectView registerClass:[HomeCollectionViewHeadCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    [self.view addSubview:_collectionViewAndScrollview];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _singleModel.columnArray.count;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColumnModel *columnModel = _singleModel.columnArray[indexPath.row];
    HomeCollectionViewHeadCell *cell = [ collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.columnModel = columnModel;
    return cell;
    
}

-(void)pushDetailTextNewsController:(DetailTextNewsViewController *)newsController{
    
    [self.navigationController pushViewController:newsController animated:nil];
}

-(void)pushdetailPhotoNewsController:(DetailPhotoNewsViewController *)photoNewsController
{
    [photoNewsController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:photoNewsController animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    
    NSInteger index = _collectionViewAndScrollview.contentCollectView.contentOffset.x/self.view.frame.size.width;
    [self.collectionViewAndScrollview.listBar itemClickByScrollerWithIndex:index];
}


-(void)LoadColumnData{
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"listArray"]) {
        
        [self readCacheFile];
        [self creatCollectionViewAndScrollview];
        
    }else{

    NSString *urlString = @"http://c.m.163.com/nc/topicset/ios/subscribe/manage/listspecial.html";
    [AFN urlString:urlString getAFNdata:^(id responseObject) {
        NSArray *tList = [responseObject objectForKey:@"tList"];
        for (NSDictionary *dic in tList) {
           
            ColumnModel *model =[[ColumnModel alloc]initWithDic:dic];
            
            if ([model.tname isEqualToString:@"本地"]) {
                
                    
                    model.isLocation = YES;
                    
            }else{
                model.isLocation = NO;
            }
            if ( YES == model.headLine) {
                [self.columnArray insertObject:model atIndex:0];
            }else if ([model.tname isEqualToString:@"本地"]){
                [self.columnArray insertObject:model atIndex:1];
            }
            else{
                
                [self.columnArray addObject:model];
            }
        }
     
        for (int i = 0 ; i < self.columnArray.count; i ++) {
            if (i < self.columnArray.count/2) {
                [self.sortArray addObject:[self.columnArray objectAtIndex:i]];
                [_singleModel.columnArray addObject:self.columnArray[i]];
            }else{
                
                [self.listArray addObject:[self.columnArray objectAtIndex:i]];
                [_singleModel.columnSortArry addObject:[self.columnArray objectAtIndex:i]];
            }
        }
        
        
        
        if (self.listArray.count > 0) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"listArray"];
            [self creatCacheFile];
        }
        
     //排序
//        NSSortDescriptor *cidDesc = [NSSortDescriptor sortDescriptorWithKey:@"topicid" ascending:NO];
//        NSArray *descs = [NSArray arrayWithObjects:cidDesc, nil];
//        NSArray *array2 = [_columnArray sortedArrayUsingDescriptors:descs];
//        
//        for (ColumnModel *model in array2) {
//            NSLog(@"tname = %@  , topicid = %@", model.tname, model.topicid);
//        }
        [self creatCollectionViewAndScrollview];
        [self.location selectLoaction];
        
    }];
    
    }

    
}

//创建栏目按钮本地缓存
-(void)creatCacheFile{
    
    
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [arr lastObject];
   
    NSString *sortFile = [path stringByAppendingString:@"/Caches/sort.plist"];
    [NSKeyedArchiver archiveRootObject:_sortArray toFile:sortFile];
    
    NSString *listFile = [path stringByAppendingString:@"/Caches/list.plist"];
    [NSKeyedArchiver archiveRootObject:_listArray toFile:listFile];
}
//读取缓存
-(void)readCacheFile{
    
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [arr lastObject];
    
    NSString *sortFile = [path stringByAppendingString:@"/Caches/sort.plist"];
    NSArray *arr1 = [NSKeyedUnarchiver unarchiveObjectWithFile:sortFile];
    [self.sortArray addObjectsFromArray:arr1];
    
    [_singleModel.columnArray addObjectsFromArray:arr1];
       
    NSString *listFile = [path stringByAppendingString:@"/Caches/list.plist"];
    NSArray *arr2 = [NSKeyedUnarchiver unarchiveObjectWithFile:listFile];
    [self.listArray addObjectsFromArray:arr2];
    [_singleModel.columnSortArry addObjectsFromArray:arr2];
    
}

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
