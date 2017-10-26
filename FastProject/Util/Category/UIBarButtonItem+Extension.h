//
//  UIBarButtonItem+Extension.h
//  PD_PC
//
//  Created by 王博 on 16/2/29.
//  Copyright © 2016年 PUDONG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title;
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title;
@end
