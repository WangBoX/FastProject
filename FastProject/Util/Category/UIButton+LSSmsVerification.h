//
//  UIButton+LSSmsVerification.h
//  短信验证码
//
//  Created by wbo on 16/6/30.
//  Copyright © 2016年 wbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LSSmsVerification)

/**
 *  获取短信验证码倒计时
 *
 *  @param duration 倒计时时间
 *  @param color 倒计时数字颜色
 */
- (void)startTimeWithDuration:(NSInteger)duration DurationTitleColor:(UIColor *)color;

@end
