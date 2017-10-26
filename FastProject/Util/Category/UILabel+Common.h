//
//  UILabel+Common.h
//  MoodGood
//
//  Created by WBO on 2017/10/15.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Common)
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


@end
