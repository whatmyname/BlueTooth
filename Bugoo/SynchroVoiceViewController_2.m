//
//  SynchroVoiceViewController_2.m
//  Bugoo
//
//  Created by bugoo on 14/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "SynchroVoiceViewController_2.h"
#import "SynchroVoiceViewController_3.h"
@interface SynchroVoiceViewController_2 ()
@property (nonatomic,strong)UIView *rootView;
@end

@implementation SynchroVoiceViewController_2

- (void)viewDidLoad {
    [super viewDidLoad];
    _rootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-64)];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    self.title = HXString(@"同步语音棒-2");
    [self.view addSubview:_rootView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:HXString(@"关闭") style:UIBarButtonItemStyleDone target:self action:@selector(close)];

    [self createUI];

    // Do any additional setup after loading the view.
}


-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)createUI{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, Adapt_IPHONE6_scaleV(32)-10, WIDTH(self.view), Adapt_IPHONE6_scaleV(56))];
    [_rootView addSubview:label];
    
    label.text = HXString(@"长按语音棒的灰色按钮\n听到\"哔\"声后进入蓝牙配对模式");
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [Utility colorWithHexString:@"333333"];
    label.font = [UIFont systemFontOfSize:20];
    [_rootView addSubview:label];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 235, 356)];
    image.center = CGPointMake(WIDTH(image)/2, HEIGHT(_rootView)/2);
    image.image = [UIImage imageNamed:@"s2"];
    [_rootView addSubview:image];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(98, 499, 180, 50)];
    [button setBackgroundColor:[Utility colorWithHexString:@"d8d8d8"]];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [Utility colorWithHexString:@"babfbf"].CGColor;
    button.layer.cornerRadius = 15;
    [button setTitle:HXString(@"下一步") forState:UIControlStateNormal];
    [button setTitleColor:[Utility colorWithHexString:@"007acc"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView addSubview:button];
}



-(void)next:(UIButton *)btn{
    SynchroVoiceViewController_3 *s3 = [[SynchroVoiceViewController_3 alloc]init];
    [self.navigationController pushViewController:s3 animated:YES];
    
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
