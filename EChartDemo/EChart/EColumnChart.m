//
//  EColumnChart.m
//  EChartDemo
//
//  Created by xialn on 14-2-11.
//  Copyright (c) 2014年 cityre. All rights reserved.
//

#import "EColumnChart.h"
#import "EColor.h"
#import "EColumn.h"
#import "EColumnDataModel.h"
#import "EColumnChartLabel.h"


#define HORIZONTAL_LINE_HEIGHT 0.5
#define Y_COORDINATE_LABEL_WIDTH 30

@interface EColumnChart()<EColumnDelegate>

@property (nonatomic, strong) NSMutableDictionary *eColumns;
@property (nonatomic, strong) NSMutableDictionary *eLabels;

@property (nonatomic, assign) NSInteger leftIndex;

@property (nonatomic, strong) EColumn *fingerInChartColumn;

@end

@implementation EColumnChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _minColumnColor = EBlue;
        _maxColumnColor = EYellow;
        _normalColumnColor = EGrey;
        
        self.eColumns = [[NSMutableDictionary alloc]init];
        self.eLabels = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)setDataSource:(id<EColumnChartDataSource>)dataSource
{
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        
        float highestValueColumnChart = [_dataSource highestValueEColumnChart:self].value * 1.1;
        
        float perValue = highestValueColumnChart / 10;
        float perHeight = CGRectGetHeight(self.frame) / 10;
        
        for (int i = 0; i < 11; i++) {
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, perHeight * i, CGRectGetWidth(self.frame), HORIZONTAL_LINE_HEIGHT)];
            [line setBackgroundColor:ELightGrey];
            [self addSubview:line];
            
            EColumnChartLabel *label = [[EColumnChartLabel alloc]initWithFrame:CGRectMake(- 1 * Y_COORDINATE_LABEL_WIDTH, -perHeight / 2 + perHeight * i, Y_COORDINATE_LABEL_WIDTH, perHeight)];
            label.text = [NSString stringWithFormat:@"%.1fkwh", perValue * (10 - i)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [self addSubview:label];
        }
    }
    
    [self reloadData];
}

- (void)reloadData
{
    NSInteger requireColumns = [_dataSource numberOfColumnsPresentedEveryTime:self];
    NSInteger totalColumns = [_dataSource numberOfColumnsInEColumnChart:self];

    //
    NSInteger maxIndex = 0, minIndex = 0;
    CGFloat maxValue = 0.0, minValue = 100000.0;
    
    // 求出图表的最高值
    CGFloat maxColumnValue = [_dataSource highestValueEColumnChart:self].value * 1.1;
    
    // 每个column的宽度 ＋ seperate宽度
    float widthOfColumn = CGRectGetWidth(self.frame) / (requireColumns + (requireColumns + 1) * 0.5);

    // 逐个画 EColumn
    for (int i = 0; i < requireColumns; i++) {
        NSInteger currentIndex = i;
        if (requireColumns < totalColumns) {
            currentIndex = _leftIndex + i;
        }
        EColumnDataModel *dataModel = [_dataSource eColumnChart:self valueForIndex:currentIndex];
        
        if (dataModel.value > maxValue) {
            maxIndex =  currentIndex;
            maxValue = dataModel.value;
        }
        if (dataModel.value < minValue) {
            minIndex = currentIndex;
            minValue = dataModel.value;
        }
        
        EColumn *column = [_eColumns objectForKey:[NSNumber numberWithInt:i]];
        if (!column) {
            column = [[EColumn alloc]initWithFrame:CGRectMake(widthOfColumn * 0.5 + (i * widthOfColumn * 1.5), 0, widthOfColumn, CGRectGetHeight(self.frame))];
            column.grade = dataModel.value / maxColumnValue;
            column.backgroundColor = [UIColor clearColor];
            column.delegate = self;
            [self addSubview:column];
            [_eColumns setObject:column forKey:[NSNumber numberWithInteger:currentIndex]];
        }
    }
    
    // 修改最大、最小颜色
    EColumn *maxColumn = [_eColumns objectForKey:[NSNumber numberWithInteger:maxIndex]];
    EColumn *minColumn = [_eColumns objectForKey:[NSNumber numberWithInteger:minIndex]];
    maxColumn.barColor = EMaxValueColor;
    minColumn.barColor = EMinValueColor;
    
    // 画横坐标
    [UIView animateWithDuration:0.8
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^(void){
                         UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame), 0, 1)];
                         line.backgroundColor = EBlack;
                         [self addSubview:line];
                         
                         line.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 1);
                     }
                     completion:nil];
    
    // 横坐标的坐标显示
    for (int i = 0; i < requireColumns; i++) {
        UILabel *numLab = [[UILabel alloc]initWithFrame:CGRectMake(widthOfColumn * 1.5 / 2.0 + widthOfColumn * 1.5 * i, CGRectGetHeight(self.frame) + 8, widthOfColumn * 1.5, 8)];
        numLab.text = [NSString stringWithFormat:@"%d", i];
        numLab.backgroundColor = [UIColor clearColor];
        numLab.font = [UIFont systemFontOfSize:9];
        [self addSubview:numLab];
    }
}

#pragma mark - EColumnDelegate
- (void)eColumnTap:(EColumn *)column
{
    [_delegate eColumnChart:self didSelectedColumn:column];
}

#pragma mark -
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_delegate) {
        return;
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    for (EColumn *view in _eColumns.objectEnumerator)
    {
        if(CGRectContainsPoint(view.frame, touchLocation))
        {
            [_delegate eColumnChart:self fingerLeavedColumn:view];
            _fingerInChartColumn = nil;
            return;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_delegate) {
        return;
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (!_fingerInChartColumn) {
        for (EColumn *view in _eColumns.objectEnumerator) {
            if (CGRectContainsPoint(view.frame, touchLocation)) {
                [_delegate eColumnChart:self fingerEnterColumn:view];
                _fingerInChartColumn = view;
                
                return;
            }
        }
    }
    
    if (_fingerInChartColumn && !CGRectContainsPoint(_fingerInChartColumn.frame, touchLocation)) {
        [_delegate eColumnChart:self fingerLeavedColumn:_fingerInChartColumn];
        _fingerInChartColumn = nil;
    }
    return;
}

@end
