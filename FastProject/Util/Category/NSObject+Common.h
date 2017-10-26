//
//  NSObject+Common.h
//  QP_iOS
//
//  Created by ios on 16/6/16.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <objc/runtime.h>
#import "Reachability.h"
#import "ZJNetResponse.h"

@interface NSObject (Common)


/**
 * true为空
 */
+ (BOOL)isEmpty:(id )data;

/**
 *  显示str
 *
 *  @param tipStr str
 *
 *  delay 延长时间
 */
+ (void)showHudTipStr:(NSString *)tipStr withTime:(NSTimeInterval)delay;
+ (void)showHudTipStr:(NSString *)tipStr;//蒙板提示NSString
+ (instancetype)showHUDQueryStr:(NSString *)titleStr;//蒙板请求titleStr中
+ (NSUInteger)hideHUDQuery;//dismiss蒙板


/**
 不带提示的小菊花
 @param hasGraceTime 是否有延迟时间
 */
+ (void)showHUDWithGraceTime:(BOOL)hasGraceTime;

/**
 *
 *  hasGraceTime 是否有1.5秒的延迟
 *  菊花载入中，蒙板是否会隐藏
 */
+ (void)showHUDWithTip:(NSString *)tip GraceTime:(BOOL)hasGraceTime Hide:(BOOL)hide;


/**
 可设置超时时间的小菊花，0为没有超时时间
 
 @param timeout 超时时间
 */
+ (void)showWaitHUDWithTimeout:(NSTimeInterval)timeout;
/**
 *  不带提示的小菊花，无延迟时间
 */
+ (void)showWaitHUD;

/**
 *  不带提示的小菊花，无延迟时间
 *  view 添加到的view
 *  rect 范围
 */
+ (void)showWaitHUDAddedTo:(UIView *)view withRect:(CGRect)rect animated:(BOOL)animated;

/**
 *  隐藏当前小菊花
 */
+ (void)hideWaitHUD;

/**
 *  操作成功提示蒙版，默认显示1s
 */
+ (void)showSuccessWithTip:(NSString *)tip;

/**
 *  操作成功提示
 *
 *  @param tip         提示文字
 *  @param actionBlock 蒙版隐藏后要做的事情
 *  @param delay       消失延时
 */
+ (void)showSuccessWithTip:(NSString *)tip finalAction:(void(^)())actionBlock after:(NSTimeInterval)delay;

/**
 *  操作失败提示蒙版，默认显示1s
 */
+ (void)showFailureWithTip:(NSString *)tip;

/**
 *  操作失败提示蒙版
 *
 *  @param tip         提示文字
 *  @param actionBlock 蒙版隐藏后要做的事情
 *  @param delay       消失延时
 */
+ (void)showFailureWithTip:(NSString *)tip finalAction:(void(^)())actionBlock after:(NSTimeInterval)delay;

/**
 *  自定义显示图片蒙版
 *
 *  @param tip         提示文字
 *  @param image       提示图片
 *  @param actionBlock 蒙版隐藏后要做的事情
 *  @param delay       消失延时
 */
+ (void)showHUDWithTip:(NSString *)tip Image:(UIImage *)image finalAction:(void(^)())actionBlock after:(NSTimeInterval)delay;

/**
 *  带提示的小菊花
 */
+ (void)showWaitWithTip:(NSString *)tip;
+ (void)showWaitNoTimeoutWithTip:(NSString *)tip;

/**
 *  任务完成后，自动隐藏的小菊花（仅支持单线程）
 *
 *  @param tip       提示文字
 *  @param taskBlock 执行的任务
 */
+ (void)showWaitWithTip:(NSString *)tip task:(void(^)())taskBlock;

/**
 *  有显示时限的小菊花
 *
 *  @param tip        提示文字
 *  @param duration   显示时长（0为无限制）
 *  @param finalBlock 隐藏后的操作
 */
+ (void)showWaitWithTip:(NSString *)tip withDuration:(NSTimeInterval)duration finalAction:(void(^)())finalBlock;

//获取一个随机整数，范围在[from,to]，包括from，包括to
-(int)getRandomNumber:(NSUInteger)from to:(NSUInteger)to;

#pragma mark Net  Error
- (ZJNetResponse *)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;//网络response，code非0时，错误处理
- (ZJNetResponse *)handleNetFail:(NSError *)error;

#pragma mark - 跳转业务

#pragma mark 网络状态
- (NetworkStatus)netStatus;

@end

