//
//  DetailPhotoNewsViewController.m
//  SouLuo1.0
//
//  Created by ls on 15/9/22.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "DetailPhotoNewsViewController.h"
#import "PhotoNewsCollectionViewCell.h"
#import "PhotoNewsModel.h"
#import "AFN.h"
@interface DetailPhotoNewsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
//model类数组
@property (nonatomic , strong)NSMutableArray *photoNewsArray;

@property (nonatomic , strong)UICollectionView *collectionView;

@end

@implementation DetailPhotoNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.photoNewsArray = [[NSMutableArray alloc]init];
    [self loadData];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(0, 0, 32, 32)];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:flowLayout];
    _collectionView.pagingEnabled = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[PhotoNewsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    
}

-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _photoNewsArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    PhotoNewsModel *newsModel = _photoNewsArray[indexPath.row];
    cell.photoNewsModel = newsModel;
    return cell;
}


-(void)loadData{
    
    NSString *url = [self.urlString  stringByReplacingOccurrencesOfString:@"54GI" withString:@""];
    url = [url stringByReplacingOccurrencesOfString:@"|" withString:@"/"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@.json",url];
//    NSLog(@"urlString === %@", self.urlString);
    [AFN urlString:urlString getAFNdata:^(id responseObject) {
       
        NSArray *photos =responseObject[@"photos"];
        
        for (NSDictionary *dic in photos) {
//            NSLog(@"imgurl ===== %@ , note ===== %@", dic[@"imgurl"], dic[@"note"]);
            PhotoNewsModel *newsModel = [[ PhotoNewsModel alloc]initWithDic:dic];
            //NSLog(@"photoimgtitle = %@",newsModel.note);
            newsModel.setname = responseObject[@"setname"];
            
            [_photoNewsArray addObject:newsModel];
        }
        
        [_collectionView reloadData];
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
