//
//  NSString+Common.h
//  MoodGood
//
//  Created by WBO on 2017/9/18.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTEXTLIMIT 12

@interface NSString (Common)


//自动截取textfield的字符为合法长度字符， UITextFieldTextDidChangeNotification监听方法
/*
 *    [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(textFieldDidChanged:)
                name:UITextFieldTextDidChangeNotification
                                    object:textField];
 *
     - (void)textFieldDidChanged:(NSNotification *)notification {
     [NSString textFieldDidChangedTextLimit:kTEXTLIMIT textField:_nickName];
     }
     - (void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
     }
 */
+ (NSString *)textFieldDidChangedTextLimit:(NSInteger)index textField:(UITextField *)textField;

//获取字符串长度，一个汉字或者两个英文字母计长度为2”
+ (NSInteger)getStringLength:(NSString *)string;

//截取字符串，中文算2个字节、其他算1个。index：截取到第几个，
+ (NSString *)subStringTo:(NSInteger)index withString:(NSString *)string;


@end
