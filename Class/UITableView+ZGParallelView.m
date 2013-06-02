//
//  UITableView+ZGParallelView.m
//  ZGParallelViewForTable
//
//  Created by Kyle Fang on 1/7/13.
//  Copyright (c) 2013 kylefang. All rights reserved.
//

#import "UITableView+ZGParallelView.h"
#import <objc/runtime.h>

static char UITableViewZGParallelViewDisplayRadio;
static char UITableViewZGParallelViewViewHeight;
static char UITableViewZGParallelViewStyle;
static char UITableViewZGParallelViewEmbededScrollView;
static char UITableViewZGParallelViewCutOffAtMaxSetContentOffSet;


@interface UITableView (ZGParallelViewPri)
@property (nonatomic, assign) CGFloat displayRadio;
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) ZGScrollViewStyle parallelViewStyle;
@property (nonatomic, assign) BOOL cutOffAtMaxSetContentOffSet;
@property (nonatomic, strong) UIScrollView *embededScrollView;
@end


@implementation UITableView (ZGParallelViewPri)
@dynamic displayRadio, viewHeight, parallelViewStyle, embededScrollView, cutOffAtMaxSetContentOffSet;

- (void)setDisplayRadio:(CGFloat)displayRadio {
    [self willChangeValueForKey:@"displayRadio"];
    objc_setAssociatedObject(self, &UITableViewZGParallelViewDisplayRadio,
                             [NSNumber numberWithFloat:displayRadio],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"displayRadio"];
}

- (CGFloat)displayRadio {
    NSNumber *number = objc_getAssociatedObject(self, &UITableViewZGParallelViewDisplayRadio);
    return [number floatValue];
}

- (void)setViewHeight:(CGFloat)viewHeight {
    [self willChangeValueForKey:@"viewHeight"];
    objc_setAssociatedObject(self, &UITableViewZGParallelViewViewHeight,
                             [NSNumber numberWithFloat:viewHeight],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"viewHeight"];
}

- (CGFloat)viewHeight {
    NSNumber *number = objc_getAssociatedObject(self, &UITableViewZGParallelViewViewHeight);
    return [number floatValue];
}

- (void)setParallelViewStyle:(ZGScrollViewStyle)parallelViewStyle{
    [self willChangeValueForKey:@"parallelViewStyle"];
    objc_setAssociatedObject(self, &UITableViewZGParallelViewStyle, [NSNumber numberWithInteger:parallelViewStyle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"parallelViewStyle"];
}

- (ZGScrollViewStyle )parallelViewStyle{
    NSNumber *number = objc_getAssociatedObject(self, &UITableViewZGParallelViewStyle);
    if (number == nil) {
        return ZGScrollViewStyleDefault;
    } else {
        return [number integerValue];
    }
}

- (void)setCutOffAtMaxSetContentOffSet:(BOOL)cutOffAtMaxSetContentOffSet{
    [self willChangeValueForKey:@"cutOffAtMaxSetContentOffSet"];
    objc_setAssociatedObject(self, &UITableViewZGParallelViewCutOffAtMaxSetContentOffSet, [NSNumber numberWithBool:cutOffAtMaxSetContentOffSet], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"cutOffAtMaxSetContentOffSet"];
}

- (BOOL)cutOffAtMaxSetContentOffSet{
    NSNumber *number = objc_getAssociatedObject(self, &UITableViewZGParallelViewCutOffAtMaxSetContentOffSet);
    if (number == nil) {
        return NO;
    } else {
        return [number isEqualToNumber:@YES];
    }
}

- (void)setEmbededScrollView:(UIScrollView *)embededScrollView {
    [self willChangeValueForKey:@"embededScrollView"];
    objc_setAssociatedObject(self, &UITableViewZGParallelViewEmbededScrollView,
                             embededScrollView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"embededScrollView"];
}

- (UIScrollView *)embededScrollView {
    return objc_getAssociatedObject(self, &UITableViewZGParallelViewEmbededScrollView);
}
@end



#define DEFAULT_DISPLAY_RADIO   0.5f
@implementation UITableView (ZGParallelView)
- (void)addParallelViewWithUIView:(UIView *)aViewToAdd {
    [self addParallelViewWithUIView:aViewToAdd withDisplayRadio:DEFAULT_DISPLAY_RADIO headerViewStyle:ZGScrollViewStyleDefault];
}

- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat)displayRadio{
    [self addParallelViewWithUIView:aViewToAdd withDisplayRadio:displayRadio headerViewStyle:ZGScrollViewStyleDefault];
}

- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat)aDisplayRadio cutOffAtMax:(BOOL)cutOffAtMax{
    [self addParallelViewWithUIView:aViewToAdd withDisplayRadio:aDisplayRadio headerViewStyle:ZGScrollViewStyleCutOffAtMax];
}

- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat)aDisplayRadio headerViewStyle:(ZGScrollViewStyle)parallelViewStyle{
    NSAssert(aViewToAdd != nil, @"aViewToAdd can not be nil");
    
    aViewToAdd.frame = CGRectOffset(aViewToAdd.frame, -aViewToAdd.frame.origin.x, -aViewToAdd.frame.origin.y);
    if (aDisplayRadio>1 && aDisplayRadio<0) {
        self.displayRadio = 1;
    } else {
        self.displayRadio = aDisplayRadio;
    }
    self.viewHeight = aViewToAdd.frame.size.height;
    self.parallelViewStyle = parallelViewStyle;
    self.embededScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.viewHeight)];
    self.embededScrollView.scrollsToTop = NO;
    [self.embededScrollView addSubview:aViewToAdd];
    aViewToAdd.frame = CGRectOffset(aViewToAdd.frame, 0, self.viewHeight*(1.f - self.displayRadio)/2.f);
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.viewHeight*self.displayRadio)];
    [headView addSubview:self.embededScrollView];
    self.embededScrollView.frame = CGRectOffset(self.embededScrollView.frame, 0, self.viewHeight*(self.displayRadio-1.f));
    self.tableHeaderView = headView;
    
}

- (void)updateParallelViewWithOffset:(CGPoint)contentOffset {
    CGFloat yOffset = contentOffset.y;
    if (yOffset<0 && yOffset>self.viewHeight*(self.displayRadio-1.f)) {
        self.embededScrollView.contentOffset = CGPointMake(0.f, -yOffset*0.5f);
    } else if (yOffset<self.viewHeight*(self.displayRadio-1.f)) {
        switch (self.parallelViewStyle) {
            case ZGScrollViewStyleDefault:
                break;
            case ZGScrollViewStyleCutOffAtMax:{
                self.cutOffAtMaxSetContentOffSet = YES;
                self.contentOffset = CGPointMake(0.f, self.viewHeight*(self.displayRadio-1.f));
                self.embededScrollView.contentOffset = CGPointMake(0.f, -self.viewHeight*(self.displayRadio-1.f)*0.5);
                break;
            }
            case ZGScrollViewStyleStickToTheTop:{
                self.embededScrollView.frame = CGRectMake(0, yOffset, self.embededScrollView.frame.size.width, self.embededScrollView.frame.size.height);
                self.embededScrollView.contentOffset = CGPointMake(0.f, -self.viewHeight*(self.displayRadio-1.f)*0.5);
                break;
            }
            default:
                break;
        }
    }
}

@end