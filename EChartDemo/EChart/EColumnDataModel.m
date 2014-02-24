//
//  EColumnDataModel.m
//  EChartDemo
//
//  Created by xialn on 14-2-11.
//  Copyright (c) 2014年 cityre. All rights reserved.
//

#import "EColumnDataModel.h"

@implementation EColumnDataModel

- (id)initEColumnDataModelWithValue:(float)value unit:(NSString *)unit index:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.value = value;
        self.unit = unit;
        self.index = index;
    }
    return self;
}

@end
