//
//  EColumnChart.h
//  EChartDemo
//
//  Created by xialn on 14-2-11.
//  Copyright (c) 2014年 cityre. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EColumnDataModel;
@class EColumnChart;
@class EColumn;

@protocol EColumnChartDataSource <NSObject>

- (NSInteger) numberOfColumnsInEColumnChart:(EColumnChart *)eColumnChart;
- (NSInteger) numberOfColumnsPresentedEveryTime:(EColumnChart *)eColumnChart;

- (EColumnDataModel *) highestValueEColumnChart:(EColumnChart *)eColumnChart;
- (EColumnDataModel *) eColumnChart:(EColumnChart *)eColumnChart valueForIndex:(NSInteger)index;

@end

@protocol EColumnChartDelegate <NSObject>

- (void) eColumnChart:(EColumnChart *)eColumnChart didSelectedColumn:(EColumn *)column;

- (void) eColumnChart:(EColumnChart *)eColumnChart fingerEnterColumn:(EColumn *)column;
- (void) eColumnChart:(EColumnChart *)eColumnChart fingerLeavedColumn:(EColumn *)column;

@end

@interface EColumnChart : UIView

@property (nonatomic, strong) EColumnDataModel *dataModel;
@property (nonatomic, strong) UILabel *valueLabel;

@property (nonatomic, strong) UIColor *maxColumnColor, *minColumnColor;
@property (nonatomic, strong) UIColor *normalColumnColor;

@property (nonatomic, assign) id<EColumnChartDataSource> dataSource;
@property (nonatomic, assign) id<EColumnChartDelegate> delegate;

@end
