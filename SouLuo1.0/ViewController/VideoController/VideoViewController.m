//  VideoViewController.m
//  SouLuo1.0
//
//
//  Created by ls on 15/9/9.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoView.h"
#import "AFN.h"
#import "MJRefresh.h"
#import "VideoModel.h"
#import "AVPlayerViewController.h"
#import "VideocollectionViewCell.h"
#import "MoviePlayerViewController.h"
#import "AudioViewController.h"
#import "AudiocListModel.h"
#import "AudiotListModel.h"
#import "AudioCollectionViewCell.h"
#import "AudioClassifyViewController.h"
#import "MBProgressHUD.h"
#import "PlayInterfaceViewController.h"

@interface VideoViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

@property(nonatomic,strong)UICollectionView *collection;
@property(nonatomic,strong)UICollectionViewFlowLayout *flow;

@property(nonatomic,strong)UISegmentedControl *segment;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)VideoView *videoview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSMutableArray *cListArray;
@property(nonatomic,strong)MBProgressHUD *HUD;

@end

@implementation VideoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.segment setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.segment setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _count = 0;
    
    self.dataArray = [[NSMutableArray alloc]init];
    self.cListArray = [[NSMutableArray alloc]init];
    
    self.segment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"视频", @"电台", nil]];
[self.segment setFrame:CGRectMake((SCREEN_WIDTH - 160)/2, 6, 160, 30)];
    self.segment.backgroundColor = MYCOLOR_GRB(69, 162, 215, 1);
    [self.segment setTintColor:[UIColor whiteColor]];
    [self.segment setSelectedSegmentIndex:0];
    self.segment.layer.cornerRadius = 5;
    [self.segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:self.segment];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH * 2, 0)];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setDelegate:self];
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    
   
    
    [self addView];
    [self loadTwo];

    [self didload];
    [self load];
}

-(void)segmentChange:(UISegmentedControl *)sender
{
    NSInteger index = _segment.selectedSegmentIndex;
    switch (index) {
            case 0:
            self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * 0, 0);
            break;
            case 1:
            self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * 1, 0);
        default:
            break;
    }
}

#pragma mark- scrollView delegate
//滚动就会触发方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        
        NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
        
        switch (index) {
            case 0:
                self.segment.selectedSegmentIndex = 0;
                break;
                
            case 1:
                self.segment.selectedSegmentIndex = 1;
                break;
            default:
                break;
        }
    }

}

//电台
-(void)loadTwo
{    
    self.flow = [[UICollectionViewFlowLayout alloc]init];
    //    设置item大小，每个小模块的大小
    [self.flow setItemSize:CGSizeMake(RATIO_WIDTH*355,RATIO_HEIGHT*300)];
    //    设置行间距
    _flow.minimumLineSpacing = 10;
    
    //    设置列间距
    _flow.minimumInteritemSpacing = 0;
    
    //    设置item上下左右间距  1:距离navigation的距离 2：距离左侧的距离 3：距离下端距离  4：距离右侧的距离
    //    设置item上下左右间距
    [self.flow setSectionInset:UIEdgeInsetsMake(RATIO_WIDTH*10,RATIO_WIDTH*10, RATIO_WIDTH*10, RATIO_WIDTH*10)];
    
    //    //    集合视图
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) collectionViewLayout:self.flow];
//    [self.collection setBackgroundColor:[UIColor lightGrayColor]];
    self.collection.backgroundColor = MYCOLOR_GRB(234, 234, 234, 1);
    //隐藏滑轮
    //    self.collection.showsVerticalScrollIndicator = NO;
    [self.collection setDataSource:self];
    [self.collection setDelegate:self];
    [_scrollView addSubview:self.collection];
    //    注册cell
    [self.collection registerClass:[AudioCollectionViewCell class] forCellWithReuseIdentifier:@"reuseId"];

}

//视频
-(void)addView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    设置item大小，每个小模块的大小
    [self.flowLayout setItemSize:CGSizeMake(RATIO_WIDTH*355,RATIO_HEIGHT*300)];
    //    设置行间距
    _flowLayout.minimumLineSpacing = 10;
    
    //    设置列间距
    _flowLayout.minimumInteritemSpacing = 0;
    
    //    设置item上下左右间距  1:距离navigation的距离 2：距离左侧的距离 3：距离下端距离  4：距离右侧的距离
    //    设置item上下左右间距
    [self.flowLayout setSectionInset:UIEdgeInsetsMake(RATIO_WIDTH*10,RATIO_WIDTH*10,RATIO_WIDTH*10,RATIO_WIDTH*10)];
    
    //    //    集合视图
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) collectionViewLayout:self.flowLayout];
    [self.collectionView setBackgroundColor:MYCOLOR_GRB(234, 234, 234, 1)];
    //隐藏滑轮
//    self.collectionView.showsVerticalScrollIndicator = NO;
        [self.collectionView setDataSource:self];
       [self.collectionView setDelegate:self];
    [_scrollView addSubview:self.collectionView];
    //    注册cell
    [self.collectionView registerClass:[VideocollectionViewCell class] forCellWithReuseIdentifier:@"reuseId"];
    //菊花效果
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.removeFromSuperViewOnHide = YES;
//    self.HUD.labelText = @"loading";
//    self.HUD.color = [UIColor lightGrayColor];
    [_scrollView addSubview:self.HUD];
    self.HUD.mode = MBProgressHUDModeIndeterminate;

    
    [self.collectionView addHeaderWithTarget:self action:@selector(didload)];
