//
//  UIAlertView+SFExtension.m
//  SFExtension
//
//  Created by 花菜 on 2017/9/14.
//  Copyright © 2017年 Caiflower. All rights reserved.
//

#import "UIAlertView+Extension.h"

NSString * SFClosePresentingAlertViewOptionsAnimationStateKey = @"SFClosePresentingAlertViewOptionsAnimationStateKey";
NSString * SFClosePresentingAlertViewNotication = @"SFClosePresentingAlertViewNotication";

@interface SFAlertViewWrapper : NSObject<UIAlertViewDelegate>

@property (nonatomic, strong) SFAlertViewCompletion completion;
@property (nonatomic, strong) UIAlertView * alertView;

@end

@implementation SFAlertViewWrapper

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showWithTitle:(NSString *)title message:(NSString *)message completion:(SFAlertViewCompletion)completion cancleButtonTitle:(NSString *)cancleButtonTitle otheButtonTitles:(NSArray <NSString *> *)otherButtonTitles
{
    CFRetain((__bridge CFTypeRef)self);
    self.completion = completion;
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancleButtonTitle otherButtonTitles:nil];
    for (NSString * title in otherButtonTitles) {
        [alertView addButtonWithTitle:title];
    }
    [alertView show];
    self.alertView = alertView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closePresentingAlertNotifacation:) name:SFClosePresentingAlertViewNotication object:nil];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.completion) {
        self.completion(buttonIndex, [alertView buttonTitleAtIndex:buttonIndex]);
    }
    self.alertView = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        CFRelease((__bridge CFTypeRef)self);
    });
}

- (void)closePresentingAlertNotifacation:(NSNotification *)notify
{
    NSNumber * animated = [notify.userInfo objectForKey:SFClosePresentingAlertViewOptionsAnimationStateKey];
    [self.alertView dismissWithClickedButtonIndex:0 animated:[animated boolValue]];
    [self alertView:self.alertView clickedButtonAtIndex:0];
}

@end

#define kInputFieldPortraitY 75
#define kInputFieldLandscapeY 57

@interface SFAlertViewInputWrapper : NSObject<UIAlertViewDelegate>
@property (nonatomic, strong) UIAlertView * alertView;
@property (nonatomic, strong) UITextField * addedTextField;
@property (nonatomic, assign) BOOL useCustomTextField;
@property (nonatomic, copy) void(^completion)(NSString *,BOOL);
@end

@implementation SFAlertViewInputWrapper

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showWithTitle:(NSString *)title message:(NSString *)message secureTextEntry:(BOOL)secureTextEntry clearButtonModel:(UITextFieldViewMode)clearButtonMode cancleButtonTitle:(NSString *)cancleButtonTitle approveButtonTitle:(NSString *)approveButtonTitle completion:(void(^)(NSString * input, BOOL canceled))completion
{
    CFRetain((__bridge CFTypeRef)self);
    self.completion = completion;
    self.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancleButtonTitle otherButtonTitles:approveButtonTitle,nil];
    
    UITextField * textField = nil;
    self.useCustomTextField = ![self.alertView respondsToSelector:@selector(alertViewStyle)];
    if (self.useCustomTextField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(statusBarOrientationDidChangeNotication:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
        textField = [[UITextField alloc] initWithFrame:CGRectMake(10, [self yPositionForCustomTextField], 264, 35)];
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.borderStyle = UITextBorderStyleBezel;
        textField.tag = 1001;
        textField.backgroundColor = [UIColor whiteColor];
        textField.clearButtonMode = clearButtonMode;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.secureTextEntry = secureTextEntry;
        self.addedTextField = textField;
        [self.alertView addSubview:textField];
        
        self.alertView.message =  [NSString stringWithFormat:@"%@\n\n\n",self.alertView.message ? self.alertView.message : @""];;
    }
    else
    {
        self.alertView.alertViewStyle = secureTextEntry ? UIAlertViewStyleSecureTextInput : UIAlertViewStylePlainTextInput;
        [[self.alertView textFieldAtIndex:0] setClearButtonMode:clearButtonMode];
        [self.alertView textFieldAtIndex:0].contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    }
    
    [self.alertView show];
    [textField becomeFirstResponder];
}

- (UITextField *)inputTextField
{
    return self.useCustomTextField ? self.addedTextField : [self.alertView textFieldAtIndex:0];
}

- (void)statusBarOrientationDidChangeNotication:(NSNotification *)notify
{
    CGRect tmpRect = self.addedTextField.frame;
    tmpRect.origin.y = [self yPositionForCustomTextField];
    [UIView animateWithDuration:0.25f animations:^{
        self.addedTextField.frame = tmpRect;
    }];
}

- (CGFloat)yPositionForCustomTextField
{
   return  UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? kInputFieldLandscapeY : kInputFieldPortraitY;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString * text = nil;
    if (self.useCustomTextField) {
        UITextField * textField = (UITextField *)[alertView viewWithTag:1001];
        text = textField.text;
    }
    else
    {
        text = [self.alertView textFieldAtIndex:0].text;
    }
    if (self.completion) {
        self.completion(text, buttonIndex == 0);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        CFRelease((__bridge CFTypeRef)self);
    });
    
}

