//
//  StraightProgressView.m
//  ProgressBar
//
//  Created by Zhang on 2017/12/1.
//  Copyright © 2017年 wangwang. All rights reserved.
//

#import "StraightProgressView.h"

@interface StraightProgressView ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *fillView;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, assign) CGFloat percentage;

@end

@implementation StraightProgressView

- (instancetype)initWithFrame:(CGRect)frame  {
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.backView = [self creatView];
        self.backView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        self.backView.layer.borderColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1].CGColor;
        self.backView.layer.borderWidth = 0.5;
        [self addSubview:self.backView];
        //
        self.fillView = [self creatView];
        
    }
    return self;
}

- (void)showColorV{
    [self gradientColorForView:self.fillView];
    [self.backView addSubview:self.fillView];
}
- (UIView *)creatView {
    UIView *view = [[UIView alloc] init];
    view.layer.masksToBounds = YES;
    return view;
}

/*
 CAGradientLayer渐变色，目前只有kCAGradientLayerAxial一个选项，即呈线性变化
 startPoint、endPoint：分别表示渐变层的起始位置和终止位置，这两个点被定义在一个单元坐标空间，[0,0]表示左上角位置，[1,1]表示右下角位置，默认值分别是[0.5,0] and [0.5,1]
 colors：颜色数组，定义渐变层的各个颜色
 locations： 可选的NSNumber数组，决定每个渐变颜色的终止位置，这些值必须是递增的，数组的长度和colors的长度最好一致
 */
- (void)gradientColorForView:(UIView *)view {
    CAGradientLayer *layer = [CAGradientLayer layer];
    self.gradientLayer = layer;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.colors = [NSArray arrayWithObjects:(__bridge id)_startColor.CGColor,(__bridge id)_endColor.CGColor,nil];
//    layer.colors = [NSArray arrayWithObjects:(__bridge id)[UIColor colorWithRed:24/255.0 green:201/255.0 blue:255/255.0 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:147/255.0 blue:255/255.0 alpha:1].CGColor, nil];
    layer.locations = @[@0,@1];
    [view.layer insertSublayer:layer atIndex:0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //
    self.backView.frame = CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 10);
    self.backView.layer.cornerRadius = self.backView.frame.size.height/2;
    //
    self.fillView.frame = CGRectMake(0, 0, self.backView.frame.size.width * self.percentage, self.backView.frame.size.height);
    self.fillView.layer.cornerRadius = self.fillView.frame.size.height/2;
    self.gradientLayer.frame = self.fillView.layer.bounds;
}

- (void)setProgress:(CGFloat)progressValue withValueMax:(CGFloat)progressMaxValue {
    if (progressValue > progressMaxValue) progressValue = progressMaxValue;
    
    self.percentage = progressValue/progressMaxValue;
    
    [self layoutIfNeeded];
}

- (void)updateData:(CGFloat)progressValue withValueMax:(CGFloat)progressMaxValue {
    self.percentage = progressValue/progressMaxValue;
    
    self.fillView.frame = CGRectMake(0, 0, self.backView.frame.size.width * self.percentage, self.backView.frame.size.height);
    self.gradientLayer.frame = self.fillView.layer.bounds;
    [self layoutIfNeeded];
}
- (UIColor*)startColor{
    return _startColor;
}
- (UIColor*)endColor{
    return _endColor;
}
@end
