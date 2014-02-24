//
//  EColumn.m
//  EChartDemo
//
//  Created by xialn on 14-2-11.
//  Copyright (c) 2014年 cityre. All rights reserved.
//

#import "EColumn.h"
#import "EColor.h"

@implementation EColumn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineLayer = [CAShapeLayer layer];
        [_lineLayer setLineWidth:CGRectGetWidth(self.frame)];
        [_lineLayer setFillColor:[UIColor redColor].CGColor];
        [_lineLayer setStrokeEnd:0];
        self.clipsToBounds = YES;
        
        [self.layer addSublayer:_lineLayer];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:gesture];
        
    }
    return self;
}

- (void)tapped:(UITapGestureRecognizer *)gesture
{
    [_delegate eColumnTap:self];
}

- (void)setGrade:(float)grade
{
    _grade = grade;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) / 2, (1 - grade) * CGRectGetHeight(self.frame))];
    _lineLayer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    [_lineLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    
    _lineLayer.strokeEnd = 1.0;
    
    if (_barColor) {
        _lineLayer.strokeColor = [_barColor CGColor];
    }
    else{
        [_lineLayer setStrokeColor:[EGrey CGColor]];
    }
}

- (void)setBarColor:(UIColor *)barColor
{
    _barColor = barColor;
    _lineLayer.strokeColor = [barColor CGColor];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
}


@end
