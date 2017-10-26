//
//  WBPickerView.h
//  WBPickerView
//
//  Created by 王博 Mahdjoubi on 6/5/16.
//  Copyright (c) 2016 王博. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const WBbackgroundColor;
extern NSString * const WBtextColor;
extern NSString * const WBtoolbarColor;
extern NSString * const WBbuttonColor;
extern NSString * const WBbuttonCancelTitle;
extern NSString * const WBbuttonDoneTitle;
extern NSString * const WBbuttonCancelImgName;
extern NSString * const WBbuttonDoneImgName;
extern NSString * const WBfont;
extern NSString * const WBvalueY;
extern NSString * const WBtoolbarBackgroundImage;
extern NSString * const WBtextAlignment;
extern NSString * const WBshowsSelectionIndicator;

@interface WBPickerView: UIView 

+(void)showPickerViewInView: (UIView *)view
                withStrings: (NSArray *)strings
         withSelectedObject: (NSString *)selectedObject
                withOptions: (NSDictionary *)options
                 completion: (void(^)(NSString *selectedString))completion;

+(void)showPickerViewInView:(UIView *)view
                withObjects:(NSArray *)objects
         withSelectedObject: (id)selectedObject
                withOptions:(NSDictionary *)options
    objectToStringConverter:(NSString *(^)(id))converter
                 completion:(void (^)(id))completion;

+(void)dismissWithCompletion: (void(^)(NSString *))completion;

@end
