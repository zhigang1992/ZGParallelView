//
//  UITableView+ZGParallelView.h
//  ZGParallelViewForTable
//
//  Created by Kyle Fang on 1/7/13.
//  Copyright (c) 2013 kylefang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ZGParallelView)

- (void)addParallelViewWithUIView:(UIView *)aViewToAdd;
- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat )displayRadio;
- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat )displayRadio cutOffAtMax:(BOOL)cutOffAtMax;

@end
