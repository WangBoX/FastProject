//
//  NSString+Common.m
//  MoodGood
//
//  Created by WBO on 2017/9/18.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)



+ (NSString *)textFieldDidChangedTextLimit:(NSInteger)index textField:(UITextField *)textField{
    NSString *text = textField.text;
    NSString *result = nil;
    // 拼音输入时，拼音字母处于选中状态，此时不判断是否超长
    UITextRange *selectedRange = [textField markedTextRange];
    if (!selectedRange || !selectedRange.start) {
        if ([NSString getStringLength:text] > index) {
            
            textField.text = [NSString subStringTo:index withString:text];
            result = [NSString subStringTo:index withString:text];
        }else{
            result = text;
        }
    }
    return result;
}

+ (NSInteger)getStringLength:(NSString *)string{
    NSInteger length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    length -= (length - string.length) / 2;
    NSLog(@"%ld", (long)length);
    return length;
}

+ (NSString *)subStringTo:(NSInteger)index withString:(NSString *)string{
    NSString *result = nil;
    
    if ([NSString getStringLength:string] <= index) {
        result = string;
    }else{
        for (int count = 0; count <= string.length; count++) {
            if (string.length > count) {
                if ([NSString getStringLength:result] < index) {
                    result = [string substringToIndex:count];
                }
            }
        }
    }
    return result;
}


@end
