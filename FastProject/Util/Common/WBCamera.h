//
//  WBCamera.h
//  QP_iOS
//
//  Created by ios on 16/6/27.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WBCamera : NSObject


/**
 * 检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkPhotoLibraryAuthorizationStatus;

/**
 * 检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkCameraAuthorizationStatus;

@end
