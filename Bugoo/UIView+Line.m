//
//  UIView+Line.m
//  Bugoo
//
//  Created by bugoo on 16/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "UIView+Line.h"

@implementation UIView (Line)
+(instancetype)initWithLine:(CGRect)frame{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [Utility colorWithHexString:@"dadada"];
    return view;
}


+(instancetype)initMyView:(CGRect)frame{
    UIView *view =[[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [Utility colorWithHexString:@"ffffff"];
    UIView *line = [UIView initWithLine:CGRectMake(0, 0, frame.size.width, 1)];
    UIView *line1 = [UIView initWithLine:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
    
    [view addSubview:line];
    [view addSubview:line1];
    
    
    return view;
}


+(instancetype)initWith:(CGRect)frame andTitle:(NSString *)title andNumber:(NSString *)number andEmail:(NSString *)email{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 14, 375, 25)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [Utility colorWithHexString:@"333333"];
    [view addSubview:titleLabel];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 44, 375, 20)];
    phoneLabel.textColor = [Utility colorWithHexString:@"2a2a2a"];
    NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: %@",HXString(@"电话"),number]];
    [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(0,HXString(@"电话").length)];
    
    phoneLabel.attributedText = strFU;
    
    
    
    [view addSubview:phoneLabel];
    
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 66, 375, 20)];

    emailLabel.textColor = [Utility colorWithHexString:@"2a2a2a"];
    
    NSMutableAttributedString *strEmail = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: %@",HXString(@"Email"),email]];
    [strEmail addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(0,HXString(@"Email").length)];
    emailLabel.attributedText = strEmail;
    
    if (kIsIphone5) {
        phoneLabel.font = [UIFont systemFontOfSize:14];
        emailLabel.font = [UIFont systemFontOfSize:14];
    }
    
    [view addSubview:emailLabel];
    
    view.backgroundColor = [Utility colorWithHexString:@"ffffff"];
    return view;
}

+(instancetype)initStatuewithFrame:(CGRect)frame andImage:(UIImage *)image andTitle:(NSString *)title{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textColor = [Utility colorWithHexString:@"444444"];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    
    label.lineBreakMode = NSLineBreakByWordWrapping;
//    if (kIsIphone4s||kIsIphone5) {
//        label.font = [UIFont systemFontOfSize:14];
//    }
    CGSize size = [label sizeThatFits:CGSizeMake(WIDTH(view), MAXFLOAT)];
 
    [view addSubview:label];
    
    label.frame = CGRectMake(0,0,WIDTH(view), size.height);
    
    UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, MAXY(label)+5, Adapt_IPHONE6_scaleL(213), Adapt_IPHONE6_scaleV(343))];
    imageView.image = image;
    imageView.center = CGPointMake(WIDTH(view)/2, imageView.center.y);
    [view addSubview:imageView];
    
    [view setFrame:CGRectMake(X(view), Y(view), WIDTH(view), MAXY(imageView))];
    
    
    return view;
}

+(instancetype)initUnNStatuewithFrame:(CGRect)frame andImage:(UIImage *)image andTitle:(NSString *)title andStatue:(NSString *)statue{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    
    UILabel *tt = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH(view), 22)];
    tt.textColor = [Utility colorWithHexString:@"444444"];
    tt.textAlignment = NSTextAlignmentCenter;
    tt.text = title;
    [view addSubview:tt];
    
    
    UILabel *label = [[UILabel alloc]init];
    
    label.text = statue;
    label.textColor = [Utility colorWithHexString:@"666666"];

    label.numberOfLines = 0;
    
    label.lineBreakMode = NSLineBreakByWordWrapping;
    if (kIsIphone4s||kIsIphone5) {
        label.font = [UIFont systemFontOfSize:14];
    }
    CGSize size = [label sizeThatFits:CGSizeMake(WIDTH(view), MAXFLOAT)];
    
    [view addSubview:label];
    
    label.frame = CGRectMake(0,MAXY(tt),WIDTH(view), size.height);
    label.textAlignment = NSTextAlignmentCenter;
    UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, MAXY(label)+5, Adapt_IPHONE6_scaleL(213), Adapt_IPHONE6_scaleV(343))];
    imageView.image = image;
    
    imageView.center = CGPointMake(WIDTH(view)/2, imageView.center.y);
    [view addSubview:imageView];
    
    [view setFrame:CGRectMake(X(view), Y(view), WIDTH(view), MAXY(imageView))];
    return view;
}


+(instancetype)initWithTosat:(NSString *)title{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 375, 667)];
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textColor = [Utility colorWithHexString:@"ffffff"];
    label.numberOfLines = 1;
    label.layer.cornerRadius = 15;
    label.textAlignment = NSTextAlignmentCenter;
    if (kIsIphone4s||kIsIphone5) {
        label.font = [UIFont systemFontOfSize:14];
    }
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.backgroundColor = [Utility colorWithHexString:@"000000"];
    CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, 69)];
    
    [label setFrame:CGRectMake(0, 0, size.width, size.height)];
    label.center = view.center;

    view.backgroundColor = [Utility colorWithHexString:@"000000" andAlpha:0.5];
    [view addSubview:label];
    
    return view;
}

@end