@end

@implementation UIAlertView (SFExtension_quickAlert)

+ (void)al_dismissPresentingAnimated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SFClosePresentingAlertViewNotication
                                                        object:nil
                                                      userInfo:@{
                                                                 SFClosePresentingAlertViewNotication :
                                                                     [NSNumber numberWithBool:animated]
                                                                 }];
}

+ (UIAlertView *)al_alertWithTitle:(NSString *)title
                           message:(NSString *)message
                        completion:(SFAlertViewCompletion)completion
                 cancleButtonTitle:(NSString *)cancleButtonTitle
                 otherButtonTitles:(NSString *)otherButtonTitles,...
{
    NSMutableArray * titleList = [NSMutableArray array];
    va_list params;
    va_start(params, otherButtonTitles);
    for (id item = otherButtonTitles; item != nil; item = va_arg(params, id)) {
        [titleList addObject:item];
    }
    va_end(params);
    return [self al_alertWithTitle:title message:message completion:completion cancleButtonTitle:cancleButtonTitle otherButtonTitleList:titleList];
}

+ (UIAlertView *)al_alertWithTitle:(NSString *)title
                           message:(NSString *)message
                       completion :(SFAlertViewCompletion)completion
                 cancleButtonTitle:(NSString *)cancleButtonTitle
              otherButtonTitleList:(NSArray<NSString *> *)otherButtonTitleList
{
    SFAlertViewWrapper * alert = [[SFAlertViewWrapper alloc] init];
    
    [alert showWithTitle:title message:message completion:completion cancleButtonTitle:cancleButtonTitle otheButtonTitles:otherButtonTitleList];
    return alert.alertView;
}

+ (UIAlertView *)al_alertWithTitle:(NSString *)title message:(NSString *)message completion:(void(^)())completion
{
    return [self al_alertWithTitle:title message:message completion:^(NSInteger buttonIndex, NSString *buttonTitle) {
        if (completion) {
            completion();
        }
    } cancleButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
}

+ (UIAlertView *)al_alertWithMessage:(NSString *)message completion:(void(^)())completion
{
    return [self al_alertWithTitle:@"" message:message completion:completion];
}
@end


@implementation UIAlertView (SFExtension_confirm)

+ (UIAlertView *)al_confirmWithTitle:(NSString *)title
                             message:(NSString *)message
                             approve:(void(^)())approve
{
    return [self al_confirmWithTitle:title message:message approve:approve cancle:nil];
}

+ (UIAlertView *)al_confirmWithTitle:(NSString *)title message:(NSString *)message approve:(void(^)())approve cancle:(void(^)())cancle
{
    return [self al_alertWithTitle:title message:message completion:^(NSInteger buttonIndex, NSString *buttonTitle) {
        if (buttonIndex == 0) {
            if (cancle) {
                cancle();
            }
        }
        else if (buttonIndex == 1)
        {
            if (approve) {
                approve();
            }
        }
        
        
    } cancleButtonTitle:NSLocalizedString(@"Cancle", nil) otherButtonTitles:NSLocalizedString(@"OK", nil),nil];
}

@end

@implementation UIAlertView (SFExtension_input)

+ (UITextField *)al_inputWithTitle:(NSString *)title
                           message:(NSString *)message
                 canaleButtonTitle:(NSString *)canaleButtonTitle
                approveButtonTitle:(NSString *)approveButtonTitle
                        completion:(void(^)(NSString * input,BOOL cancled))completion
{
    return [self al_inputWithTitle:title message:message secureTextEntry:NO canaleButtonTitle:canaleButtonTitle approveButtonTitle:approveButtonTitle completion:completion];
}

+ (UITextField *)al_inputWithTitle:(NSString *)title
                           message:(NSString *)message
                   secureTextEntry:(BOOL)secureTextEntry
                 canaleButtonTitle:(NSString *)canaleButtonTitle
                approveButtonTitle:(NSString *)approveButtonTitle
                        completion:(void(^)(NSString * input,BOOL cancled))completion
{
    SFAlertViewInputWrapper * wrapper = [[SFAlertViewInputWrapper alloc] init];
    [wrapper showWithTitle:title message:message secureTextEntry:secureTextEntry clearButtonModel:UITextFieldViewModeWhileEditing cancleButtonTitle:canaleButtonTitle approveButtonTitle:approveButtonTitle completion:completion];
    return [wrapper inputTextField];
    
}
@end



@implementation UIAlertView (SFExtension)
- (UILabel *)al_messageLabel
{
    UILabel * messageLabel = nil;
    
    for (UIView * view in [self subviews]) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel * label = (UILabel *)view;
            if (label.text == self.message) {
                messageLabel = label;
                break;
            }
        }
    }
    return messageLabel;
}


- (UILabel *)al_titleLabel
{
    UILabel * titleLabel = nil;
    
    for (UIView * view in [self subviews]) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel * label = (UILabel *)view;
            if (label.text == self.title) {
                titleLabel = label;
                break;
            }
        }
    }
    return titleLabel;
}

@end
