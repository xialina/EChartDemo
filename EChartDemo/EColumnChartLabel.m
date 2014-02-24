//
//  EColumnChartLabel.m
//  EChartDemo
//
//  Created by xialn on 14-2-11.
//  Copyright (c) 2014年 cityre. All rights reserved.
//

#import "EColumnChartLabel.h"
#import "EColor.h"

@implementation EColumnChartLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLineBreakMode:NSLineBreakByClipping];
        [self setMinimumScaleFactor:5.0f/13.0f];
        
        self.adjustsFontSizeToFitWidth = YES;
        [self setNumberOfLines:1];
        [self setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [self setTextColor: EDeepGrey];
        self.backgroundColor = [UIColor clearColor];
        [self setTextAlignment:NSTextAlignmentLeft];
        self.userInteractionEnabled = YES;
        [self setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
    }
    return self;
}

@end
