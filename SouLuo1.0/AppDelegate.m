//
//  AppDelegate.m
//  SouLuo1.0
//
//  Created by ls on 15/9/9.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ReadViewController.h"
#import "VideoViewController.h"
#import "SettingViewController.h"
#import "WZGuideViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    //增加标识，用于判断是否是第一次启动应用...
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    UINavigationController *navi1 = [[UINavigationController alloc]initWithRootViewController:homeVC];
    navi1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"新闻" image:[[UIImage imageNamed:@"新闻.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"新闻-selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    ReadViewController *readVC = [[ReadViewController alloc]init];
    UINavigationController *navi2 = [[UINavigationController alloc]initWithRootViewController:readVC];
    navi2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"阅读" image:[[UIImage imageNamed:@"阅读.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"阅读-selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    VideoViewController *videoVC = [[VideoViewController alloc]init];
    UINavigationController *navi3 = [[UINavigationController alloc]initWithRootViewController:videoVC];
    navi3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"视听" image:[[UIImage imageNamed:@"视听.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"视听-selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    SettingViewController * setVC = [[SettingViewController alloc]init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    [tabBarController setViewControllers:[NSArray arrayWithObjects:navi1,navi2,navi3, nil]];
    [tabBarController.tabBar setTintColor:MYCOLOR_GRB(69, 162, 215, 1)];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:MYCOLOR_GRB(69, 162, 215, 1)];

//    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    
    self.leftSlideVC = [[LeftSlideViewController alloc]initWithLeftView:setVC andMainView:tabBarController];
    [self.window setRootViewController:self.leftSlideVC];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [WZGuideViewController show];
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
