
//
//  TireStatue.m
//  Bugoo
//
//  Created by bugoo on 18/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "TireStatue.h"

@interface TireStatue ()
@property (nonatomic,strong)UIScrollView *rootView;
@end

@implementation TireStatue

- (void)viewDidLoad {
    [super viewDidLoad];
    _rootView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-64)];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    self.title = HXString(@"胎压状态预览");
    [self.view addSubview:_rootView];
    
    [self createUI];
}

-(void)createUI{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 15, 345, 75)];
    label.textColor = [Utility colorWithHexString:@"333333"];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:18];
    if (kIsIphone5) {
        label.font = [UIFont systemFontOfSize:14];
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.text = HXString(@"以前轮为例，为您展示当轮胎处于不同状态时所对应的显示内容");
    [_rootView addSubview:label];
    
    UIView *view1 = [UIView initStatuewithFrame:CGRectMake(0, MAXY(label)+15, WIDTH(self.view), 240) andImage:[UIImage imageNamed:HXString(@"1")] andTitle:HXString(@"正常状态")];
    [_rootView addSubview:view1];
    
    UIView *view2 = [UIView initStatuewithFrame:CGRectMake(0, MAXY(view1)+15, WIDTH(self.view), 240) andImage:[UIImage imageNamed:HXString(@"2")] andTitle:HXString(@"未收到数据时")];
    [_rootView addSubview:view2];
    
    UIView *view3 = [UIView initUnNStatuewithFrame:CGRectMake(0, MAXY(view2)+15, WIDTH(self.view), 240) andImage:[UIImage imageNamed:HXString(@"3")] andTitle:HXString(@"胎压过高") andStatue:HXString(@"当胎压数值超过压力上限时，发生该警报")];
    [_rootView addSubview:view3];
    

    UIView *view4 = [UIView initUnNStatuewithFrame:CGRectMake(0, MAXY(view3)+15, WIDTH(self.view), 240) andImage:[UIImage imageNamed:HXString(@"4")] andTitle:HXString(@"胎压过低") andStatue:HXString(@"当胎压数值低于压力下限时，发生该警报")];
    [_rootView addSubview:view4];
    
    
    UIView *view5 = [UIView initUnNStatuewithFrame:CGRectMake(0, MAXY(view4)+15, WIDTH(self.view), 240) andImage:[UIImage imageNamed:HXString(@"5")] andTitle:HXString(@"胎压超低") andStatue:HXString(@"当胎压数值低于1BAR、100KPA或15PSI时，发生该警报")];
    [_rootView addSubview:view5];
    
    
    UIView *view6 = [UIView initUnNStatuewithFrame:CGRectMake(0, MAXY(view5)+15, WIDTH(self.view), 240) andImage:[UIImage imageNamed:HXString(@"6")] andTitle:HXString(@"快速泄气") andStatue:HXString(@"当胎压数值在短时间内快速降低时，发生该警报")];
    [_rootView addSubview:view6];
    
    
    UIView *view7 = [UIView initUnNStatuewithFrame:CGRectMake(0, MAXY(view6)+15, WIDTH(self.view), 240) andImage:[UIImage imageNamed:HXString(@"7")] andTitle:HXString(@"胎温过高") andStatue:HXString(@"当胎温数值超过温度上限时，发生该警报")];
    [_rootView addSubview:view7];
    
    
    UIView *view8 = [UIView initUnNStatuewithFrame:CGRectMake(0, MAXY(view7)+15, WIDTH(self.view), 240) andImage:[UIImage imageNamed:HXString(@"8")] andTitle:HXString(@"信号异常") andStatue:HXString(@"当一段时间没有接收到新的胎压、胎温数据时，发生该警报")];
    [_rootView addSubview:view8];
    
    
    UIView *view9 = [UIView initUnNStatuewithFrame:CGRectMake(0, MAXY(view8)+15, WIDTH(self.view), 240) andImage:[UIImage imageNamed:HXString(@"9")] andTitle:HXString(@"发射器电量低") andStatue:HXString(@"当发射器电量过低时，发生该警报（如果发生该警报，请尽快更换电池）")];
    [_rootView addSubview:view9];
    
    
    
    _rootView.contentSize = CGSizeMake(WIDTH(self.view), MAXY(view9)+98);
    
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
