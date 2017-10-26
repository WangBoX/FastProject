//
//  UIBasicViewController.m
//  ZJHJ
//
//  Created by 王博 on 16/6/19.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import "UIBasicViewController.h"
#import "AppDelegate.h"
#import "UIImage+Color.h"

@interface UIBasicViewController ()


@end

@implementation UIBasicViewController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navSetting];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMainbackgroundColor;
    
}

- (void)navSetting{
    
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setImage:[UIImage imageNamed:@"nav_back_white"] forState:UIControlStateNormal];
        [leftBtn sizeToFit];
        leftBtn.width = 44;
        leftBtn.height = 44;
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(14.5, 7, 14.5, 28);
        UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];        
        //设置导航栏背景、title的颜色
        self.navigationItem.leftBarButtonItem  = leftBtnItem;
    }
    
    //设置导航条颜色
    UIBasicNavigationController *nav = (UIBasicNavigationController *)self.navigationController;
    nav.statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kMainBlueColor, NSForegroundColorAttributeName, [UIFont fontWithName:@"PingFangSC-Regular" size:18], NSFontAttributeName, nil]];
    [self.navigationController setHidesNavigationBarHairline:YES];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (void)dealloc {
    DebugLog(@"%@ --> 释放成功",self);
}

@end
