//
//  ViewController.m
//  ProgressBar
//
//  Created by Zhang on 2017/12/1.
//  Copyright © 2017年 wangwang. All rights reserved.
//

#import "ViewController.h"
#import "StraightProgressView.h"
#import "RoundProgressView.h"
#define OXUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface ViewController ()
{
    StraightProgressView *straightProgressView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    straightProgressView = [[StraightProgressView alloc] initWithFrame:CGRectMake(20, 200, self.view.bounds.size.width - 40, 30)];
    straightProgressView.startColor = OXUIColorFromRGB(0xFFA9A0);
    straightProgressView.endColor = OXUIColorFromRGB(0xFA2651);
    [straightProgressView showColorV];
    [straightProgressView setProgress:6.0 withValueMax:10.0];
    [self.view addSubview:straightProgressView];
    //
    RoundProgressView *roundProgressView = [[RoundProgressView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 200)/2, 300, 200, 200)];
    [roundProgressView setProgress:6.0 withValueMax:10.0];
    [self.view addSubview:roundProgressView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [straightProgressView updateData:9 withValueMax:10];
}
@end
