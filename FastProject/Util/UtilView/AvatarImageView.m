//
//  SDAvatarImageView.m
//  SDKit
//
//  Created by wbo on 15/2/10.
//  Copyright (c) 2016年 Netease. All rights reserved.
//

#import "AvatarImageView.h"
#import "UIView+WB.h"
#import "UIImage+Color.h"
#import "objc/runtime.h"
#import "UIView+WebCacheOperation.h"

static char imageURLKey;

@interface AvatarImageView()
@property (nonatomic, copy) void(^tapAction)(id);

@end

@implementation AvatarImageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor clearColor];
    self.layer.geometryFlipped = YES;
    self.clipPath = YES;
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        [self setNeedsDisplay];
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self setNeedsDisplay];
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
}

- (CGPathRef)path {
    return [[UIBezierPath bezierPathWithRoundedRect:self.bounds
                                       cornerRadius:CGRectGetWidth(self.bounds) / 2] CGPath];
}
#pragma mark -添加点击手势
- (void)addTapBlock:(void(^)(id obj))tapAction{
    self.tapAction = tapAction;
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
}
- (void)tap{
    if (self.tapAction) {
        self.tapAction(self);
    }
}


#pragma mark Draw
- (void)drawRect:(CGRect)rect
{
    if (!self.width || !self.height) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    if (_clipPath)
    {
        CGContextAddPath(context, [self path]);
        CGContextClip(context);
    }
    UIImage *image = _image;
    if (image && image.size.height && image.size.width) {
        //ScaleAspectFill模式
        CGPoint center   = CGPointMake(self.width * .5f, self.height * .5f);
        //哪个小按哪个缩
        CGFloat scaleW   = image.size.width  / self.width;
        CGFloat scaleH   = image.size.height / self.height;
        CGFloat scale    = scaleW < scaleH ? scaleW : scaleH;
        CGSize  tmpSize     = CGSizeMake(image.size.width / scale, image.size.height / scale);
        
        CGRect  drawRect = NIMKit_CGRectWithCenterAndSize(center, tmpSize);
        CGContextDrawImage(context, drawRect, image.CGImage);
    }
    // 是否添加边框
    if (self.borderWidth != 0) {
        // 创建内边框路径
        UIBezierPath * ovalPath = [UIBezierPath bezierPathWithOvalInRect:rect];
        // 设置边框颜色
        [self.borderColor setStroke];
        // 设置边框宽度
        ovalPath.lineWidth = self.borderWidth;

        [ovalPath stroke];

        CGContextAddPath(context, ovalPath.CGPath);
    }
    
    CGContextRestoreGState(context);
    
}




CGRect NIMKit_CGRectWithCenterAndSize(CGPoint center, CGSize size){
    return CGRectMake(center.x - (size.width/2), center.y - (size.height/2), size.width, size.height);
}

@end


@implementation AvatarImageView (SDWebImageCache)

- (void)nim_setImageWithURL:(NSURL *)url {
    [self nim_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)nim_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self nim_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)nim_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options {
    [self nim_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)nim_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock {
    [self nim_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)nim_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock {
    [self nim_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}

- (void)nim_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock {
    [self nim_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)nim_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock {
    [self nim_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (!(options & SDWebImageDelayPlaceholder)) {
        dispatch_main_async_safe(^{
            self.image = placeholder;
        });
    }
    
    if (url) {
        __weak __typeof(self)wself = self;
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                if (!wself) return;
                if (image && (options & SDWebImageAvoidAutoSetImage) && completedBlock)
                {
                    completedBlock(image, error, cacheType, url);
                    return;
                }
                else if (image) {
                    wself.image = image;
                    [wself setNeedsLayout];
                } else {
                    if ((options & SDWebImageDelayPlaceholder)) {
                        wself.image = placeholder;
                        [wself setNeedsLayout];
                    }
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
        [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
    } else {
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, SDImageCacheTypeNone, url);
            }
        });
    }
}

- (void)nim_setImageWithPreviousCachedImageWithURL:(NSURL *)url andPlaceholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock {
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    UIImage *lastPreviousCachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    
    [self nim_setImageWithURL:url placeholderImage:lastPreviousCachedImage ?: placeholder options:options progress:progressBlock completed:completedBlock];
}

- (NSURL *)nim_imageURL {
    return objc_getAssociatedObject(self, &imageURLKey);
}


- (void)nim_cancelCurrentImageLoad {
    [self sd_cancelImageLoadOperationWithKey:@"UIImageViewImageLoad"];
}

- (void)nim_cancelCurrentAnimationImagesLoad {
    [self sd_cancelImageLoadOperationWithKey:@"UIImageViewAnimationImages"];
}


@end
