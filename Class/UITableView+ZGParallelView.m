//
//  UITableView+ZGParallelView.m
//  ZGParallelViewForTable
//
//  Created by Kyle Fang on 1/7/13.
//  Copyright (c) 2013 kylefang. All rights reserved.
//

#import "UITableView+ZGParallelView.h"

#define DEFAULT_DISPLAY_RADIO   0.5f

@implementation UITableView (ZGParallelView)


static CGFloat displayRadio;
static CGFloat viewHeight;
static UIScrollView *embededScrollView;

- (void)addParallelViewWithUIView:(UIView *)aViewToAdd{
    [self addParallelViewWithUIView:aViewToAdd withDisplayRadio:DEFAULT_DISPLAY_RADIO];
}

- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat)aDisplayRadio{
    aViewToAdd.frame = CGRectOffset(aViewToAdd.frame, -aViewToAdd.frame.origin.x, -aViewToAdd.frame.origin.y);
    if (aDisplayRadio>1 && aDisplayRadio<0) {
        displayRadio = 1;
    } else {
        displayRadio = aDisplayRadio;        
    }
    viewHeight = aViewToAdd.frame.size.height;
    embededScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, viewHeight)];
    [embededScrollView addSubview:aViewToAdd];
    aViewToAdd.frame = CGRectOffset(aViewToAdd.frame, 0, viewHeight*(1.f - displayRadio)/2.f);
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, viewHeight*displayRadio)];
    [headView addSubview:embededScrollView];
    embededScrollView.frame = CGRectOffset(embededScrollView.frame, 0, viewHeight*(displayRadio-1.f));
    self.tableHeaderView = headView;
}

- (void)updateParallelView{
    CGFloat yOffset = self.contentOffset.y;
    if (yOffset<0 && yOffset>viewHeight*(displayRadio-1.f)) {
        embededScrollView.contentOffset = CGPointMake(0.f, -yOffset*0.5f);
    }
}

@end
