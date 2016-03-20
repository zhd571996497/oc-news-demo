//
//  SettingViewController.m
//  SouLuo1.0
//
//  Created by dllo on 15/9/16.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "SettingViewController.h"
#import "DRNRealTimeBlurView.h"
#import "SetView.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:self.view.frame];
    imgView.backgroundColor = [UIColor cyanColor];
    [imgView setUserInteractionEnabled:YES];
    [imgView setImage:[UIImage imageNamed:@"2.png"]];
    [self.view addSubview:imgView];
    

//    毛玻璃
    DRNRealTimeBlurView * blurView = [[DRNRealTimeBlurView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imgView addSubview:blurView];
//    抽屉页面View
    SetView * myView = [[SetView alloc]initWithFrame:self.view.frame];
    [blurView addSubview:myView];
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
