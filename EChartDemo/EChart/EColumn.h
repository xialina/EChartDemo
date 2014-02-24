//
//  EColumn.h
//  EChartDemo
//
//  Created by xialn on 14-2-11.
//  Copyright (c) 2014年 cityre. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EColumn;

@protocol EColumnDelegate <NSObject>

- (void) eColumnTap:(EColumn *)column;

@end

@interface EColumn : UIView

@property (nonatomic, strong) UIColor *barColor;
@property (nonatomic, assign) float grade;
@property (nonatomic, strong) CAShapeLayer *lineLayer;

@property (nonatomic, weak) id<EColumnDelegate> delegate;

@end
