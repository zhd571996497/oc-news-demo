//
//  ReadView.m
//  SouLuo1.0
//
//  Created by ls on 15/9/10.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "ReadView.h"
#import "AFN.h"
#import "ImageToLeft.h"
#import "ImageToFull.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

@implementation ReadView

-(id)initWithFrame:(CGRect)frame
{
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
        [self.tableView setSeparatorColor:[UIColor clearColor]];
        self.tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tableView];
        
        self.modelArray = [NSMutableArray array];
        self.count = 20;
        [self getDataFromNet];
        [self reloadData];
        [self addRefresh];
    }
    return self;
}
/**
 *  请求数据
 */
-(void)getDataFromNet
{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    NSString * urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/recommend/getSubDocPic?passport=&devId=D617BE35-09D8-4BDA-9B5E-B07D836B464B&size=20&from=yuedu"];
    [AFN urlString:urlStr getAFNdata:^(id responseObject) {
        
        NSArray * array = [responseObject objectForKey:@"推荐"];
        //如果刷新状态是YES，将数组清空
        if (self.refresh == YES) {
            [self.modelArray removeAllObjects];
        }
        //因为两个Model有不一样的地方，做一个判断来区分哪个Model
        for (NSDictionary * dic in array) {
            if ([dic objectForKey:@"imgnewextra"] == nil) {
                ImageToLeft * leftModel = [[ImageToLeft alloc]initWithDic:dic];
                leftModel.rid = [dic objectForKey:@"id"];
                [self.modelArray addObject:leftModel];
            } else {
                ImageToFull * fullModel = [[ImageToFull alloc]initWithDic:dic];
                fullModel.rid = [dic objectForKey:@"id"];
                [self.modelArray addObject:fullModel];
            }
        }
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self animated:YES];
    }];
}
/**
 *  上拉加载
 */
-(void)reloadData
{
    self.refresh = NO;
    NSString * urlStr = @"http://c.3g.163.com/recommend/getSubDocPic?passport=&devId=D617BE35-09D8-4BDA-9B5E-B07D836B464B&size=";
    __block ReadView * myView = self;
    [self.tableView addFooterWithCallback:^{
        myView.count ++;
        
        [AFN urlString:[NSString stringWithFormat:@"%@%ld&from=yuedu",urlStr,myView.count] getAFNdata:^(id responseObject) {
            
            NSArray * array = [responseObject objectForKey:@"推荐"];

            //因为两个Model有不一样的地方，做一个判断来区分哪个Model
            for (NSDictionary * dic in array) {
                if ([dic objectForKey:@"imgnewextra"] == nil) {
                    ImageToLeft * leftModel = [[ImageToLeft alloc]initWithDic:dic];
                    leftModel.rid = [dic objectForKey:@"id"];
                    [myView.modelArray addObject:leftModel];
                } else {
                    ImageToFull * fullModel = [[ImageToFull alloc]initWithDic:dic];
                    fullModel.rid = [dic objectForKey:@"id"];
                    [myView.modelArray addObject:fullModel];
                }
            }
            [myView.tableView reloadData];
        }];
        [myView.tableView footerEndRefreshing];
    }];
}

/**
 *  下拉刷新
 */
-(void)addRefresh
{
    self.refresh = YES;
    __block ReadView * myView = self;
    [self.tableView addHeaderWithCallback:^{
        [myView getDataFromNet];
        [myView.tableView headerEndRefreshing];
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
