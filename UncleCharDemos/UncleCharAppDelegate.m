//
//  UncleCharAppDelegate.m
//  UncleCharDemos
//
//  Created by UncleChar on 15/12/25.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "UncleCharAppDelegate.h"
#import "AppBaseViewController.h"
#import "AppEngineManager.h"
#import "CJNavigationController.h"
#import "Reachability.h"
#import "DBManager.h"
@implementation UncleCharAppDelegate


+ (UncleCharAppDelegate *)getUncleCharAppDelegateDelegate
{
    return (UncleCharAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    AppEngineManager *engineManager = [[AppEngineManager alloc]init];
    NSLog(@"AppStart---%@",engineManager.baseViewController);
    
    DBManager *db = [[DBManager sharedDBManager]initDBDirectoryWithPath:engineManager.dirDBSqlite];//打开数据库
    //创建数据库 userinfo 表
    [db createDBTableWithTableName:@"UserInfo"];
    
    
//    UIApplication *app=[UIApplication sharedApplication];
//    app.applicationIconBadgeNumber=123;
//    
//    //设置指示器的联网动画
//    app.networkActivityIndicatorVisible=YES;
//
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netStatusDidChanged:) name:kReachabilityChangedNotification object:nil];
    _hostReach = [Reachability reachabilityWithHostName:@"www.google.com"];//可以以多种形式初始化
    [_hostReach startNotifier];  //开始监听,会启动一个run loop

    
    
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[CJNavigationController alloc]initWithRootViewController:[AppEngineManager sharedInstance].baseViewController];
    //    self.window.rootViewController = [[ViewController alloc]init];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
      NSLog(@"ResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     NSLog(@"Background");
}
 // 应用程序即将进入前台的时候调用
 // 一般在该方法中恢复应用程序的数据,以及状态
- (void)applicationWillEnterForeground:(UIApplication *)application {
   
    
     NSLog(@"Foreground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"BecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // 应用程序即将被销毁的时候会调用该方法
    // 注意:如果应用程序处于挂起状态的时候无法调用该方法
     NSLog(@"terminate");
}

#pragma mark - 监听网络状态的改变
- (void)netStatusDidChanged:(NSNotification *)noti {


    Reachability* curReach = [noti object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络连接！请检查网络" message:@"WIFI"  delegate:nil
                                              cancelButtonTitle:@"YES" otherButtonTitles:nil];
        
        [alert show];
        
        [self storeNetworkStatusWithBool:NO];
        
    }
    if (status == ReachableViaWiFi) {
    
        
        [self storeNetworkStatusWithBool:YES];
    }
    if (status == ReachableViaWWAN) {
        
        
        [self storeNetworkStatusWithBool:YES];
    }

}

- (void)storeNetworkStatusWithBool:(BOOL)isReachable {

    [[NSUserDefaults standardUserDefaults] setBool:isReachable forKey:@"networkStatus"];
    
}

@end
