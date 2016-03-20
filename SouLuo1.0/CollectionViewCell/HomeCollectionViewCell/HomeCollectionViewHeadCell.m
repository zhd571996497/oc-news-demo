//
//  HomeCollectionViewCell.m
//  SouLuo1.0
//
//  Created by ls on 15/9/17.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "HomeCollectionViewHeadCell.h"
#import "DetailTextNewsViewController.h"
#import "DetailPhotoNewsViewController.h"
#import "BaseTableViewCell.h"
#import "MJRefresh.h"
#import "ColumnModel.h"
#import "CellFactory.h"
#import "HeadCycleModel.h"
#import "SDCycleScrollView.h"
#import "NewsModel.h"
#import "PhotosetModel.h"
#import "Height.h"
#import "AFN.h"
@interface HomeCollectionViewHeadCell ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic , strong)UITableView *tableView;
//轮播图model类数组
@property (nonatomic , strong)NSMutableArray *cycleArray;
//头条新闻数组
@property (nonatomic , strong)NSMutableArray *headArray;
//轮播图图片数组
@property (nonatomic , strong)NSMutableArray *cycleImgArray;
//轮播图标题数组
@property (nonatomic , strong)NSMutableArray *cycleTitleArray;
//轮播图
@property (nonatomic , strong)SDCycleScrollView *cycleScrollView;
@end

@implementation HomeCollectionViewHeadCell

-(instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = frame.size.width;
        
        CGFloat height = frame.size.height;
        
        self.cycleArray = [[NSMutableArray alloc] init];
        self.headArray = [[NSMutableArray alloc]init];
        self.cycleImgArray = [[NSMutableArray alloc]init];
        self.cycleTitleArray = [[NSMutableArray alloc]init];
    
        //轮播图设置
        self.cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        //占位图
        _cycleScrollView.placeholderImage = [UIImage imageNamed:@"占350-170"];
        //轮播时间间隙
        _cycleScrollView.autoScrollTimeInterval = 3;
        //是否自动滚动
        _cycleScrollView.autoScroll = YES;
        _cycleScrollView.delegate = self;
        
       
        //样式
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        //分页控件位置
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        //大小
        _cycleScrollView.pageControlDotSize = CGSizeMake(10, 10);
//        //颜色
//        _cycleScrollView.dotColor = [UIColor redColor];
        
       
        
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = _cycleScrollView;
        [self.contentView addSubview:_tableView];
        
          }
    
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _headArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseModel *baseModel = nil;
    if (_headArray.count > indexPath.row) {
      
        baseModel = _headArray[indexPath.row];
        
    }
   
    if ([baseModel isKindOfClass:[NewsModel class]]) {
        return 100;
    }else if ([baseModel isKindOfClass:[PhotosetModel class]]) {
        return 125;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseModel *baseModel  = nil;
    BaseTableViewCell *cell  = nil;
    if (_headArray.count > indexPath.row) {
        
     baseModel = _headArray[indexPath.row];
  
      cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([baseModel class]) ];
    
    if (nil == cell) {
        cell = [CellFactory cellForModel:baseModel];
    }
    
    cell.baseModel = baseModel;
      }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BaseModel *baseModel = _headArray[indexPath.row];
    //判断push到那个页面
    if ([baseModel isKindOfClass:[NewsModel class]]) {
        NewsModel *newsModel = (NewsModel *)baseModel;
        DetailTextNewsViewController *textNews = [[DetailTextNewsViewController alloc]init];
        textNews.docid = newsModel.docid;
        
        if ([self.delegate respondsToSelector:@selector(pushDetailTextNewsController:)]) {
            
            [self.delegate pushDetailTextNewsController:textNews];
        }
        
    }else{
        
        PhotosetModel *photosetModel = (PhotosetModel *)baseModel;
        
        DetailPhotoNewsViewController *detailPhotoVC = [[DetailPhotoNewsViewController alloc]init];
        detailPhotoVC.urlString = photosetModel.skipID;
        if ([self.delegate respondsToSelector:@selector(pushdetailPhotoNewsController:)]) {
            
            [self.delegate pushdetailPhotoNewsController:detailPhotoVC];
        }
        
    }

    
}
//轮播图代理
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    DetailPhotoNewsViewController *photoNewsView = [[DetailPhotoNewsViewController alloc]init];
    
    HeadCycleModel *cycleModel = _cycleArray[index];
    
    if (cycleModel.url != NULL) {
        
        photoNewsView.urlString = cycleModel.url;
    }else{
       
        photoNewsView.urlString = cycleModel.skipID;
    }
    
    if ([self.delegate respondsToSelector:@selector(pushdetailPhotoNewsController:)]) {
        
        [self.delegate pushdetailPhotoNewsController:photoNewsView];
    }
    
}



