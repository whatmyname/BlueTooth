//
//  SearchView.m
//  Bugoo
//
//  Created by bugoo on 13/4/17.
//  Copyright © 2017年 LoveGuoGuo. All rights reserved.
//

#import "SearchView.h"
#import "SCGIFImageView.h"
@implementation SearchView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {

        [self createUI];
    }
    return self;
}

-(void)show{
    [[Utility mainWindow]addSubview:self];
}

-(void)createUI{
    SCGIFImageView *signal= [[SCGIFImageView alloc] initWithGIFFile:[[NSBundle mainBundle] pathForResource:@"GIF" ofType:@"gif"]];
    [signal setFrame:CGRectMake(0, 0, 100, 90)];
    signal.center = self.center;
    signal.layer.masksToBounds = YES;
    signal.layer.cornerRadius = 15;
    [self addSubview:signal];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT(signal)-10-16, WIDTH(signal), 16)];
    label.text = _string;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [Utility colorWithHexString:@"f1f1f1"];
    [signal addSubview:label];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(X(signal), MAXY(signal)+10, WIDTH(signal), 40)];
    
    [button setTitle:HXString(@"取消") forState:UIControlStateNormal];
    [button setTitleColor:[Utility colorWithHexString:@"f1f1f1"] forState:UIControlStateNormal];
    button.backgroundColor = [Utility colorWithHexString:@"191919" andAlpha:0.9];
    [button addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 15;
    [self addSubview:button];
    [self addSubview:signal];
}

-(void)cancel:(UIButton *)button{
    if (_Cancel) {
        _Cancel();
    }
 
    [self removeFromSuperview];
}


@end
