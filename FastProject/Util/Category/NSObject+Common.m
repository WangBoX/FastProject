//
//  NSObject+Common.m
//  QP_iOS
//
//  Created by ios on 16/6/16.
//  Copyright © 2016年 WBO. All rights reserved.
//


#import "NSObject+Common.h"
#import <CommonCrypto/CommonCrypto.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"

static NSString *hudStr = @"tmpHUD";

@interface NSObject ()
@property (nonatomic, strong) MBProgressHUD *tmp_hud;
@end

@implementation NSObject (Common)


/**
 *  显示str－－1秒
 *
 *  @param tipStr str
 *
 *
 */
+ (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr &&tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES hasGraceTime:NO];
        CGRect rect = [tipStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 15.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15.0]} context:nil];
        hud.minSize = CGSizeMake(rect.size.width + 50, 15 + 36);
        hud.mode = MBProgressHUDModeText;
        hud.userInteractionEnabled = YES;
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15];
        hud.detailsLabel.text = tipStr;
        hud.detailsLabel.textColor = [UIColor whiteColor];
        hud.margin = 0.f;
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.removeFromSuperViewOnHide = YES;
        if (tipStr.length > 8) {
            [hud hideAnimated:YES afterDelay:1.f];
        }else {
            [hud hideAnimated:YES afterDelay:0.8f];
        }
    }
}

/**
 *  显示str
 *
 *  @param tipStr str
 *
 *  delay 延长时间
 */
+ (void)showHudTipStr:(NSString *)tipStr withTime:(NSTimeInterval)delay{
    if (tipStr &&tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES hasGraceTime:NO];
        CGRect rect = [tipStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 15.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15.0]} context:nil];
        hud.minSize = CGSizeMake(rect.size.width + 50, 15 + 36);
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabel.text = tipStr;
        hud.detailsLabel.textColor = [UIColor whiteColor];
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.margin = 10.f;
        hud.layer.cornerRadius = 4.f;
        
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:delay];
    }
}



/**
 *  str－－载入转圈
 *  @param titleStr str
 */
+ (instancetype)showHUDQueryStr:(NSString *)titleStr{
    if (!titleStr.length) {
        [NSObject showWaitHUD];
        
    }else {
        
        [NSObject showWaitWithTip:titleStr];
    }
    return nil;
}

+ (NSUInteger)hideHUDQuery{
    [NSObject hideWaitHUD];
    return 0;
}

+(BOOL) isEmpty:(id )data {
    
    if (!data || data == (id)kCFNull) {
        return true;
    }else if ([data isKindOfClass:[NSArray class]]){//数组空
        NSArray *arr = data;
        if (!arr ||arr == (id)kCFNull || arr.count <= 0) {
            return true;
        }
        return false;
    }else if ([data isKindOfClass:[NSDictionary class]]){
        NSDictionary *dic = data;
        
        if (!dic || dic == (id)kCFNull || ([dic isEqual:[NSNull null]]) || (dic.count == 0)) {
            return true;
        }
        return false;
    }else {//空格判断
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *str = [NSString stringWithFormat:@"%@", data];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else if (data == nil||[data isEqual:[NSNull null]]) {
            return true;
        }else {
            return false;
        }
    }
}

#pragma mark BaseURL
+ (NSString *)baseURLStr{
    return MainUrl;
}

#pragma mark -带图标提示
+ (void)showSuccessWithTip:(NSString *)tip {
    [NSObject showSuccessWithTip:tip finalAction:nil after:0];
}

+ (void)showSuccessWithTip:(NSString *)tip finalAction:(void(^)())actionBlock after:(NSTimeInterval)delay {
    [NSObject showHUDWithTip:tip Image:[UIImage imageNamed:@"success_tip_image"] finalAction:actionBlock after:delay];
}

+ (void)showFailureWithTip:(NSString *)tip {
    [NSObject showFailureWithTip:tip finalAction:nil after:0];
}

+ (void)showFailureWithTip:(NSString *)tip finalAction:(void(^)())actionBlock after:(NSTimeInterval)delay {
    [NSObject showHUDWithTip:tip Image:[UIImage imageNamed:@"failure_tip_image"] finalAction:actionBlock after:delay];
}

+ (void)showHUDWithTip:(NSString *)tip Image:(UIImage *)image finalAction:(void(^)())actionBlock after:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES hasGraceTime:NO];
    hud.mode = MBProgressHUDModeCustomView;
    hud.margin = 26.0;
    [hud setValue:@11.15 forKey:@"paddingOffset"];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    hud.customView = imageView;
    hud.label.text = tip;
    hud.label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    hud.minSize = CGSizeMake(120, 120);
    hud.completionBlock = actionBlock;
    [hud.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15.0);
    }];
    if (delay == 0) {
        [hud hideAnimated:YES afterDelay:1.0];
    }else {
        [hud hideAnimated:YES afterDelay:delay];
    }
}

/**
 *
 *  hasGraceTime 是否有1.5秒的延迟
 *  菊花载入中，蒙板
 */
+ (void)showHUDWithGraceTime:(BOOL)hasGraceTime {
    if (self.tmp_hud) {
        [self hideWaitHUD];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES hasGraceTime:hasGraceTime];
    self.tmp_hud = hud;
    hud.minSize = CGSizeMake(79, 79);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.tmp_hud isEqual:hud]) {
            [self hideWaitHUD];
        }
    });
}


/**
 *
 *  hasGraceTime 是否有1.5秒的延迟
 *  菊花载入中，蒙板是否会隐藏
 */
