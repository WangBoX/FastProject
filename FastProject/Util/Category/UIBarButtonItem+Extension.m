//
//  UIBarButtonItem+Extension.m
//  PD_PC
//
//  Created by 王博 on 16/2/29.
//  Copyright © 2016年 PUDONG. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIButton+ImageTitleSpacing.h"

@implementation UIBarButtonItem (Extension)

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
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5.f];
    button.frame  = CGRectMake(0, -6, 60, 16);
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

/**
 * 右边item方法
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title{
    UIBarButtonItem *buttonI = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    [buttonI setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateDisabled];
    [buttonI setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:61/255.0 green:163/255.0 blue:222/255.0 alpha:1]} forState:UIControlStateNormal];
    return buttonI;
}


@end