-(void)setColumnModel:(ColumnModel *)columnModel{
    _columnModel = columnModel;
   // NSLog(@"cityName = %@ isLocation = %d tid = %@", columnModel.tname,columnModel.isLocation, columnModel.tid);
 
    __weak typeof(self) uself = self;
    __weak typeof (_columnModel) colModel = _columnModel;
    __weak typeof (_cycleArray) cycleArray = _cycleArray;
    __weak typeof(_headArray) headArray = _headArray;
    __weak typeof(_cycleImgArray) cycleImgArray = _cycleImgArray;
    __weak typeof(_cycleTitleArray) cycleTitleArray = cycleArray;
    __weak typeof(_tableView) tableView = _tableView;
    
    [_tableView addHeaderWithCallback:^{
        
        [cycleImgArray removeAllObjects];
        [cycleTitleArray removeAllObjects];
        [cycleArray removeAllObjects];
        [headArray removeAllObjects];
        [tableView reloadData];
        if ([colModel.tname isEqualToString:@"头条"]) {
            
            [uself loadDataWithHead];
            
        }else if (colModel.isLocation){
            
            [uself loadDateWithLocation];
        }else{
            [uself loadDataWithTid:colModel.tid];
        }
        
    }];
    
    [_tableView addFooterWithCallback:^{
        
    }];
    

    [_cycleArray removeAllObjects];
    [_headArray removeAllObjects];
    [_cycleImgArray removeAllObjects];
    [_cycleTitleArray removeAllObjects];
    
        if ([columnModel.tname isEqualToString:@"头条"]) {
            
            [self loadDataWithHead];
        }else if (columnModel.isLocation){
            if ([columnModel.tname isEqualToString:@"本地"]) {
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationLoad:) name:@"location" object:nil];
            }
            
            [self loadDateWithLocation];
            
        }
        else{
            
            
            [self loadDataWithTid:columnModel.tid];
        }
    
}

-(void)locationLoad:(NSNotification *)notification;{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _columnModel = notification.userInfo[@"locModel"];
    
    [self loadDateWithLocation];
}
-(void)loadDataWithTid:(NSString *)tid{
    
    NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/%@/0-20.html",tid];
    
    [AFN urlString:url getAFNdata:^(id responseObject) {
       
        NSArray *dataArray = responseObject[tid];
        
        for (NSDictionary *dic in dataArray) {
            if (dataArray[0] == dic) {
                //轮播图
                HeadCycleModel *cycleModel = [[HeadCycleModel alloc]initWithDic:dic];
                [_cycleImgArray addObject:cycleModel.imgsrc];
                [_cycleTitleArray addObject:cycleModel.title];
                [_cycleArray addObject:cycleModel];
            
                //判断是否有第二个或更多个轮播图
                if ( dic  && [[dic objectForKey:@"ads"] count] > 0 ) {
                    
                    NSArray *ads = dic[@"ads"];
                    if ([[dic allKeys] containsObject:@"ads"] && ads.count > 0) {
                        for (NSDictionary * cycleDic in ads) {
                            
                            HeadCycleModel *cycleModel1 = [[HeadCycleModel alloc]initWithDic:cycleDic];
                            [_cycleTitleArray addObject:cycleModel1.title];
                            [_cycleImgArray addObject:cycleModel1.imgsrc];
                            [_cycleArray addObject:cycleModel1];
                        }
                    }
                }
            }else{
                
                //图片新闻
                if ([[dic allKeys] containsObject:@"skipType"] && [dic[@"skipType"] isEqualToString:@"photoset"]) {
                    
                    PhotosetModel *photosetModel = [[PhotosetModel alloc]initWithDic:dic];
                    // photosetModel.imgextra = dic[@"imgextra"];
                    [_headArray addObject:photosetModel];
                    
                }else{
                    //文字类新闻
                    NewsModel *newsModel = [[NewsModel alloc]initWithDic:dic];
                    newsModel.digestHeight = [Height heightForText:newsModel.digest width:(SCREEN_WIDTH - 130) fontSize:12];
                    [_headArray addObject:newsModel];
                }
                
            }
            
        }
        
        _cycleScrollView.imageURLStringsGroup = _cycleImgArray;
        _cycleScrollView.titlesGroup = _cycleTitleArray;
        if (_cycleArray.count < 2) {
            //是否自动滚动
            _cycleScrollView.autoScroll = NO;
            //是否无限循环
            _cycleScrollView.infiniteLoop = NO;
            _cycleScrollView.showPageControl = NO;

        }else{
            //是否自动滚动
            _cycleScrollView.autoScroll = YES;
            //是否显示分页控件
            _cycleScrollView.showPageControl = YES;
            _cycleScrollView.infiniteLoop = YES;

        }
        
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [_tableView reloadData];
    }];
    
    
}

