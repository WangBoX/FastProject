//
//  ToolObject.m
//  MoodGood
//
//  Created by 王博 on 2017/8/9.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import "ToolObject.h"
#import "UIAlertView+Extension.h"
@implementation ToolObject


+ (CATransition *)pushAnimationWith:(PushControllerAnimation)animation fromController:(id)delegate {
    CATransition * transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    switch (animation) {
        case 0:
            transition.type = @"rippleEffect";
            break;
        case 1:
            transition.type = @"cube";
            break;
        case 2:
            transition.type = @"suckEffect";
            break;
        case 3:
            transition.type = @"oglflip";
            break;
        case 4:
            transition.type = @"pageCurl";
            break;
        case 5:
            transition.type = @"pageUnCurl";
            break;
        case 6:
            transition.type = @"cameraIrisHollowOpen";
            break;
        case 7:
            transition.type = @"cameraIrisHollowClose";
            break;
        case 8:
            transition.type = @"fade";
            break;
        case 9:
            transition.type = @"push";
            break;
        case 10:
            transition.type = @"reveal";
            break;
        case 11:
            transition.type = @"moveIn";
            break;
        case 12:
            transition.type = @"fromBottom";
            break;
        case 13:
            transition.type = @"fromTop";
            break;
        case 14:
            transition.type = @"fromLeft";
            break;
        case 15:
            transition.type = @"fromRight";
            break;
        default:
            break;
    }
    transition.subtype = kCATransitionMoveIn;
    transition.delegate = delegate;
    return transition;
}
/**
 拨打电话
 
 @param phoneNum        电话号码
 @param telephoningType 拨打类型 见TelephoningType
 */
+ (void)userTelephoningNum:(NSString *)phoneNum type:(TelephoningType)telephoningType{
    
    switch (telephoningType) {
        case TelephoningTypeApplicationWebView:
        {
            phoneNum = [@"tel:" stringByAppendingString:phoneNum];
            //
            UIWebView *webView = [[UIWebView alloc] init];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneNum]]];
            [[UIApplication sharedApplication].keyWindow addSubview:webView];
        }
            break;
        case TelephoningTypeApplication:
        {
             NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
            if (@available(iOS 10.0,*)){
                // 判断是否可以能打开URL
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }else {
                /// 弹窗
                [UIAlertView al_alertWithTitle:nil message:phoneNum completion:^(NSInteger buttonIndex, NSString *buttonTitle) {
                    if (buttonIndex == 1) {
                        if ([[UIApplication sharedApplication] canOpenURL:url]) {
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    }
                } cancleButtonTitle:@"取消" otherButtonTitleList:@[@"呼叫"]];
            }
        }
            break;
        case TelephoningTypeApplicationTelprompt:
        {
            phoneNum = [@"telprompt://" stringByAppendingString:phoneNum];
            //
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNum]];
        }
            break;
            
        default:
            break;
    }
    
}
@end
