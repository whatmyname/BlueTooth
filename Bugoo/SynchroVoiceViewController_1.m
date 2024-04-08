//
//  SynchroVoiceViewController_1.m
//  Bugoo
//
//  Created by bugoo on 14/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "SynchroVoiceViewController_1.h"
#import "SynchroVoiceViewController_2.h"
@interface SynchroVoiceViewController_1 ()
@property (nonatomic,strong)UIView *rootView;
@end

@implementation SynchroVoiceViewController_1

- (void)viewDidLoad {
    [super viewDidLoad];
    _rootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-64)];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
   
    [self.view addSubview:_rootView];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [Utility colorWithHexString:@"ffffff"];
    self.title = HXString(@"同步语音棒-1");
    self.navigationController.navigationBar.clipsToBounds = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[Utility colorWithHexString:@"ffffff"]}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:HXString(@"关闭") style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    
    [self createUI];
    
    // Do any additional setup after loading the view.
}


-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)createUI{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, Adapt_IPHONE6_scaleV(32), WIDTH(self.view), Adapt_IPHONE6_scaleV(28)*2)];
    [_rootView addSubview:label];
    
    label.text = HXString(@"将语音棒接入USB电源");
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [Utility colorWithHexString:@"333333"];
    label.font = [UIFont systemFontOfSize:20];
    [_rootView addSubview:label];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 97, 356)];
    image.image = [UIImage imageNamed:@"s1"];
    image.center = CGPointMake(WIDTH(_rootView)/2, HEIGHT(_rootView)/2);
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
    SynchroVoiceViewController_2 *s2 = [[SynchroVoiceViewController_2 alloc]init];
    [self.navigationController pushViewController:s2 animated:YES];
    
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
