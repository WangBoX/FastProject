//
//  UIButton+LSSmsVerification.m
//  短信验证码
//
//  Created by wbo on 16/6/30.
//  Copyright © 2016年 wbo. All rights reserved.
//

#import "UIButton+LSSmsVerification.h"

@implementation UIButton (LSSmsVerification)

/**
 *  获取短信验证码倒计时
 *
 *  @param duration 倒计时时间
 *  @param color 倒计时数字颜色
 */
- (void)startTimeWithDuration:(NSInteger)duration DurationTitleColor:(UIColor *)color
{
    __block NSInteger timeout = duration;
    
    NSString *originalTitle = [self titleForState:UIControlStateNormal];
    UIColor *originalTitleColor = [self titleColorForState:UIControlStateNormal];
    UIFont *originalFont = self.titleLabel.font;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer_t,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);     dispatch_source_set_event_handler(timer_t, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer_t);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮为最初的状态
                [self setTitle:originalTitle forState:UIControlStateNormal];
                [self setTitleColor:originalTitleColor forState:UIControlStateNormal];
                self.titleLabel.font = originalFont;
                self.userInteractionEnabled = YES;
            });
        }else{
            NSInteger seconds = timeout % duration;
            if(seconds == 0){
                seconds = duration;
            }
            NSString *strTime = [NSString stringWithFormat:@"%.2ld", (long)seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"重新获取(%@)",strTime] forState:UIControlStateNormal];
                [self setTitleColor:color forState:UIControlStateNormal];
                self.titleLabel.font = [UIFont boldSystemFontOfSize:11.0];
                self.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(timer_t);
}

@end
