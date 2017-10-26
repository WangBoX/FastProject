//
//  UIImage+Color.h
//  QP_iOS
//
//  Created by ios on 16/6/24.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)


+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

//压缩图片
+(NSData *)imageData:(UIImage *)myimage;

@end








