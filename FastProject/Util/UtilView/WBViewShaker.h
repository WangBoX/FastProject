//
//  WBViewShaker.h
//  WBO
//
//  Created by ios on 16/7/26.
//  Copyright © 2016年 WBO. All rights reserved.
//
#import <Foundation/Foundation.h>


@interface WBViewShaker : NSObject

- (instancetype)initWithView:(UIView *)view;
- (instancetype)initWithViewsArray:(NSArray *)viewsArray;

- (void)shake;
- (void)shakeWithDuration:(NSTimeInterval)duration completion:(void (^)())completion;

@end
