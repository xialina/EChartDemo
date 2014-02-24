//
//  HistogramView.m
//  PriceManage
//
//  Created by xialn on 14-1-14.
//  Copyright (c) 2014年 cityre. All rights reserved.
//

#import "HistogramView.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation HistogramView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUIOfView];
    }
    return self;
}

- (void)initUIOfView
{
    UIBezierPath *path=[UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(10, 30)];
    [path addLineToPoint:CGPointMake(50, 20)];
    [path addLineToPoint:CGPointMake(70, 30)];
    [path addLineToPoint:CGPointMake(120, 50)];
    [path addLineToPoint:CGPointMake(180, 20)];
    [path addLineToPoint:CGPointMake(200, 10)];
    [path addLineToPoint:CGPointMake(220, 40)];
    [path addLineToPoint:CGPointMake(235, 20)];
    [path addLineToPoint:CGPointMake(280, 27)];
    
    CAShapeLayer *arcLayer = [CAShapeLayer layer];
    arcLayer.path = path.CGPath;
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.strokeColor = [UIColor brownColor].CGColor;
    arcLayer.lineWidth = 3;
    arcLayer.frame = self.bounds;
    [self.layer addSublayer:arcLayer];
    [self drawLineAnimation:arcLayer];
}

- (void)initWithSquareView
{
    
}

//定义动画过程
-(void)drawLineAnimation:(CALayer*)layer
{
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration = 0.5;
    bas.delegate=self;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
}


@end
