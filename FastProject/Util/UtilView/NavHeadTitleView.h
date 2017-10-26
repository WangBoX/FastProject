//
//  NavHeadTitleView.h
//  MoodGood
//
//  Created by WBO on 2017/10/16.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavHeadTitleViewDelegate <NSObject>
@optional
- (void)NavHeadback;
- (void)NavHeadToRight;
@end
@interface NavHeadTitleView : UIView

@property(nonatomic,assign)id<NavHeadTitleViewDelegate>delegate;
@property(nonatomic,strong)UIImageView * headBgView;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)UIColor * titleColor;
@property(nonatomic,strong)NSString * backTitleImage;
@property(nonatomic,strong)NSString * rightImageView;
@property(nonatomic,strong)NSString * rightTitleImage;
@property (nonatomic, strong) UIActivityIndicatorView *activytyView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton * back;
@property(nonatomic,strong)UIButton * rightBtn;

@end
