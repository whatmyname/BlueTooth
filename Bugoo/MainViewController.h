//
//  MainViewController.h
//  Bugoo
//
//  Created by bugoo on 4/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "RootViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MainViewController : RootViewController
@property (strong, nonatomic) AVAudioPlayer *player;

@property (strong,nonatomic)NSTimer *timer;
-(void)setDefaultValue;


@end
