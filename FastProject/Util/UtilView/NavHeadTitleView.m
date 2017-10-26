//
//  NavHeadTitleView.m
//  MoodGood
//
//  Created by WBO on 2017/10/16.
//  Copyright © 2017年 MoodGood. All rights reserved.
//  WBoX

#import "NavHeadTitleView.h"

@implementation NavHeadTitleView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.headBgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.headBgView.backgroundColor=kMainBlueColor;
        
        //隐藏黑线
        self.headBgView.alpha=0;
        [self addSubview:self.headBgView];
        
        self.back=[UIButton buttonWithType:UIButtonTypeCustom];
        self.back.backgroundColor=[UIColor clearColor];
        self.back.frame=CGRectMake(20, 20,  100, 40);
        [self.back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.back];
        [self adpatViews];
        
        UITapGestureRecognizer *single = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
        UIView *singView = [[UIView alloc] init];
        singView.backgroundColor = [UIColor clearColor];
        singView.frame = CGRectMake(0, 0, 40, 66);
        [self addSubview:singView];
        [singView addGestureRecognizer:single];
        
        
        self.backgroundColor=[UIColor clearColor];
        self.label=[[UILabel alloc]initWithFrame:CGRectMake(44, 20, frame.size.width-44-44, 44)];
        self.label.textAlignment=NSTextAlignmentCenter;
        self.label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        [self addSubview:self.label];
        
        _activytyView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:_activytyView];
        
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.backgroundColor = [UIColor clearColor];
        self.rightBtn.frame = CGRectMake(self.frame.size.width-46, 30, 44, 30);
        [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        self.rightBtn.titleLabel.textAlignment =1;
        [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview:self.rightBtn];
        
        
    }
    return self;
}


- (void)adpatViews {
    
//    [self.back.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.back.mas_left).offset(-8);
//        make.centerY.equalTo(self.back.mas_centerY);
//        make.width.mas_equalTo(13);
//        make.height.mas_equalTo(21.5);
//    }];
    
//    [self.back.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.back.imageView.mas_right).offset(10);
//        make.centerY.equalTo(self.back.imageView.mas_centerY);
//    }];
    
    self.back.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
}


-(void)setBackTitleImage:(NSString *)backTitleImage
{
    _backTitleImage=backTitleImage;
    [self.back setImage:[UIImage imageNamed:_backTitleImage] forState:UIControlStateNormal];
}
-(void)setRightImageView:(NSString *)rightImageView
{
    _rightImageView=rightImageView;
    [self.rightBtn setImage:[UIImage imageNamed:_rightImageView] forState:UIControlStateNormal];
    //[self.rightBtn setTitle:rightImageView forState:UIControlStateNormal];
}
-(void)setRightTitleImage:(NSString *)rightImageView
{
    _rightImageView=rightImageView;
    [self.rightBtn setImage:[UIImage imageNamed:_rightImageView] forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title{
    _title=title;
    self.label.text=title;
}

- (void)setTitleColor:(UIColor *)titleColor{    
    _titleColor = titleColor;
    self.label.textColor = _titleColor;
}


//返回按钮
-(void)backClick{
    if ([_delegate respondsToSelector:@selector(NavHeadback)] ) {
        [_delegate NavHeadback];
    }
}
//右边按钮
-(void)rightBtnClick{
    if ([_delegate respondsToSelector:@selector(NavHeadToRight)]) {
        [_delegate NavHeadToRight];
    }
}
@end
