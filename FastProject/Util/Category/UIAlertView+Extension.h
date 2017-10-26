//
//  UIAlertView+SFExtension.h
//  SFExtension
//
//  Created by 花菜 on 2017/9/14.
//  Copyright © 2017年 Caiflower. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SFAlertViewCompletion)(NSInteger buttonIndex, NSString * buttonTitle);
@interface UIAlertView (SFExtension_quickAlert)

+ (void)al_dismissPresentingAnimated:(BOOL)animated;

+ (UIAlertView *)al_alertWithTitle:(NSString *)title
                                 message:(NSString *)message
                                completion:(SFAlertViewCompletion)completion
                         cancleButtonTitle:(NSString *)cancleButtonTitle
                         otherButtonTitles:(NSString *)otherButtonTitles,...;

+ (UIAlertView *)al_alertWithTitle:(NSString *)title
                                 message:(NSString *)message
                               completion :(SFAlertViewCompletion)completion
                         cancleButtonTitle:(NSString *)cancleButtonTitle
                      otherButtonTitleList:(NSArray<NSString *> *)otherButtonTitleList;

+ (UIAlertView *)al_alertWithTitle:(NSString *)title
                           message:(NSString *)message
                        completion:(void(^)())completion;

+ (UIAlertView *)al_alertWithMessage:(NSString *)message
                        completion:(void(^)())completion;
@end


@interface UIAlertView (SFExtension_confirm)

+ (UIAlertView *)al_confirmWithTitle:(NSString *)title
                           message:(NSString *)message
                        approve:(void(^)())approve;

+ (UIAlertView *)al_confirmWithTitle:(NSString *)title
                           message:(NSString *)message
                           approve:(void(^)())approve
                            cancle:(void(^)())cancle;
@end

@interface UIAlertView (SFExtension_input)

+ (UITextField *)al_inputWithTitle:(NSString *)title
                           message:(NSString *)message
                 canaleButtonTitle:(NSString *)canaleButtonTitle
                approveButtonTitle:(NSString *)approveButtonTitle
                        completion:(void(^)(NSString * input,BOOL cancled))completion;

+ (UITextField *)al_inputWithTitle:(NSString *)title
                           message:(NSString *)message
                 secureTextEntry:(BOOL)secureTextEntry
                canaleButtonTitle:(NSString *)canaleButtonTitle
                approveButtonTitle:(NSString *)approveButtonTitle
                        completion:(void(^)(NSString * input,BOOL cancled))completion;
@end


@interface UIAlertView (SFExtension)

- (UILabel *)al_messageLabel;


- (UILabel *)al_titleLabel;
@end




