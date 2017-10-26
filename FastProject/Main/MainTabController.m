//
//  MainTabController.m
//  MoodGood
//
//  Created by WBO on 2017/10/12.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import "MainTabController.h"
#import "Root0ViewController.h"
#import "Root1ViewController.h"
#import "Root2ViewController.h"
#import "Root3ViewController.h"
#import "AppDelegate.h"

#define TabbarVC    @"vc"
#define TabbarTitle @"title"
#define TabbarImage @"image"
#define TabbarSelectedImage @"selectedImage"
#define TabBarCount 4


typedef NS_ENUM(NSInteger, MainTabType) {
    MainTabTypeZero,
    MainTabTypeOne,
    MainTabTypeTwo,
    MainTabTypeThree,
};

@interface MainTabController ()

@end

@implementation MainTabController

+ (instancetype)instance{
    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = delegete.window.rootViewController;
    if ([vc isKindOfClass:[MainTabController class]]) {
        return (MainTabController *)vc;
    }else{
        return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubNav];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBar.tintColor = kMainBlueColor;

}

-(void)viewWillLayoutSubviews
{
    self.view.frame = [UIScreen mainScreen].bounds;
}

- (NSArray*)tabbars{
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSInteger tabbar = 0; tabbar < TabBarCount; tabbar++) {
        [items addObject:@(tabbar)];
    }
    return items;
}

- (void)setUpSubNav{

    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    [self.tabbars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * item =[self vcInfoForTabType:[obj integerValue]];
        NSString *vcName = item[TabbarVC];
        NSString *title  = item[TabbarTitle];
        NSString *imageName = item[TabbarImage];
        NSString *imageSelected = item[TabbarSelectedImage];
        Class clazz = NSClassFromString(vcName);
        UIViewController *vc = [[clazz alloc] init];
        
        UIBasicNavigationController *nav = [[UIBasicNavigationController alloc] initWithRootViewController:vc];
        
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                       image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                               selectedImage:[[UIImage imageNamed:imageSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        nav.tabBarItem.tag = idx;
        [vcArray addObject:nav];
    }];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Thin" size:11]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes
                                                forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes
                                                forState:UIControlStateHighlighted];
    self.viewControllers = [NSArray arrayWithArray:vcArray];
}


- (void)setUpStatusBar{
    UIStatusBarStyle style = UIStatusBarStyleLightContent;
    [[UIApplication sharedApplication] setStatusBarStyle:style
                                                animated:NO];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - QPNavigationGestureHandlerDataSource
- (UINavigationController *)navigationController
{
    return self.selectedViewController;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - VC
- (NSDictionary *)vcInfoForTabType:(MainTabType)type{
    if (_configs == nil)
    {
        _configs = @{
                     @(MainTabTypeZero)     : @{
                             TabbarVC           : @"Root0ViewController",
                             TabbarTitle        : @"0",
                             TabbarImage        : @"",
                             TabbarSelectedImage: @"",
                             },
                     
                     @(MainTabTypeOne) : @{
                             TabbarVC           : @"Root1ViewController",
                             TabbarTitle        : @"1",
                             TabbarImage        : @"",
                             TabbarSelectedImage: @"",
                             },
                     
                     @(MainTabTypeTwo) : @{
                             TabbarVC           : @"Root2ViewController",
                             TabbarTitle        : @"2",
                             TabbarImage        : @"",
                             TabbarSelectedImage: @"",
                             },
                     
                     @(MainTabTypeThree): @{
                             TabbarVC           : @"Root3ViewController",
                             TabbarTitle        : @"3",
                             TabbarImage        : @"",
                             TabbarSelectedImage: @"",
                             }
                     };
    }
    return _configs[@(type)];
}


@end




