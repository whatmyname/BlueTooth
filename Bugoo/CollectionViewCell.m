//
//  CollectionViewCell.m
//  Bugoo
//
//  Created by bugoo on 10/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
    
    }
    return self;
}

- (void)createUIWithMotorType:(MotorType)type{
    self.backgroundColor = [UIColor clearColor];
    switch (type) {
        case 0:
        {
            
            if (kIsIphone5||kIsIphone4s) {
                _image = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 210, 152)];
                _image.image = [UIImage imageNamed:@"motor1"];
            }else{
                _image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"motor1"]];
            }
        }
            break;
        case 1:
        {
            if (kIsIphone5||kIsIphone4s) {
                _image = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 210, 109)];
                _image.image = [UIImage imageNamed:@"motor"];
            }else{
                _image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"motor"]];
            }
            
        }
            
            break;
        case 2:
        {
            if (kIsIphone5||kIsIphone4s) {
                _image = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 210, 126)];
                
                _image.image = [UIImage imageNamed:@"motor2"];
            }else{
                _image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"motor2"]];
            }
        }
            break;
        default:
            break;
    }
    _image.center = CGPointMake(WIDTH(self)/2, HEIGHT(self)/2);
    [self addSubview:_image];
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0, MAXY(_image), WIDTH(self), 25)];
    _lable.textAlignment = NSTextAlignmentCenter;
    _lable.textColor = [Utility colorWithHexString:@"333333"];
    switch (type) {
        case 0:
            _lable.text = HXString(@"普通摩托");
            break;
        case 1:
            _lable.text = HXString(@"跑车");
            break;
        case 2:
            _lable.text = HXString(@"重型摩托");
            break;
        default:
            break;
    }
    [self addSubview:_lable];
 
}
@end
