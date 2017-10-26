//
//  ToolObject.h
//  MoodGood
//
//  Created by 王博 on 2017/8/9.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    rippleEffect = 0, //波纹效果
    cube,//立体翻转效果
    suckEffect,//像被吸入瓶子的效果
    oglflip,//翻转
    pageCurl,//翻页效果
    pageUnCurl,//反翻页效果
    cameraIrisHollowOpen,//开镜头效果
    cameraIrisHollowClose,//关镜头效果
    fade,//淡入淡出
    push,//推进效果
    reveal,//揭开效果
    moveIn,//慢慢进入并覆盖效果
    fromBottom,//下翻页效果
    fromTop,//上翻页效果
    fromLeft,//左翻转效果
    fromRight//右翻转效果
} PushControllerAnimation;

//TelephoningTypeApplicationTelprompt与TelephoningTypeApplicationTelprompt几乎效果一样，只多了一层黑色非常透明的丝袜
typedef enum : NSUInteger {
    TelephoningTypeApplicationWebView = 0,//在手机电话APP拨打，先在本APP内弹窗提示，需确认拨打。
    TelephoningTypeApplication,//在手机电话APP直接拨打，无提示。结束通话后返回当前APP界面
    TelephoningTypeApplicationTelprompt,//在手机电话APP拨打，先在本APP内弹窗提示，需确认拨打。听说此方法上架APP容易被拒？？
} TelephoningType;

@interface ToolObject : NSObject

+ (CATransition *)pushAnimationWith:(PushControllerAnimation)animation fromController:(id)delegate;
/**
 拨打电话
 
 @param phoneNum        电话号码
 @param telephoningType 拨打类型 见TKCTelephoningType
 */
+ (void)userTelephoningNum:(NSString *)phoneNum type:(TelephoningType)telephoningType;
@end