//    防止循环引用
    __block typeof (self) unself = self;
    [self.collectionView addFooterWithCallback:^{
    [unself didload];
}];
}
#pragma mark- collection video Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _collection) {
        return _cListArray.count;
    }else{
    return _dataArray.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _collection) {
         AudioCollectionViewCell*ce = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseId" forIndexPath:indexPath];
        ce.backgroundColor= [UIColor whiteColor];
        AudiocListModel *model = [_cListArray objectAtIndex:indexPath.row];
        [ce.buttonOne addTarget:self action:@selector(buttonOneAudio:) forControlEvents:UIControlEventTouchUpInside];
        [ce.buttonTwo addTarget:self action:@selector(buttonTwoAudio:) forControlEvents:UIControlEventTouchUpInside];
        [ce.buttonThree addTarget:self action:@selector(buttonThreeAudio:) forControlEvents:UIControlEventTouchUpInside];
        [ce Info:model];
        return ce;
    }else{
        
    //    直接从重用池取cell，reuseIdentifieruiding要和注册时一致
    VideocollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseId" forIndexPath:indexPath];
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    VideoModel *model = [_dataArray objectAtIndex:indexPath.row];
    [cell getWithModel:model];
        
    return cell;
    }
}

-(void)buttonOneAudio:(UIButton *)button
{
    UICollectionViewCell *cell =(UICollectionViewCell *) [[button superview] superview ];
    NSIndexPath *indexPath = [_collection indexPathForCell:cell ];
    
    PlayInterfaceViewController *play = [[PlayInterfaceViewController alloc]init];
    
    play.model = [[_cListArray objectAtIndex:indexPath.row] tlist][0];
    
     [self.navigationController pushViewController:play animated:YES];
}

-(void)buttonTwoAudio:(UIButton *)button
{
    UICollectionViewCell *cell =(UICollectionViewCell *) [[button superview] superview ];
    NSIndexPath *indexPath = [_collection indexPathForCell:cell ];
    
    PlayInterfaceViewController *play = [[PlayInterfaceViewController alloc]init];
    
    play.model = [[_cListArray objectAtIndex:indexPath.row] tlist][1];
    
    [self.navigationController pushViewController:play animated:YES];

}

-(void)buttonThreeAudio:(UIButton *)button
{
    UICollectionViewCell *cell =(UICollectionViewCell *) [[button superview] superview ];
    NSIndexPath *indexPath = [_collection indexPathForCell:cell ];
    
    PlayInterfaceViewController *play = [[PlayInterfaceViewController alloc]init];
    
    play.model = [[_cListArray objectAtIndex:indexPath.row] tlist][2];
    
    [self.navigationController pushViewController:play animated:YES];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _collectionView) {
        
    VideoModel *model = _dataArray [indexPath.row];
    NSURL *url = [NSURL URLWithString:model.mp4_url];
    MoviePlayerViewController *av = [[MoviePlayerViewController alloc]initNetMovieWithURL:url];
        [self presentViewController:av animated:YES completion:nil];
    }else
    {
        AudioClassifyViewController *audio = [[AudioClassifyViewController alloc]init];
        AudiocListModel *model = _cListArray [indexPath.row];
        audio.cuid = model.cid;
        [_segment setHidden:YES];
        [self.navigationController pushViewController:audio animated:YES];
    }
}
//
-(void)load
{
    NSString *string = @"http://c.m.163.com/nc/topicset/ios/radio/index.html";
    [AFN urlString:string getAFNdata:^(id responseObject) {
       
        NSMutableArray *arr = [responseObject objectForKey:@"cList"];
        
        for (NSDictionary *dic in arr) {
           
            AudiocListModel *mo = [[AudiocListModel alloc]init];
            mo.cname = [dic objectForKey:@"cname"];
            mo.cid = [dic objectForKey:@"cid"];
            
            NSArray *array = [dic objectForKey:@"tList"];

            for (NSDictionary *Dic in array) {
                
                AudiotListModel *model = [[AudiotListModel alloc]init];
                model.tid = [Dic objectForKey:@"tid"];
                NSDictionary * radio = Dic[@"radio"];
                
                model.imgsrc = [radio objectForKey:@"imgsrc"];
                model.url = [radio objectForKey:@"url"];
                model.title = [radio objectForKey:@"title"];
                model.tname = [radio objectForKey:@"tname"];
                [mo.tlist addObject:model];
            }
            
            [self.cListArray addObject:mo];
        }
        [self.collection reloadData];
        
    }];
}

-(void)didload
{
    NSString *string = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/list/V9LG4B3A0/y/%ld-10.html",_count];
    _count += 10;
    [AFN urlString:string getAFNdata:^(id responseObject) {
        
        
        NSMutableArray *arr = [responseObject objectForKey:@"V9LG4B3A0"];
        for (NSDictionary *dic in arr) {
            VideoModel *model = [[VideoModel alloc]init];
            model.title = [dic objectForKey:@"title"];
            model.cover = [dic objectForKey:@"cover"];
            model.descriptionPro = [dic objectForKey:@"description"];
            model.mp4_url = [dic objectForKey:@"mp4_url"];
            model.ptime = [dic objectForKey:@"ptime"];
            [_dataArray addObject:model];
            
        }
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
        [self.HUD setHidden:YES];

        [self.collectionView reloadData];
    }];
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
