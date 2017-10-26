//
//  EmptyDataManager.m
//  MoodGood
//
//  Created by WBO on 2017/9/19.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import "EmptyDataManager.h"

@implementation EmptyDataManager

/*
 * 空数据title
 */
+ (NSAttributedString *)titleForEmptyView{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (self.netStatus == NotReachable) {
        text = @"没有网络连接,请检查网络重新连接";
    }else{
        text = @"当前没有相关信息";
    }
    textColor = [UIColor colorWithHexString:@"7b8994"];
    font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.5];
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

/*
 * 空数据description
 */
+ (NSAttributedString *)descriptionForEmptyView:(NSString *)des{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    if (self.netStatus == NotReachable) {
        text = @"";
    }else{
        text = @"";
    }
    font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.5];
    textColor = [UIColor colorWithHexString:@"7b8994"];
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attributedString;
}

/*
 * 空页面加载数据动画
 */
+ (CAAnimation *)imageAnimationForEmptyView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

/*
 * 空页面 加载按钮 文字
 */
+ (NSAttributedString *)buttonTitleForEmptyViewForState:(UIControlState)state
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    if (self.netStatus == NotReachable) {
        text = @"重新连接";
    }else{
        text = @"";
    }
    font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    textColor = [UIColor colorWithHexString:(state == UIControlStateNormal) ? @"007ee5" : @"48a1ea"];
    if (!text) {
        return nil;
    }
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

/*
 * 空页面 加载按钮 图片
 */
+ (UIImage *)buttonBackgroundImageForEmptyViewForState:(UIControlState)state{
    return nil;
}

+ (UIColor *)backgroundColorForEmptyView{
    return kMainbackgroundColor;
}

+ (CGFloat)verticalOffsetForEmptyView{
    return 10.0;
}

+ (CGFloat)spaceHeightForEmptyView{
    return 0.0;
}

+ (UIImage *)imageForEmptyView
{
    NSString *imageName = [NSString stringWithFormat:@""];
    if (self.netStatus == NotReachable) {
        imageName = @"no_status_icon";
    }else{
        imageName = @"no_content_icon";
    }
    UIImage *image = [UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    return image;
}


#pragma mark--如下--外层业务自己控制【加载loading状态】 与 【请求逻辑】
/*
 
 @property (nonatomic, getter=isLoading) BOOL loading;
 - (void)setLoading:(BOOL)loading
 {
 if (self.isLoading == loading) {
 return;
 }
 
 _loading = loading;
 
 [self.tableView reloadEmptyDataSet];
 }


#pragma mark - DZNEmptyDataSetSource Methods

#pragma mark - DZNEmptyDataSetDelegate Methods
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView{
    return self.loading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    self.loading = YES;
    [self request];
    
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.loading = YES;
    [self request];
}

 - (void)request{
 [self requestSuccess:^(NSURLSessionDataTask *task, NSArray *datas, BOOL noMoreData) {
 
 self.loading = NO;
 [self.tableView reloadData];
 
 } failure:^(NSURLSessionDataTask *task, ZJNetResponse *response) {
 @strongify(self);
 self.loading = NO;
 
 }];
 
 }

 */


@end
