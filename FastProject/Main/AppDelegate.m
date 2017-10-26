//
//  AppDelegate.m
//  FastProject
//
//  Created by WBO on 2017/10/25.
//  Copyright © 2017年 FastProject. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import "MainTabController.h"
#import "UIBasicNavigationController.h"
#import "JPFPSStatus.h"
#import "ServiceManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初始化进入APP服务
    [self initSDK];
    
    [self initWindow];
    
    [self setupMainViewController];
    
    return YES;
}

- (void)initSDK{
    //键盘处理
    [self initKeyboard];
    //启动服务
    [self setupServices];
}

- (void)initKeyboard{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

- (void)setupServices{
    // 网络环境监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    ServiceManager *service = [ServiceManager sharedManager];
    [service start];
}


- (void)setupMainViewController {
    
    [self setupTabBarController];
    
}

- (void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.window makeKeyAndVisible];
    
}


//登录成功后，进入APP--->均走此接口
- (void)setupTabBarController {
    
    MainTabController *mainTab = [[MainTabController alloc] initWithNibName:nil bundle:nil];
    [self.window setRootViewController:mainTab];
    
#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] open];
#endif
    
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}



- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end




