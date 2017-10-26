//
//  WBWaveView.h
//  MoodGood
//
//  Created by WBO on 2017/10/18.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WWWaveBlock)(CGFloat currentY);

@interface WBWaveView : UIView
/**
 *  浪弯曲度
 */
@property (nonatomic, assign) CGFloat waveCurvature;
/**
 *  浪速
 */
@property (nonatomic, assign) CGFloat waveSpeed;
/**
 *  浪高
 */
@property (nonatomic, assign) CGFloat waveHeight;
/**
 *  实浪颜色
 */
@property (nonatomic, strong) UIColor *realWaveColor;
/**
 *  遮罩浪颜色
 */
@property (nonatomic, strong) UIColor *maskWaveColor;

@property (nonatomic, copy) WWWaveBlock waveBlock;

//外面配置的方法
- (void)setCurvature:(CGFloat)curvature speet:(CGFloat)speed height:(CGFloat)height;
- (void)setRealWaveColor:(UIColor *)realColor maskWaceColor:(UIColor *)maskColor;

- (void)stopWaveAnimation;

- (void)startWaveAnimation;
@end
