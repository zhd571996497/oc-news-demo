//
//  DetailViewController.m
//  SouLuo1.0
//
//  Created by ls on 15/9/9.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "DetailViewController.h"
#import "BaseModel.h"
#import "ImageToLeft.h"
#import "ImageToFull.h"
#import "ReadDetailModel.h"
#import "AFN.h"
#import "Height.h"
#import "ReadDataBase.h"
#import "MBProgressHUD.h"

@interface DetailViewController ()<UIWebViewDelegate>

@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UILabel * sourceAndPtimeLabel;
@property(nonatomic, strong)UIWebView * webView;
@property(nonatomic, strong)ImageToLeft * left;
@property(nonatomic, strong)ImageToFull * full;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    //通过类名判断Model的类别，得知来自Model的类型
    if ([NSStringFromClass([_model class]) isEqualToString:@"ImageToLeft"]) {
        self.left = (ImageToLeft *)_model;
        [self getDataWithID:self.left.rid];
    } else if ([NSStringFromClass([_model class]) isEqualToString:@"ImageToFull"]) {
        self.full = (ImageToFull *)_model;
        [self getDataWithID:self.full.rid];
    } else if (self.docid) {
        [self getDataWithID:self.docid];
    }
    _titleLabel = [[UILabel alloc]init];
    [_titleLabel setFont:[UIFont systemFontOfSize:18]];
    [_titleLabel setNumberOfLines:0];
    
    _sourceAndPtimeLabel = [[UILabel alloc]init];
    [_sourceAndPtimeLabel setFont:[UIFont systemFontOfSize:15]];
    [_sourceAndPtimeLabel setTextColor:[UIColor darkGrayColor]];
    
    self.webView = [[UIWebView alloc]init];
    self.webView.delegate = self;
//    返回按钮
    UIBarButtonItem * backBarButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = backBarButton;
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getDataWithID:(NSString *)Id
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString * urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",Id];
    [AFN urlString:urlStr getAFNdata:^(id responseObject) {
        NSDictionary * dic = [responseObject objectForKey:Id];
        //KVC赋值
        ReadDetailModel * model = [[ReadDetailModel alloc]initWithDic:dic];
        model.src = [[model.img firstObject] objectForKey:@"src"];

        NSString * replaceUrl = model.body;
        if (model.img && model.img.count > 0) {
            model.src = [[model.img firstObject] objectForKey:@"src"];
            for (int i = 0; i < model.img.count; i++) {
                replaceUrl = [replaceUrl stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<!--IMG#%d-->",i] withString:[NSString stringWithFormat:@"<img src='%@' /><br/>",[[model.img objectAtIndex:i] objectForKey:@"src"]]];
            }
        }
        replaceUrl = [NSString stringWithFormat:@"\n\n%@",replaceUrl];
        [self.webView loadHTMLString:replaceUrl baseURL:nil];

        //标题
        model.titleHeight = [Height heightForText:model.title width:SCREEN_WIDTH - 20 * RATIO_WIDTH fontSize:18];
        [_titleLabel setText:model.title];
        [_titleLabel setFrame:CGRectMake(10 * RATIO_WIDTH, 69, SCREEN_WIDTH - 20 * RATIO_WIDTH, model.titleHeight)];
        
        //来源与日期  截取字符串
        NSString * timeStr = [model.ptime substringFromIndex:5];
        timeStr = [timeStr substringToIndex:11];
        
        if (model.source) {
            [_sourceAndPtimeLabel setText:[NSString stringWithFormat:@"%@\t\t%@",model.source,timeStr]];
        } else {
            [_sourceAndPtimeLabel setText:[NSString stringWithFormat:@"%@",timeStr]];
        }
        
        [_sourceAndPtimeLabel setFrame:CGRectMake(10 * RATIO_WIDTH, _titleLabel.frame.size.height + _titleLabel.frame.origin.y + 5 * RATIO_HEIGHT, SCREEN_WIDTH - 20 * RATIO_WIDTH, 20)];
        //重写webview、scrollView的坐标
        [_webView setFrame:CGRectMake(0, _titleLabel.frame.size.height + _titleLabel.frame.origin.y + _sourceAndPtimeLabel.frame.size.height + 10 * RATIO_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - _webView.frame.origin.y - 140 - model.titleHeight)];
        [self.view addSubview:_titleLabel];
        [self.view addSubview:_sourceAndPtimeLabel];
        [self.view addSubview:_webView];
        //页面上添加数据-----------------------
        self.newsTitle = model.title;
        self.docid = Id;
        if (model.img) {
            self.imageSrc = [[model.img objectAtIndex:0]valueForKey:@"src"];
        }
        //收藏按钮------------------------------
        [[ReadDataBase shareDataBaseHandle]openDB];
        int selectStatue = [[ReadDataBase shareDataBaseHandle]selectReadDetailSelectInfoByRid:self.docid];
        [[ReadDataBase shareDataBaseHandle]closeDB];//查询当前新闻是否已收藏
        
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setFrame:CGRectMake(SCREEN_WIDTH - 10 * RATIO_WIDTH, 26 * RATIO_HEIGHT, 32 * RATIO_WIDTH, 32 * RATIO_WIDTH)];
        [_collectBtn setImage:[UIImage imageNamed:@"收藏-白.png"] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"收藏-selected.png"] forState:UIControlStateSelected];
        [_collectBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:_collectBtn];
        self.navigationItem.rightBarButtonItem = bar;
        if(selectStatue ==1){
            _collectBtn.selected = 1;
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(void)collectBtnClick:(UIButton*)btn
{
    btn.selected = !btn.selected;//置反收藏按钮的状态
    if (btn.selected == YES) {
        //Sqllite存储
        [[ReadDataBase shareDataBaseHandle]openDB];
        [[ReadDataBase shareDataBaseHandle]createTable];
        //将当前新闻的docid、title插入数据库
        [[ReadDataBase shareDataBaseHandle]insertReadDetailSelectInfo:self.docid infoTitle:self.newsTitle infoImgSrc:self.imageSrc];
        [[ReadDataBase shareDataBaseHandle]closeDB];
    }else if (btn.selected == NO) {
        //Sqllite存储
        [[ReadDataBase shareDataBaseHandle]openDB];
        //Sqllite删除当前新闻的信息
        [[ReadDataBase shareDataBaseHandle]deleteReadDetailSelectInfo:self.docid];
        [[ReadDataBase shareDataBaseHandle]closeDB];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [[ReadDataBase shareDataBaseHandle]openDB];
    int selectStatue = [[ReadDataBase shareDataBaseHandle]selectReadDetailSelectInfoByRid:self.docid];
    [[ReadDataBase shareDataBaseHandle]closeDB];//查询当前新闻是否已收藏
    if(selectStatue ==1){
        _collectBtn.selected = 1;
    }
}

#pragma mark- UIWebViewDelegate
//设置图片的宽度
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var script = document.createElement('script');"
        "script.type = 'text/javascript';"
        "script.text = \"function ResizeImages() { "
        "var myimg,oldwidth,oldheight;"
        "var maxwidth=%.f;"
        "for(i=0;i <document.images.length;i++){"
        "myimg = document.images[i];"
        "if(myimg.width > maxwidth){"
        "myimg.width = maxwidth;"
        "}"
        "}"
        "}\";"
        "document.getElementsByTagName('head')[0].appendChild(script);",SCREEN_WIDTH - 18]
    ];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
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
