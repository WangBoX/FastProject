//
//  UIBasicNavigationController.m
//  ZJHJ
//
//  Created by 王博 on 16/8/21.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import "UIBasicNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface UIBasicNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation UIBasicNavigationController

/**
 *  重写pushViewController , 蓝色navigation，白色title
 *
 *  @param viewController 控制器
 *  @param animated       animate
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    self.interactivePopGestureRecognizer.enabled = YES;
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf ;
    }
    
}

-(BOOL)shouldAutorotate
{
    return YES;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject
            supportedInterfaceOrientations];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject
            preferredInterfaceOrientationForPresentation];
}

/**
 *  左边item方法
 *
 *  @param target    对象
 *  @param action    方法
 *  @param image     图片
 *  @param highImage 高亮图片
 *  @param title     title
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.size = button.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

@end
