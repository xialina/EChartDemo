//
//  EColumnDataModel.h
//  EChartDemo
//
//  Created by xialn on 14-2-11.
//  Copyright (c) 2014年 cityre. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EColumnDataModel : NSObject

@property (nonatomic, assign) float value;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *unit;

- (id)initEColumnDataModelWithValue:(float)value
                               unit:(NSString *)unit
                              index:(NSInteger)index;

@end
