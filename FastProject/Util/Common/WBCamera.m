//
//  WBCamera.m
//  QP_iOS
//
//  Created by ios on 16/6/27.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import "WBCamera.h"
#import <Photos/PHPhotoLibrary.h>
#import <AssetsLibrary/ALAssetsLibrary.h>



@import AVFoundation;


@implementation WBCamera


+ (BOOL)checkPhotoLibraryAuthorizationStatus {
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"请在设置中允许%@访问你的相册", app_Name] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:confirmAction];
        UITabBarController *rootController = (UITabBarController *)kKeyWindow.rootViewController;
        [rootController presentViewController:alertController animated:YES completion:nil];
        return NO;
    }
    return YES;
}

+ (BOOL)checkCameraAuthorizationStatus {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"请在设置中允许%@访问你的相册", app_Name]  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:confirmAction];
        UITabBarController *rootController = (UITabBarController *)kKeyWindow.rootViewController;
        [rootController presentViewController:alertController animated:YES completion:nil];
        return NO;
    }
    
    return YES;
}

@end






