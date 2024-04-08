//
//  SearchView.h
//  Bugoo
//
//  Created by bugoo on 13/4/17.
//  Copyright © 2017年 LoveGuoGuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView
@property (nonatomic,copy)NSString *string;
@property(nonatomic,strong)void (^Cancel)();
-(void)show;
@end
