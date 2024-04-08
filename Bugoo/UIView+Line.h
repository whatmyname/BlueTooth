//
//  UIView+Line.h
//  Bugoo
//
//  Created by bugoo on 16/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Line)
+(instancetype)initWithLine:(CGRect)frame;
+(instancetype)initMyView:(CGRect)frame;
+(instancetype)initWith:(CGRect)frame andTitle:(NSString *)title andNumber:(NSString *)number andEmail:(NSString *)email;
+(instancetype)initStatuewithFrame:(CGRect)frame andImage:(UIImage *)image andTitle:(NSString *)title;
+(instancetype)initUnNStatuewithFrame:(CGRect)frame andImage:(UIImage *)image andTitle:(NSString *)title andStatue:(NSString *)statue;
+(instancetype)initWithTosat:(NSString *)title;
@end
