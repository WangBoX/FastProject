//
//  AppDelegate.h
//  FastProject
//
//  Created by WBO on 2017/10/25.
//  Copyright © 2017年 FastProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

- (void)setupMainViewController;

//登录界面
- (void)setupLoginController;

//登录成功后 进入APP--->均走此接口
- (void)setupTabBarController;
@end