-(void)loadDateWithLocation{
    
    NSData *strDtata = [_columnModel.tname dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [strDtata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSString *cityName = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/local/%@/0-20.html",cityName];
    [AFN urlString:urlStr getAFNdata:^(id responseObject) {
        
        NSArray *dataArray = responseObject[_columnModel.tname];
        
        for (NSDictionary *dic in dataArray) {
            if (dataArray[0] == dic) {
                //轮播图
                HeadCycleModel *cycleModel = [[HeadCycleModel alloc]initWithDic:dic];
                [_cycleImgArray addObject:cycleModel.imgsrc];
                [_cycleTitleArray addObject:cycleModel.title];
                [_cycleArray addObject:cycleModel];
                
                //判断是否有第二个或更多个轮播图
                if ( dic  && [[dic objectForKey:@"ads"] count] > 0 ) {
                    
                    NSArray *ads = dic[@"ads"];
                    if ([[dic allKeys] containsObject:@"ads"] && ads.count > 0) {
                        for (NSDictionary * cycleDic in ads) {
                            
                            HeadCycleModel *cycleModel1 = [[HeadCycleModel alloc]initWithDic:cycleDic];
                            [_cycleTitleArray addObject:cycleModel1.title];
                            [_cycleImgArray addObject:cycleModel1.imgsrc];
                            [_cycleArray addObject:cycleModel1];
                        }
                    }
                }
            }else{
                
                //图片新闻
                if ([[dic allKeys] containsObject:@"skipType"] && [dic[@"skipType"] isEqualToString:@"photoset"]) {
                    
                    PhotosetModel *photosetModel = [[PhotosetModel alloc]initWithDic:dic];
                    // photosetModel.imgextra = dic[@"imgextra"];
                    [_headArray addObject:photosetModel];
                    
                }else{
                    //文字类新闻
                    NewsModel *newsModel = [[NewsModel alloc]initWithDic:dic];
                    newsModel.digestHeight = [Height heightForText:newsModel.digest width:(SCREEN_WIDTH - 130) fontSize:12];
                    [_headArray addObject:newsModel];
                }
                
            }
            
        }
        
        _cycleScrollView.imageURLStringsGroup = _cycleImgArray;
        _cycleScrollView.titlesGroup = _cycleTitleArray;
        if (_cycleArray.count < 2) {
            //是否自动滚动
            _cycleScrollView.autoScroll = NO;
            //是否无限循环
            _cycleScrollView.infiniteLoop = NO;
            _cycleScrollView.showPageControl = NO;
            
        }else{
            //是否自动滚动
            _cycleScrollView.autoScroll = YES;
            //是否显示分页控件
            _cycleScrollView.showPageControl = YES;
            _cycleScrollView.infiniteLoop = YES;
            
        }
        
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [_tableView reloadData];

        
        
    }];

    
 

    
}

-(void)loadDataWithHead{
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html"];
    
    [AFN urlString:url getAFNdata:^(id responseObject) {
       
        NSArray *dataArray = responseObject[@"T1348647853363"];
        
        for (NSDictionary *dic in dataArray) {
            
            if (dataArray[0] == dic) {
                //头条轮播图
                HeadCycleModel *cycleModel = [[HeadCycleModel alloc]initWithDic:dic];
                
                [_cycleImgArray addObject:cycleModel.imgsrc];
                [_cycleTitleArray addObject:cycleModel.title];
                [_cycleArray addObject:cycleModel];
            
                //判断是否有第二个或更多个轮播图
                if ( dic  && [[dic objectForKey:@"ads"] count] > 0 ) {
                    
                    NSArray *ads = dic[@"ads"];
                    if ([[dic allKeys] containsObject:@"ads"] && ads.count > 0) {
                        for (NSDictionary * cycleDic in ads) {
                            if ([[cycleDic allKeys] containsObject:@"tag"] && [cycleDic[@"tag"] isEqualToString:@"photoset"]) {
                                
                                HeadCycleModel *cycleModel1 = [[HeadCycleModel alloc]initWithDic:cycleDic];
                                [_cycleTitleArray addObject:cycleModel1.title];
                                [_cycleImgArray addObject:cycleModel1.imgsrc];
                                [_cycleArray addObject:cycleModel1];
                            }
                        }
                    }
                }
                
            }else{
                //图片新闻
                if ([[dic allKeys] containsObject:@"skipType"] && [dic[@"skipType"] isEqualToString:@"photoset"]) {
                                        
                    PhotosetModel *photosetModel = [[PhotosetModel alloc]initWithDic:dic];
                   // photosetModel.imgextra = dic[@"imgextra"];
                    [_headArray addObject:photosetModel];
                    
                }else{
                    //文字类新闻
                    NewsModel *newsModel = [[NewsModel alloc]initWithDic:dic];
                    newsModel.digestHeight = [Height heightForText:newsModel.digest width:(SCREEN_WIDTH - 130) fontSize:12];
                    [_headArray addObject:newsModel];
                }
                
                
            }
            
            
        }
        
        _cycleScrollView.imageURLStringsGroup = _cycleImgArray;
        _cycleScrollView.titlesGroup = _cycleTitleArray;
        if (_cycleArray.count < 2) {
            //是否自动滚动
            _cycleScrollView.autoScroll = NO;
            //是否无限循环
            _cycleScrollView.infiniteLoop = NO;
            _cycleScrollView.showPageControl = NO;
            
        }else{
            //是否自动滚动
            _cycleScrollView.autoScroll = YES;
            //是否显示分页控件
            _cycleScrollView.showPageControl = YES;
            _cycleScrollView.infiniteLoop = YES;
            
        }
        
        [_tableView reloadData];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
