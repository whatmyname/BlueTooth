//
//  QRCode_ViewController.h
//  Bugoo
//
//  Created by bugoo on 6/4/17.
//  Copyright © 2017年 LoveGuoGuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CallBackBlcokLearn) (NSString *text);
@interface QRCode_ViewController : UIViewController
@property (nonatomic,copy)CallBackBlcokLearn callback;
@end
