//
//  Config.h
//  MoodGood
//
//  Created by 王博 on 2017/8/9.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#ifndef Config_h
#define Config_h

/************************#import************************/
#import "AFNetworking.h"
#import <MJExtension.h>
#import <ChameleonFramework/Chameleon.h>
#import "UIBasicViewController.h"
#import "UIView+WB.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UIBasicNavigationController.h"
#import "NSObject+Common.h"
#import <Masonry.h>
#import <YYCache/YYCache.h>
#import "WBKeyValueStore.h"
#import "UIImageView+WebCache.h"


#define DEV 1 //发布模式，注释掉
#ifdef DEV
/**************************** 测试模式 ****************************/
#define MainUrl @"https://"     //网络请求测试地址
#define UpimgURL @"https://"//头像上传地址
#define UploadUrl @"https://"//上传地址

#define DebugLog(format, ...) NSLog((@"调试：[函数名:%s]" "[行号:%d]\n" format), __FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

/**************************** 正式模式 ****************************/
#import "SafeKit.h"
#define MainUrl @"https://"     //网络请求测试地址
#define UpimgURL @"https://"//头像上传地址
#define UploadUrl @"https://"//上传地址
#define DebugLog(xx, ...)
#endif


/**************************** Config ****************************/
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kAppBunbleID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define isEmpty(x) [NSObject isEmpty:x]
#define kCornerRadius2 3
#define kDefaultUserIMG [UIImage imageNamed:@"MyCenter_yaoqing_lp_icon"]
/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/**************************** Frame ****************************/
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kSCREEN_BOUNDS [UIScreen mainScreen].bounds
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kdefaultUserAvatar [UIImage imageNamed:@"icon_default_user"]
#define kHEIGHT_STATUSBAR            20.0f
#define kHEIGHT_TABBAR               49.0f
#define kHEIGHT_NAVBAR               44.0f
#define kPidding                     20.f


/**************************** iPhoneX & iOS 11****************************/
#define SafeAreaTopHeight (kSCREEN_HEIGHT == 812.0 ? 88 : 64)
#define SafeAreaBottomHeight (kSCREEN_WIDTH == 812.0 ? 44 : 0)

#define  AdjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

/**************************** Color ****************************/

#define kMainBlueColor [UIColor colorWithHexString:@"044893"]
#define kMainBluepressColor [UIColor colorWithHexString:@"044893"]
#define kMainbackgroundColor [UIColor colorWithHexString:@"F5F5F5"]//背景色
#define k33Colr [UIColor colorWithHexString:@"333333"]
#define kLineColor  [UIColor colorWithHexString:@"E7E7E7"]//分割线灰色
#define kCellPressColor  [UIColor colorWithHexString:@"＃3091D0"]//点击的灰色效果颜色
#define kMainGoldColor [UIColor colorWithHexString:@"d0b66a"]//主题金色

/**************************** 设备相关 ****************************/
#define IOS8            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
#define isX ([UIScreen mainScreen].bounds.size.height == 812)

#define kDevice_Is_iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6sPlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define dispatch_sync_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

//dispatch_async_main_safe(^{
//
//});
#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#define kTipAlert(_title_, _msg_, _cancel_, _done_,...)     [[[UIAlertView alloc] initWithTitle[NSString stringWithFormat:(_title_), ##__VA_ARGS__] message:[NSString stringWithFormat:(_msg_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:[NSString stringWithFormat:(_cancel_), ##__VA_ARGS__] otherButtonTitles:[NSString stringWithFormat:(_done_), ##__VA_ARGS__]] show]

#endif /* Config_h */
