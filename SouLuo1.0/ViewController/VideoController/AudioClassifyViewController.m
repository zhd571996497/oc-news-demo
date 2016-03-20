//
//  AudioClassifyViewController.m
//  SouLuo1.0
//
//  Created by 金虹 on 15/9/16.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "AudioClassifyViewController.h"
#import "AFN.h"
#import "AudiotListModel.h"
#import "AudioClassifyCell.h"
#import "PlayInterfaceViewController.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"

@interface AudioClassifyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)MBProgressHUD *HUD;
@property(nonatomic,assign)NSInteger count;

@end

@implementation AudioClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //菊花效果
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.removeFromSuperViewOnHide = YES;
    //    self.HUD.labelText = @"loading";
    //    self.HUD.color = [UIColor lightGrayColor];
    [_tableView addSubview:self.HUD];
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    
    [self didLoad];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"1234.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(button)];
    self.navigationItem.leftBarButtonItem = btn;
    
    //    返回按钮
    UIBarButtonItem * backBarButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = backBarButton;
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RATIO_HEIGHT*100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *string = @"cell";
    AudioClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        cell = [[AudioClassifyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        
        AudiotListModel *model = _dataArray [indexPath.row];
        [cell getInfo:model];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayInterfaceViewController *play = [[PlayInterfaceViewController alloc]init];
    play.model = [_dataArray objectAtIndex:indexPath.row];
    NSLog(@"%@",play.model.tid);
    [self.navigationController pushViewController:play animated:YES];
}

-(void)didLoad
{
    NSString *string = [NSString stringWithFormat:@"http://c.m.163.com/nc/topicset/ios/radio/%@/0-20.html",_cuid];
    [AFN urlString:string getAFNdata:^(id responseObject) {
        NSMutableArray *array = [responseObject objectForKey:@"tList"];
        for (NSDictionary *dic in array) {
            NSDictionary *Dic = dic[@"radio"];
            AudiotListModel *model = [[AudiotListModel alloc]init];
            model.tname = [dic objectForKey:@"tname"];
            model.imgsrc = [Dic objectForKey:@"imgsrc"];
            model.url = [Dic objectForKey:@"url"];
            model.title = [Dic objectForKey:@"title"];
            model.tid = [dic objectForKey:@"tid"];
            [_dataArray addObject:model];
        }
        [self.HUD setHidden:YES];
        [_tableView reloadData];
    }];
//    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
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
