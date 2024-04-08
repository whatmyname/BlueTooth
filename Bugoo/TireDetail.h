//
//  TireDetail.h
//  Bugoo
//
//  Created by bugoo on 10/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TireDetail : UIView
@property (nonatomic,strong)Model *model;
@property (nonatomic,strong)NSString *tId;
@property (nonatomic, copy) void (^changeTireUn)();
@property (nonatomic, copy) void (^changeTire)();
@property (nonatomic,copy)void (^addVoice)(NSString *voice);
@property (nonatomic,copy)void (^rmVoice)(NSString *voice);
@property (nonatomic,copy)void (^alertShow)();
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andModel:(Model *)model;
@end
