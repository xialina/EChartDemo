//
//  ViewController.m
//  EChartDemo
//
//  Created by xialn on 14-2-11.
//  Copyright (c) 2014年 cityre. All rights reserved.
//

#import "ViewController.h"
#import "EColumnChart.h"
#import "EColumnDataModel.h"
#import "EColumn.h"
#import "EColor.h"

#import "HistogramView.h"

@interface ViewController () <EColumnChartDataSource, EColumnChartDelegate>

@property (nonatomic, strong) EColumnChart *columnChart;
@property (nonatomic, strong) EColumn *selectedColumn;
@property (nonatomic, strong) NSArray *columnValues;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *datas = [[NSMutableArray alloc]initWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        float value = arc4random() % 100;
        EColumnDataModel *model = [[EColumnDataModel alloc]initEColumnDataModelWithValue:value unit:@"khm" index:i];
        [datas addObject:model];
    }
    self.columnValues = [NSArray arrayWithArray:datas];
    
    EColumnChart *chart = [[EColumnChart alloc]initWithFrame:CGRectMake(40, 50, 250, 200)];
    chart.dataSource = self;
    chart.delegate = self;
    chart.backgroundColor = [UIColor clearColor];
    [self.view addSubview:chart];
    
    self.columnChart = chart;
    
    HistogramView *histogramView = [[HistogramView alloc]initWithFrame:CGRectMake(10, 300, 100, 100)];
    [self.view addSubview:histogramView];
}

#pragma mark - EColumnDataSource
- (NSInteger)numberOfColumnsInEColumnChart:(EColumnChart *)eColumnChart
{
    return self.columnValues.count;
}

- (NSInteger)numberOfColumnsPresentedEveryTime:(EColumnChart *)eColumnChart
{
    return 7;
}

- (EColumnDataModel *)highestValueEColumnChart:(EColumnChart *)eColumnChart
{
    EColumnDataModel *dataModel = nil;
    
    float maxValue = - 1 * FLT_MIN;
    for (int i = 0 ; i < _columnValues.count; i++) {
        EColumnDataModel *model = _columnValues[i];
        if (model.value > maxValue) {
            dataModel = model;
            maxValue = model.value;
        }
    }
    return dataModel;
}

- (EColumnDataModel *)eColumnChart:(EColumnChart *)eColumnChart valueForIndex:(NSInteger)index
{
    return _columnValues[index];
}

#pragma mark - EColumnChartDelegate
- (void)eColumnChart:(EColumnChart *)eColumnChart didSelectedColumn:(EColumn *)column
{
    if (_selectedColumn) {
        _selectedColumn.barColor = EGrey;
    }
    if (_selectedColumn != column) {
        _selectedColumn = column;
        
        _selectedColumn.barColor = ELightBlue;
    }
    
}

- (void)eColumnChart:(EColumnChart *)eColumnChart fingerLeavedColumn:(EColumn *)column
{
    
}

- (void)eColumnChart:(EColumnChart *)eColumnChart fingerEnterColumn:(EColumn *)column
{
    
}

@end
