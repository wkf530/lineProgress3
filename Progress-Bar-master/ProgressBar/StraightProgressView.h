//
//  StraightProgressView.h
//  ProgressBar
//
//  Created by Zhang on 2017/12/1.
//  Copyright © 2017年 wangwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StraightProgressView : UIView
@property(nonatomic,strong)UIColor *startColor;
@property(nonatomic,strong)UIColor *endColor;

- (void)showColorV;
- (void)updateData:(CGFloat)progressValue withValueMax:(CGFloat)progressMaxValue;
- (void)setProgress:(CGFloat)progressValue withValueMax:(CGFloat)progressMaxValue;

@end
