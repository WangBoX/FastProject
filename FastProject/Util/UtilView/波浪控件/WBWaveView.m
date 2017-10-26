//
//  WBWaveView.m
//  MoodGood
//
//  Created by WBO on 2017/10/18.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import "WBWaveView.h"

@interface WBWaveView()
//刷屏器
@property (nonatomic, strong) CADisplayLink *timer;
//真实浪
@property (nonatomic, strong) CAShapeLayer *realWaveLayer;
//遮罩浪
@property (nonatomic, strong) CAShapeLayer *maskWaveLayer;

@property (nonatomic, assign) CGFloat offset;

@end

@implementation WBWaveView

#pragma mark - life cycle
- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self initData];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData{
    //初始化
    self.waveSpeed = 0.5;
    self.waveCurvature = 1.5;
    self.waveHeight = 6;
    self.realWaveColor = [UIColor whiteColor];
    self.maskWaveColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    
    [self.layer addSublayer:self.realWaveLayer];
    [self.layer addSublayer:self.maskWaveLayer];
    
}

- (CAShapeLayer *)realWaveLayer{
    
    if (!_realWaveLayer) {
        _realWaveLayer = [CAShapeLayer layer];
        CGRect frame = [self bounds];
        frame.origin.y = frame.size.height-self.waveHeight;
        frame.size.height = self.waveHeight;
        _realWaveLayer.frame = frame;
        _realWaveLayer.fillColor = self.realWaveColor.CGColor;
        
    }
    return _realWaveLayer;
}

- (CAShapeLayer *)maskWaveLayer{
    
    if (!_maskWaveLayer) {
        _maskWaveLayer = [CAShapeLayer layer];
        CGRect frame = [self bounds];
        frame.origin.y = frame.size.height-self.waveHeight;
        frame.size.height = self.waveHeight;
        _maskWaveLayer.frame = frame;
        _maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
    }
    return _maskWaveLayer;
}

- (void)setWaveHeight:(CGFloat)waveHeight{
    _waveHeight = waveHeight;
    
    CGRect frame = [self bounds];
    frame.origin.y = frame.size.height-self.waveHeight;
    frame.size.height = self.waveHeight;
    _realWaveLayer.frame = frame;
    
    CGRect frame1 = [self bounds];
    frame1.origin.y = frame1.size.height-self.waveHeight;
    frame1.size.height = self.waveHeight;
    _maskWaveLayer.frame = frame1;
    
}

- (void)startWaveAnimation{
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)stopWaveAnimation{
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)wave{
    
    self.offset += self.waveSpeed;
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = self.waveHeight;
    
    //真实浪
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, height);
    CGFloat y = 0.f;
    //遮罩浪
    CGMutablePathRef maskpath = CGPathCreateMutable();
    CGPathMoveToPoint(maskpath, NULL, 0, height);
    CGFloat maskY = 0.f;
    for (CGFloat x = 0.f; x <= width ; x++) {
        y = height * sinf(0.01 * self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(path, NULL, x, y);
        maskY = -y-8;
        CGPathAddLineToPoint(maskpath, NULL, x, maskY);
    }
    
    //变化的中间Y值
    CGFloat centX = self.bounds.size.width/2;
    CGFloat CentY = height * sinf(0.01 * self.waveCurvature *centX  + self.offset * 0.045);
    if (self.waveBlock) {
        self.waveBlock(CentY);
    }
    
    CGPathAddLineToPoint(path, NULL, width, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathCloseSubpath(path);
    self.realWaveLayer.path = path;
    self.realWaveLayer.fillColor = self.realWaveColor.CGColor;
    CGPathRelease(path);
    
    CGPathAddLineToPoint(maskpath, NULL, width, height);
    CGPathAddLineToPoint(maskpath, NULL, 0, height);
    CGPathCloseSubpath(maskpath);
    self.maskWaveLayer.path = maskpath;
    self.maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
    CGPathRelease(maskpath);
    
}

- (void)dealloc{
    
    [self stopWaveAnimation];
    
    if (_realWaveLayer) {
        [_realWaveLayer removeFromSuperlayer];
        _realWaveLayer = nil;
    }
    
    if (_maskWaveLayer) {
        [_maskWaveLayer removeFromSuperlayer];
        _maskWaveLayer = nil;
    }
}
#pragma mark - actions
- (void)setCurvature:(CGFloat)curvature speet:(CGFloat)speed height:(CGFloat)height {
    self.waveSpeed = speed;
    self.waveCurvature = curvature;
    self.waveHeight = height;
}
- (void)setRealWaveColor:(UIColor *)realColor maskWaceColor:(UIColor *)maskColor {
    self.realWaveColor = realColor;
    self.maskWaveColor = maskColor;
}
@end

