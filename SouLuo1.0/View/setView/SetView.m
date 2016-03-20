//
//  SetView.m
//  SouLuo1.0
//
//  Created by dllo on 15/9/17.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "SetView.h"
#import "SearchViewController.h"
#import "LeftSlideViewController.h"
@implementation SetView

-(instancetype)initWithFrame:(CGRect)frame
{
    CGFloat height = frame.size.height;
    self = [super initWithFrame:frame];
    if (self) {
        
//        行间距
        CGFloat yLenDevid = (height/3 - 140 * RATIO_HEIGHT)/3;
        
//        清理缓存
        _clearImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearImgBtn setFrame:CGRectMake(55 * RATIO_WIDTH, height / 3, 35 * RATIO_WIDTH, 35 * RATIO_WIDTH)];
        [_clearImgBtn setBackgroundImage:[UIImage imageNamed:@"清理缓存35.png"] forState:UIControlStateNormal];
        [_clearImgBtn addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_clearImgBtn];
        
        _clearTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearTextBtn setFrame:CGRectMake(_clearImgBtn.frame.origin.x + _clearImgBtn.frame.size.width, height / 3, 120 * RATIO_WIDTH, 35 * RATIO_WIDTH)];
        [_clearTextBtn setTitle:@"清理缓存" forState:UIControlStateNormal];
        [_clearTextBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
//        [_clearTextBtn setTitleColor:MYCOLOR_GRB(239,196, 3, 1) forState:UIControlStateNormal];
        [_clearTextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [_clearTextBtn addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_clearTextBtn];
        
//        夜间模式
        _nightImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nightImgBtn setFrame:CGRectMake(55 * RATIO_WIDTH, height/3 + 35 * RATIO_HEIGHT + yLenDevid, 35 * RATIO_WIDTH, 35 * RATIO_WIDTH)];
        [_nightImgBtn setBackgroundImage:[UIImage imageNamed:@"夜间35.png"] forState:UIControlStateNormal];
        [_nightImgBtn setBackgroundImage:[UIImage imageNamed:@"日间35.png"] forState:UIControlStateSelected];
        [_nightImgBtn addTarget:self action:@selector(nightClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nightImgBtn];
        
        _nightTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nightTextBtn setFrame:CGRectMake(_nightImgBtn.frame.origin.x + _nightImgBtn.frame.size.width, height/3 + 35 * RATIO_HEIGHT + yLenDevid, 120 * RATIO_WIDTH, 35 * RATIO_WIDTH)];
        [_nightTextBtn setTitle:@"夜间模式" forState:UIControlStateNormal];
        [_nightTextBtn setTitle:@"日间模式" forState:UIControlStateSelected];
        [_nightTextBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
//        [_nightTextBtn setTitleColor:MYCOLOR_GRB(239,196, 3, 1) forState:UIControlStateNormal];
        [_nightTextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [_nightTextBtn addTarget:self action:@selector(nightClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nightTextBtn];
        
//        搜索按钮
        _searchImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchImgBtn setFrame:CGRectMake(55 * RATIO_WIDTH, height/3 + 70 * RATIO_HEIGHT + yLenDevid * 2, 35 * RATIO_WIDTH, 35 * RATIO_WIDTH)];
        [_searchImgBtn setBackgroundImage:[UIImage imageNamed:@"搜索35.png"] forState:UIControlStateNormal];
        [_searchImgBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_searchImgBtn];
        
        _searchTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchTextBtn setFrame:CGRectMake(_searchImgBtn.frame.origin.x + _searchImgBtn.frame.size.width, height/3 + 70 * RATIO_HEIGHT + yLenDevid * 2, 120 * RATIO_WIDTH, 35 * RATIO_HEIGHT)];
        [_searchTextBtn setTitle:@"搜\t\t索" forState:UIControlStateNormal];
        [_searchTextBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
//        [_searchTextBtn setTitleColor:MYCOLOR_GRB(239,196, 3, 1) forState:UIControlStateNormal];
        [_searchTextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [_searchTextBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_searchTextBtn];
        
//        关于我们
        _aboutImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_aboutImgBtn setFrame:CGRectMake(55 * RATIO_WIDTH, height/3 + 105 * RATIO_HEIGHT + yLenDevid * 3, 35 * RATIO_WIDTH, 35 * RATIO_WIDTH)];
        [_aboutImgBtn setBackgroundImage:[UIImage imageNamed:@"关于35.png"] forState:UIControlStateNormal];
        [_aboutImgBtn addTarget:self action:@selector(aboutClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_aboutImgBtn];
        
        _aboutTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_aboutTextBtn setFrame:CGRectMake(_aboutImgBtn.frame.origin.x + _aboutImgBtn.frame.size.width, height/3 + 105 * RATIO_HEIGHT + yLenDevid * 3, 120 * RATIO_WIDTH, 35 * RATIO_WIDTH)];
        [_aboutTextBtn setTitle:@"关于我们" forState:UIControlStateNormal];
        [_aboutTextBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
//        [_aboutTextBtn setTitleColor:MYCOLOR_GRB(239,196, 3, 1) forState:UIControlStateNormal];
        [_aboutTextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [_aboutTextBtn addTarget:self action:@selector(aboutClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_aboutTextBtn];
    }
    return self;
}

-(void)clearClick
{
    [self huancun];
}

-(void)nightClick:(UIButton *)sender
{
    if (!sender.selected) {
        _nightImgBtn.selected = YES;
        _nightTextBtn.selected = YES;
        self.window.alpha = 0.5;
    } else {
        self.window.alpha = 1;
        _nightTextBtn.selected = NO;
        _nightImgBtn.selected = NO;
    }
  //  sender.selected = !sender.selected;
    
}

-(void)aboutClick
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"亲，如有任何建议，欢迎给我们发送邮件，xxxxxxx@163.com" delegate:self cancelButtonTitle:@"好哒" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)searchClick
{
    SearchViewController * search = [[SearchViewController alloc]init];
    LeftSlideViewController * leftSlideView =  (LeftSlideViewController *) [[[[UIApplication sharedApplication]delegate]window]rootViewController];
    UITabBarController * tab  = (UITabBarController *)leftSlideView.mainVC;
    [leftSlideView closeLeftView];
    UINavigationController * navi = (UINavigationController *)tab.selectedViewController;
    [navi pushViewController:search animated:YES];
}

#pragma mark- 获取缓存
-(float)filePath
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [self folderSizeAtPath:cachePath];
}

-(float)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator * childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1024.0 * 1024.0);
}

-(long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
/**
 *  获取缓存结束
 */

#pragma mark- 清除缓存
/**
 *  清除缓存
 */
-(void)huancun
{
    NSString * romNumber = [NSString stringWithFormat:@"%.2fM",[self filePath]];
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"清理缓存" message:romNumber delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    NSArray * files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    for (NSString * str in files) {
        NSError * error = nil;
        NSString * path = [cachePath stringByAppendingPathComponent:str];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}

#pragma mark-



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
