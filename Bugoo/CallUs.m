//
//  CallUs.m
//  Bugoo
//
//  Created by bugoo on 18/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "CallUs.h"

@interface CallUs ()
@property (nonatomic,strong)UIView *rootView;
@end

@implementation CallUs

- (void)viewDidLoad {
    [super viewDidLoad];
    _rootView = [[UIView alloc]initWithFrame:self.view.bounds];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    self.title = HXString(@"联系我们");
    [self.view addSubview:_rootView];
    [self createUI];
    
}


-(void)createUI{
    UIView *shanghai = [UIView initWith:CGRectMakeIPHONE6Adapt(0, 15, 375, 100) andTitle:HXString(@"上海办事处") andNumber:@"400-9129-299" andEmail:@"bugoo2015@bugootech.com"];
    
    [_rootView addSubview:shanghai];
    
    UIView *taiwan = [UIView initWith:CGRectMakeIPHONE6Adapt(0, 135, 375, 100) andTitle:HXString(@"台湾办事处") andNumber:@"+886-4-8829787" andEmail:@"bugoo@bugootech.com.tw"];
    [_rootView addSubview:taiwan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
