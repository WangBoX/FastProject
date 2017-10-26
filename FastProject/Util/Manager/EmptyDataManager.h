//
//  EmptyDataManager.h
//  MoodGood
//
//  Created by WBO on 2017/9/19.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmptyDataManager : NSObject
/*
 * 空数据title
 */
+ (NSAttributedString *)titleForEmptyView;

/*
 * 空数据description
 */
+ (NSAttributedString *)descriptionForEmptyView:(NSString *)des;


/*
 * 空页面加载数据动画
 */
+ (CAAnimation *)imageAnimationForEmptyView;

/*
 * 空页面 加载按钮 文字
 */
+ (NSAttributedString *)buttonTitleForEmptyViewForState:(UIControlState)state;

/*
 * 空页面 加载按钮 图片
 */
+ (UIImage *)buttonBackgroundImageForEmptyViewForState:(UIControlState)state;

+ (UIColor *)backgroundColorForEmptyView;

+ (CGFloat)verticalOffsetForEmptyView;

+ (CGFloat)spaceHeightForEmptyView;

+ (UIImage *)imageForEmptyView;

@end
