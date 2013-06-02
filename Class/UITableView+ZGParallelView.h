//
//  UITableView+ZGParallelView.h
//  ZGParallelViewForTable
//
//  Created by Kyle Fang on 1/7/13.
//  Copyright (c) 2013 kylefang. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    ZGScrollViewStyleDefault = 0,
    ZGScrollViewStyleCutOffAtMax,
    ZGScrollViewStyleStickToTheTop = 10
};

typedef NSUInteger ZGScrollViewStyle;

@interface UITableView (ZGParallelView)

- (void)addParallelViewWithUIView:(UIView *)aViewToAdd;
- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat )displayRadio;
- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat )displayRadio cutOffAtMax:(BOOL)cutOffAtMax DEPRECATED_ATTRIBUTE;
- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat )displayRadio headerViewStyle:(ZGScrollViewStyle )style;

- (void)updateParallelViewWithOffset:(CGPoint)contentOffset;

@end
