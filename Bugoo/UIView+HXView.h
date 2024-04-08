//
//  UIView+HXView.h
//  Masonry
//
//  Created by bugoo on 17/5/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "MacroMethod.h"
@interface UIView (HXView)

#define X(v)               (v).frame.origin.x
#define Y(v)               (v).frame.origin.y
#define WIDTH(v)           (v).frame.size.width
#define HEIGHT(v)          (v).frame.size.height
#define MAXX(v)            CGRectGetMaxX(v.frame)
#define MAXY(v)            CGRectGetMaxY(v.frame)

CGFloat Adapt_scaleL(CGFloat level);

/*!
 @brief  竖直比例适配 取值为水平比例适配
 @param vertical 原值
 @return 适配后的值
 */
CGFloat Adapt_scaleV(CGFloat vertical);

/** 适配CGpoint */
CGPoint CGPointMakeAdapt(CGFloat x, CGFloat y);

/** 适配CGSize */
CGSize CGSizeMakeAdapt(CGFloat width, CGFloat height);

/** 适配CGRect */
CGRect CGRectMakeAdapt(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

/** 适配UIEdgeInsets */
UIEdgeInsets UIEdgeInsetsMakeAdapt(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

#pragma mark - 选择适配方式

#pragma mark 设计图为IPHONE4

CGFloat Adapt_IPHONE4_scaleL(CGFloat level);

CGFloat Adapt_IPHONE4_scaleV(CGFloat vertical);

CGPoint CGPointMakeIPHONE4Adapt(CGFloat x, CGFloat y);

CGSize  CGSizeMakeIPHONE4Adapt(CGFloat width, CGFloat height);

CGRect  CGRectMakeIPHONE4Adapt(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

UIEdgeInsets UIEdgeInsetsMakeIPHONE4Adapt(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

#pragma mark 设计图为IPHONE5/5s

CGFloat Adapt_IPHONE5_scaleL(CGFloat level);

CGFloat Adapt_IPHONE5_scaleV(CGFloat vertical);

CGPoint CGPointMakeIPHONE5Adapt(CGFloat x, CGFloat y);

CGSize  CGSizeMakeIPHONE5Adapt(CGFloat width, CGFloat height);

CGRect  CGRectMakeIPHONE5Adapt(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

UIEdgeInsets UIEdgeInsetsMakeIPHONE5Adapt(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

#pragma mark 设计图为IPHONE6

CGFloat Adapt_IPHONE6_scaleL(CGFloat level);

CGFloat Adapt_IPHONE6_scaleV(CGFloat vertical);

CGPoint CGPointMakeIPHONE6Adapt(CGFloat x, CGFloat y);

CGSize  CGSizeMakeIPHONE6Adapt(CGFloat width, CGFloat height);

CGRect  CGRectMakeIPHONE6Adapt(CGFloat x, CGFloat y,CGFloat width, CGFloat height);

UIEdgeInsets UIEdgeInsetsMakeIPHONE6Adapt(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

#pragma mark 设计图为IPHONE6P

CGFloat Adapt_IPHONE6P_scaleL(CGFloat level);

CGFloat Adapt_IPHONE6P_scaleV(CGFloat vertical);

CGPoint CGPointMakeIPHONE6PAdapt(CGFloat x, CGFloat y);

CGSize  CGSizeMakeIPHONE6PAdapt(CGFloat width, CGFloat height);

CGRect  CGRectMakeIPHONE6PAdapt(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

UIEdgeInsets UIEdgeInsetsMakeIPHONE6PAdapt(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
@end
