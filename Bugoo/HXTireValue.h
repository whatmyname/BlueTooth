//
//  HXTireValue.h
//  Bugoo
//
//  Created by bugoo on 11/4/17.
//  Copyright © 2017年 LoveGuoGuo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBackBlcok) (NSString * dic);
typedef void(^CancelBackBlcok)();
@interface HXTireValue : UIView
@property (nonatomic,copy)CallBackBlcok comBlock;
@property (nonatomic,copy)CancelBackBlcok cancelBlock;
+ (HXTireValue *) loadGuide:(CGRect)frame andUnit:(NSString *)unit;
-(void)show;
@end
