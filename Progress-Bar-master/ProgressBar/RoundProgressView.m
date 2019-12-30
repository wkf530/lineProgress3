//
//  RoundProgressView.m
//  ProgressBar
//
//  Created by Zhang on 2017/12/1.
//  Copyright © 2017年 wangwang. All rights reserved.
//

#import "RoundProgressView.h"

@interface RoundProgressView ()

@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) CAShapeLayer *inCAShapeLayer;

@property (nonatomic, strong) CAShapeLayer *outCAShapeLayer;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;

@property (nonatomic, strong) CALayer *caLayer;
@property (nonatomic, strong) CAGradientLayer *leftGradientLayer;
@property (nonatomic, strong) CAGradientLayer *rightGradientLayer;
@property (nonatomic, strong) CABasicAnimation *caAnimation;

@property (nonatomic, assign) CGFloat lineWidth;

@end

@implementation RoundProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bezierPath = [UIBezierPath bezierPath];
        //
        self.inCAShapeLayer = [CAShapeLayer layer];
        self.inCAShapeLayer.lineWidth = self.lineWidth/2;
        self.inCAShapeLayer.strokeColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1].CGColor;
        self.inCAShapeLayer.fillColor = [UIColor whiteColor].CGColor;
        self.inCAShapeLayer.lineCap = kCALineCapRound;
        [self.layer addSublayer:self.inCAShapeLayer];
        //
        self.outCAShapeLayer = [CAShapeLayer layer];
        self.outCAShapeLayer.lineWidth = self.lineWidth;
        self.outCAShapeLayer.fillColor = [UIColor clearColor].CGColor;
        self.outCAShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.outCAShapeLayer.lineCap = kCALineCapRound;
        //
        self.caLayer = [CALayer layer];
        [self.layer addSublayer:self.caLayer];
        //
        self.leftGradientLayer = [CAGradientLayer layer];
        self.leftGradientLayer.startPoint = CGPointMake(0, 1);
        self.leftGradientLayer.endPoint = CGPointMake(0, 0);
        self.leftGradientLayer.colors = [NSArray arrayWithObjects:(__bridge id)[UIColor colorWithRed:237/255.0 green:199/255.0 blue:109/255.0 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:219.5/255.0 green:181/255.0 blue:100.5/255.0 alpha:1].CGColor, nil];
        [self.caLayer addSublayer:self.leftGradientLayer];
        //
        self.rightGradientLayer = [CAGradientLayer layer];
        self.rightGradientLayer.startPoint = CGPointMake(0, 0);
        self.rightGradientLayer.endPoint = CGPointMake(0, 1);
        self.rightGradientLayer.colors = [NSArray arrayWithObjects:(__bridge id)[UIColor colorWithRed:219.5/255.0 green:181/255.0 blue:100.5/255.0 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:202/255.0 green:163/255.0 blue:92/255.0 alpha:1].CGColor, nil];
        [self.caLayer addSublayer:self.rightGradientLayer];
        //
        [self.caLayer setMask:self.outCAShapeLayer];
    }
    return self;
}

- (CABasicAnimation *)caAnimation {
    if (!_caAnimation) {
        _caAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _caAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        _caAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        _caAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    }
    return _caAnimation;
}

- (CGFloat)lineWidth {
    return 6.0f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //
    [self.bezierPath removeAllPoints];
    [self.bezierPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.width/2 - self.lineWidth startAngle:0 endAngle:M_PI*2 clockwise:YES]];
    self.inCAShapeLayer.path = self.bezierPath.CGPath;
    //
    [self.bezierPath removeAllPoints];
    [self.bezierPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.width/2 - self.lineWidth startAngle:self.startAngle endAngle:self.endAngle clockwise:YES]];
    self.outCAShapeLayer.path = self.bezierPath.CGPath;
    //
    self.leftGradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height);
    self.rightGradientLayer.frame = CGRectMake(self.bounds.size.width/2, 0, self.bounds.size.width/2, self.bounds.size.height);;
}

- (void)setProgress:(CGFloat)progressValue withValueMax:(CGFloat)progressMaxValue {
    if (progressValue > progressMaxValue) progressValue = progressMaxValue;
    
    CGFloat allAngle = (progressValue/progressMaxValue) * M_PI * 2;
    //弧长L＝αr 其中α为圆心角的弧度数,r为圆的半径  α = L/r
    self.startAngle = M_PI_2 + (self.lineWidth/2)/(self.bounds.size.width/2 - self.lineWidth);
    self.endAngle = allAngle + self.startAngle;
    
    [self.outCAShapeLayer removeAllAnimations];
    if (progressMaxValue) {
        self.caAnimation.duration = (progressValue/progressMaxValue)*3.0;
        //添加动画
        [self.outCAShapeLayer addAnimation:self.caAnimation forKey:@"strokeEndAnimation"];
    }
    
    /*
     -setNeedsLayout方法：标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用
     -layoutIfNeeded方法：如果，有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）
     如果要立即刷新，要先调用[view setNeedsLayout]，把标记设为需要布局，然后马上调用[view layoutIfNeeded]，实现布局。
     */
    [self setNeedsLayout];
}

@end