+ (void)showHUDWithTip:(NSString *)tip GraceTime:(BOOL)hasGraceTime Hide:(BOOL)hide{
    if (self.tmp_hud) {
        [self hideWaitHUD];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES hasGraceTime:hasGraceTime];
    self.tmp_hud = hud;
    hud.label.text = tip;
    hud.minSize = CGSizeMake(79, 79);
    if (hide) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.tmp_hud isEqual:hud]) {
                [self hideWaitHUD];
                //                [self showHudTipStr:@"网络不给力，请稍等"];
            }
        });
    }
}


+ (void)showWaitHUDWithTimeout:(NSTimeInterval)timeout {
    if (self.tmp_hud) {
        [self hideWaitHUD];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES hasGraceTime:NO];
    self.tmp_hud = hud;
    hud.minSize = CGSizeMake(79, 79);
    if (timeout != 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.tmp_hud isEqual:hud]) {
                [self hideWaitHUD];
                //                [self showHudTipStr:@"网络不给力"];
            }
        });
    }
}

+ (void)showWaitHUD{
    [self showHUDWithGraceTime:NO];
}


/**
 *
 *  view 添加到的view
 *  rect 范围
 */
+ (void)showWaitHUDAddedTo:(UIView *)view withRect:(CGRect)rect animated:(BOOL)animated {
    if (self.tmp_hud) {
        [self hideWaitHUD];
    }
    NSAssert(view, @"View must not be nil.");
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:rect];
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    [hud setValue:[UIColor whiteColor] forKey:@"activityIndicatorColor"];
    hud.contentColor = [UIColor whiteColor];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    [view addSubview:hud];
    [hud showAnimated:animated];
    self.tmp_hud = hud;
}

+ (void)showWaitWithTip:(NSString *)tip {
    if (self.tmp_hud) {
        return;
    }
    tip = tip.length > 0 ? tip : @"正在加载";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES hasGraceTime:YES];
    self.tmp_hud = hud;
    hud.minSize = CGSizeMake(120, 120);
    hud.margin = 26.0;
    [hud setValue:@11.15 forKey:@"paddingOffset"];
    hud.label.text = tip;
    hud.label.font = [UIFont boldSystemFontOfSize:15.0];
    [hud.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15.0);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.tmp_hud isEqual:hud]) {
            [self hideWaitHUD];
        }
    });
}
+ (void)showWaitNoTimeoutWithTip:(NSString *)tip {
    if (self.tmp_hud) {
        return;
    }
    tip = tip.length > 0 ? tip : @"正在加载";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES hasGraceTime:YES];
    self.tmp_hud = hud;
    hud.minSize = CGSizeMake(120, 120);
    hud.margin = 26.0;
    [hud setValue:@11.15 forKey:@"paddingOffset"];
    hud.label.text = tip;
    hud.label.font = [UIFont boldSystemFontOfSize:15.0];
    [hud.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15.0);
    }];
}

+ (void)showWaitWithTip:(NSString *)tip task:(void(^)())taskBlock {
    if (self.tmp_hud) {
        return;
    }
    [NSObject showWaitWithTip:tip];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        taskBlock();
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tmp_hud hideAnimated:YES];
        });
    });
}

+ (void)showWaitWithTip:(NSString *)tip withDuration:(NSTimeInterval)duration finalAction:(void(^)())finalBlock {
    if (self.tmp_hud) {
        return;
    }
    [NSObject showWaitWithTip:tip];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.tmp_hud) {
            [self hideWaitHUD];
        }
    });
    self.tmp_hud.completionBlock = finalBlock;
}

+ (void)hideWaitHUD {
    if (!self.tmp_hud) {
        return;
    }
    [self.tmp_hud hideAnimated:YES];
    self.tmp_hud = nil;
}

//判断是否是纯数字
+ (BOOL)isPureNumberWithString:(NSString *)string {
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (string.length > 0) {
        return NO;
    }
    return YES;
}


#pragma mark Net  Error
- (ZJNetResponse *)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError{
    ZJNetResponse *response = [ZJNetResponse mj_objectWithKeyValues:responseJSON];
    if (!response.success) {
        [self handleMsgCode:response autoShowError:autoShowError];
    }
    return response;
}

- (ZJNetResponse *)handleNetFail:(NSError *)error{
    ZJNetResponse *response = [[ZJNetResponse alloc] init];
    response.noResponse = YES;
    dispatch_async_main_safe(^{
        [NSObject showHudTipStr:@"网络连接有问题，请检查手机是否联网"];
    });
    return response;
}

//处理msgInfo
- (void)handleMsgCode:(ZJNetResponse *)response autoShowError:(BOOL)autoShowError{
    
    NSInteger code = response.msgCode.integerValue;
    switch (code) {
        case error_sys://系统异常
            break;
        case error_business://业务异常
            
            
            break;

        default:
            //todo:全部多状态码处理
            
            
            break;
    }
}


#pragma mark - 跳转业务


//获取一个随机整数，范围在[from,to]，包括from，包括to
-(int)getRandomNumber:(NSUInteger)from to:(NSUInteger)to{
    return (int)(from + (arc4random() % (to - from + 1)));
}

- (NetworkStatus)netStatus{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    return reachability.currentReachabilityStatus;
}


#pragma -方法存取器
- (void)setTmp_hud:(MBProgressHUD *)tmp_hud {
    objc_setAssociatedObject(self, &hudStr, tmp_hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (instancetype)tmp_hud {
    return objc_getAssociatedObject(self, &hudStr);
}

@end



