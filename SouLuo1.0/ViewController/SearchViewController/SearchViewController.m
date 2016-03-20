//
//  SearchViewController.m
//  SouLuo1.0
//
//  Created by ls on 15/9/9.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchModel.h"
#import "AFN.h"
//#import "AFNetworking.h"
#import "DetailTextNewsViewController.h"
#import "MBProgressHUD.h"
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property(nonatomic,retain)NSString *searchString;
@property(nonatomic,retain)UISearchBar *mySearchBar;

@property(nonatomic,retain) UISearchController *searchController;
@property(nonatomic,retain)UITableView *dataTableView;
@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,strong)MBProgressHUD *HUD;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //[self setEdgesForExtendedLayout:UIRectEdgeNone];
    _mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
    _mySearchBar.delegate = self;
    _mySearchBar.keyboardType = UIKeyboardTypeDefault;
    _mySearchBar.placeholder =@"搜索";
    
    [self.view addSubview:_mySearchBar];
    
    //tableView
    _dataArr = [[NSMutableArray alloc]init];
    _dataTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, self.view.frame.size.width, self.view.frame.size.height - 113) style:UITableViewStylePlain];
    _dataTableView.delegate = self;
    _dataTableView.dataSource = self;
    [self.view addSubview:_dataTableView];

    //    返回按钮
    UIBarButtonItem * backBarButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = backBarButton;
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [_mySearchBar setShowsCancelButton:NO];
    NSString * string = _mySearchBar.text;
    NSData *strDtata = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [strDtata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
   
    
    
    NSString * s1 = @"http://c.m.163.com/search/comp/MA%3D%3D/20/";
    NSString * s2 = @".html?deviceId=NTcyMjZFNjUtNDc3OC00OUQ4LUE1QzUtOTU3ODA4OUI4QTk0&version=NS4zLjQ%3D&channel=5aS05p2h";
    NSString * str1 = [s1 stringByAppendingString:str];
    NSString * url = [str1 stringByAppendingString:s2];
    
    [AFN urlString:url getAFNdata:^(id responseObject) {
       
            
        
        NSDictionary * dic = responseObject;
        NSDictionary * dic2 = [dic objectForKey:@"doc"];
        
        NSMutableArray * array = [dic2 objectForKey:@"result"];
        for (NSDictionary * obj in array) {
            SearchModel * m = [[SearchModel alloc]init];
            //m.title = [obj objectForKey:@"title"];
           m.title =  [self filterHTML:obj[@"title"]];
            m.docid = [obj objectForKey:@"docid"];
            
            m.skipID = [obj objectForKey:@"skipID"];
            
            [_dataArr addObject:m];
            [_dataTableView reloadData];
        }
    }];
}

//取消按钮
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    [_mySearchBar setShowsCancelButton:YES];
    
    for (id cc in [_mySearchBar subviews]) {
        for (id dd in [cc subviews]) {
            
            if ([dd isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)dd;
                [button setFrame:CGRectMake(0, 0, 40, 40)];
                [button setTitle:@"取消" forState:UIControlStateNormal];
                button.titleLabel.textColor = [UIColor blackColor];
                break;
            }
        }
    }
    
    
    return YES;
}

//回收键盘
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    [_mySearchBar setShowsCancelButton:NO];
}

//去掉尖括号
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    
    //        NSString * regEx = @"<([^>]*)>";
    //        html = [html stringByReplacingOccurrencesOfString:regEx withString:self.key];
    return html;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchModel * m = [[SearchModel alloc]init];
    m = [_dataArr objectAtIndex:indexPath.row];
    DetailTextNewsViewController * web3213 = [[DetailTextNewsViewController alloc]init];
    web3213.docid = m.docid;
    [self.navigationController pushViewController:web3213 animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *string = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 300, 44)];
        [lable setTag:1000];
        [cell addSubview:lable];
    }
    UILabel * la = (UILabel *)[cell viewWithTag:1000];
    SearchModel * m = [[SearchModel alloc]init];
    m = [_dataArr objectAtIndex:indexPath.row];
    [la setText:m.title];
    
    if (m.title != nil) {
        
        NSMutableAttributedString * arrtiString = [[NSMutableAttributedString alloc]initWithString:m.title];
        if (_mySearchBar.text != nil) {
            
            NSRange range = [m.title rangeOfString:_mySearchBar.text];
            // 关键字高亮
            [arrtiString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            
            la.attributedText = arrtiString;
        }else{
            la.text = @" ";
        }
    }

    return cell;
}
-(void)didReceiveMemoryWarning {
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
