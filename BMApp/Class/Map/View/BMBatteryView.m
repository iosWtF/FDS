//
//  BMBatteryView.m
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMBatteryView.h"

@interface BMBatteryView()
///电池宽度
@property (nonatomic,assign) CGFloat b_width;
///电池高度
@property (nonatomic,assign) CGFloat b_height;
///电池外线宽
@property (nonatomic,assign) CGFloat b_lineW;
@property (nonatomic,strong) UIView *batteryView;
@end
@implementation BMBatteryView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawBattery];
    }
    return self;
}
///画图标
- (void)drawBattery{
    ///x坐标
    CGFloat b_x = 1;
    ///y坐标
    CGFloat b_y = 1;
    _b_height = self.bounds.size.height - 2;
    _b_width = self.bounds.size.width - 5;
    _b_lineW = 1;
    
    //画电池【左边电池】
    UIBezierPath *pathLeft = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(b_x, b_y, _b_width, _b_height) cornerRadius:2];
    CAShapeLayer *batteryLayer = [CAShapeLayer layer];
    batteryLayer.lineWidth = _b_lineW;
    batteryLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    batteryLayer.fillColor = [UIColor clearColor].CGColor;
    batteryLayer.path = [pathLeft CGPath];
    [self.layer addSublayer:batteryLayer];
    
    //画电池【右边电池箭头】
    UIBezierPath *pathRight = [UIBezierPath bezierPath];
    [pathRight moveToPoint:CGPointMake(b_x + _b_width+1, b_y + _b_height/3)];
    [pathRight addLineToPoint:CGPointMake(b_x + _b_width+1, b_y + _b_height * 2/3)];
    CAShapeLayer *layerRight = [CAShapeLayer layer];
    layerRight.lineWidth = 2;
    layerRight.strokeColor = [UIColor lightGrayColor].CGColor;
    layerRight.fillColor = [UIColor clearColor].CGColor;
    layerRight.path = [pathRight CGPath];
    [self.layer addSublayer:layerRight];
    
    ///电池内填充
    _batteryView = [[UIView alloc]initWithFrame:CGRectMake(b_x + 1,b_y + _b_lineW, 0, _b_height - _b_lineW * 2)];
    _batteryView.layer.cornerRadius = 2;
    _batteryView.backgroundColor = [UIColor colorWithRed:0.324 green:0.941 blue:0.413 alpha:1.000];
    [self addSubview:_batteryView];
}
///控制电量显示
- (void)setBatteryValue:(NSInteger)value{
    if (value<10) {
        _batteryView.backgroundColor = [UIColor redColor];
    }else{
        _batteryView.backgroundColor = [UIColor colorWithRed:0.324 green:0.941 blue:0.413 alpha:1.000];
    }
    
    CGRect rect = _batteryView.frame;
    rect.size.width = (value*(_b_width - _b_lineW * 2))/100;
    _batteryView.frame  = rect;
}
@end
