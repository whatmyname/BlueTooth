//
//  ChangeType.h
//  Bugoo
//
//  Created by bugoo on 13/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface ChangeType : RootViewController
@property (nonatomic,copy)void (^CancelBackBlcok)(MotorType type);
@end
