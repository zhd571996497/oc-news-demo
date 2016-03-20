//
//  PlayInterfaceViewController.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/16.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "PlayInterfaceViewController.h"
#import "AFN.h"
#import "AudiotListModel.h"
#import "InterfaceTableVIewCell.h"
#import "AudioPlay.h"
#import "AudioPlayMessage.h"
#import "MusicViewController.h"
#import "MBProgressHUD.h"
#import "MusicViewController.h"
#import "AudioPlay.h"
#import "AudioPlayMessage.h"
#import "MJRefresh.h"

@interface PlayInterfaceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tabelView;
@property(nonatomic,strong)UIView *HeadView;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)MBProgressHUD *HUD;
@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)MusicViewController *music;
@property(nonatomic,assign)NSInteger count;

@end

@implementation PlayInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _count = 0;
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.array = [[NSMutableArray alloc]init];
    _arr = [[NSMutableArray alloc]init];
    
    _music = [[MusicViewController alloc]init];
    
    _music.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, 200);
    [_music audioPlay];
    
//    _music.view.backgroundColor = [UIColor redColor];
    
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0,200 + 64,SCREEN_WIDTH,SCREEN_HEIGHT -64-200-49) style:UITableViewStylePlain];
    _tabelView.dataSource = self;

    _tabelView.delegate = self;
    [self.view addSubview: _music.view];
    [self.view addSubview:_tabelView];
    
    
    
    
    
    //菊花效果
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.removeFromSuperViewOnHide = YES;
    //    self.HUD.labelText = @"loading";
    //    self.HUD.color = [UIColor lightGrayColor];
    [_tabelView addSubview:self.HUD];
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    
    [self didLoad];
    
//    [self.tabelView addHeaderWithTarget:self action:@selector(didLoad)];
    [self.tabelView addFooterWithTarget:self action:@selector(didLoad)];
    //    返回按钮
    UIBarButtonItem * backBarButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = backBarButton;
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *string = @"cell";
    InterfaceTableVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (nil == cell) {
        cell = [[InterfaceTableVIewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        AudiotListModel *model = _array[indexPath.row];
        [cell getInfo:model];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AudiotListModel *model = [_array objectAtIndex:indexPath.row];
   
    [self loadloadWitnString:model.docid];
}

-(void)playmusicUrl:(NSString *)url
{
    AudioPlay *stk=[AudioPlay sharHandleController];
    [stk play:url];
}


-(void)didLoad
{
    
    NSLog(@"model --- %@",_model);
    
    NSString * string = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/%@/%ld-20.html",_model.tid,_count];
    _count += 20;
    NSLog(@"url = %@",string);
    [AFN urlString:string getAFNdata:^(id responseObject) {
        NSLog(@"%@",_model.tid);
        NSMutableArray *array = [responseObject objectForKey:_model.tid];
        for (NSDictionary *dic in array) {
            AudiotListModel *model = [[AudiotListModel alloc]init];
            model.title = [dic objectForKey:@"title"];
            model.docid = [dic objectForKey:@"docid"];
            [_array addObject:model];
        }
        [self.HUD setHidden:YES];
//        [_tabelView headerEndRefreshing];
        [_tabelView reloadData];
        [_tabelView footerEndRefreshing];
    }];
}

-(void)loadloadWitnString:(NSString *)docid
{
    NSString *string = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",docid];
    [AFN urlString:string getAFNdata:^(id responseObject) {
        NSDictionary *dic = [responseObject objectForKey:[NSString stringWithFormat:@"%@",docid]];
        NSMutableArray *array = [dic objectForKey:@"video"];
        
        
        NSString *dicc =[[array objectAtIndex:0]objectForKey:@"url_mp4"];
        
        [[AudioPlay sharHandleController] playURL:[NSURL URLWithString:dicc]];
        
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
