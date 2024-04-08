//
//  W1Tool.h
//  Bugoo
//
//  Created by bugoo on 7/4/17.
//  Copyright © 2017年 LoveGuoGuo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^LearnCallBack)(NSString *string);
@interface W1Tool : NSObject
@property (assign,nonatomic)BOOL isLearn;
@property (nonatomic,copy)LearnCallBack learnCall;
@property (strong,nonatomic)NSMutableArray *learnArr;
+ (W1Tool *)loadGuide;
-(void)startRanging;
-(void)stopRanging;
-(void)setModel;
-(BOOL)isLocation;
@end
