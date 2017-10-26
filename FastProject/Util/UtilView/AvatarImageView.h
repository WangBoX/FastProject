//
//  SDAvatarImageView.h
//  SDKit
//
//  Created by wbo on 15/2/10.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"
#import "SDWebImageCompat.h"

@interface AvatarImageView : UIControl
@property (nonatomic,strong)    UIImage *image;

@property (nonatomic,assign)    BOOL    clipPath;
/// 边框宽度
@property (nonatomic, assign) CGFloat borderWidth;
/// 边框颜色
@property (nonatomic, strong) UIColor * borderColor;
//添加点击手势
- (void)addTapBlock:(void(^)(id obj))tapAction;

@end


@interface AvatarImageView (SDWebImageCache)
- (NSURL *)nim_imageURL;

- (void)nim_setImageWithURL:(NSURL *)url;
- (void)nim_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)nim_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options;
- (void)nim_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock;
- (void)nim_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;
- (void)nim_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock;
- (void)nim_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;
- (void)nim_setImageWithPreviousCachedImageWithURL:(NSURL *)url andPlaceholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;
- (void)nim_cancelCurrentImageLoad;
- (void)nim_cancelCurrentAnimationImagesLoad;
@end
