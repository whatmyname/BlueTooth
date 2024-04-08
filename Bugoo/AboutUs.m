//
//  AbhoutUs.m
//  Bugoo
//
//  Created by bugoo on 18/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "AboutUs.h"
#import "ServiceRule.h"
@interface AboutUs ()
@property (nonatomic,strong)UIView *rootView;
@end

@implementation AboutUs

- (void)viewDidLoad {
    [super viewDidLoad];
    _rootView = [[UIView alloc]initWithFrame:self.view.bounds];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    self.title = HXString(@"关于我们");
    [self.view addSubview:_rootView];
    [self createUI];
}

-(void)createUI{
    UIImageView *text = [[UIImageView alloc]initWithImage:[UIImage imageNamed:HXString(@"text")]];
    
    if (kIsIphone4s||kIsIphone5) {
        text = [[UIImageView alloc]initWithImage:[UIImage imageNamed:HXString(@"about-5")]];
    }
    
//    text.text = [NSString stringWithFormat:@"%@\n\n%@",HXString(@"Bugoo创立于2015年初春，是由中国台湾的先进技术、跨国界的品牌设计以及上海的在地化市场运营组合而成的团队。并于2015年中开始拓展东南亚市场，建立起国际品牌的趋势。Bugoo 团队具有完整的供应系统及售后服务，让每一个合作伙伴都能安心推荐 Bugoo 的每一个产品。"),HXString(@"让我们打造更好、更贴心的智能未来，布古与你一同随心而驭。")];
//    text.editable = NO;
//    text.backgroundColor = [UIColor clearColor];
//    text.font = [UIFont systemFontOfSize:14];
//    text.textColor = [Utility colorWithHexString:@"555555"];
//    text.image = [UIImage imageNamed:HXString(@"text")];
    [text setFrame:CGRectMake(15, 15, WIDTH(text), HEIGHT(text))];
    
    [_rootView addSubview:text];
    
//    if (kIsIphone5) {
//        [text setFrame:CGRectMake(X(text), Y(text), WIDTH(text), 154*2)];
//        text.font = [UIFont systemFontOfSize:12];
//    }
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(101, 424, 174, 75)];
    logo.image =[UIImage imageNamed:HXString(@"aboutUs")];
    [_rootView addSubview:logo];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 538, 375, 20)];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:HXString(@"服务条款")];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:strRange];
    [button setAttributedTitle:str forState:UIControlStateNormal];
    [button setTitleColor:[Utility colorWithHexString:@"007acc"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(service:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView addSubview:button];
    
    UILabel *version = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 563, 375, 20)];
    version.text = Version;
    version.font = [UIFont systemFontOfSize:14];
    version.textAlignment = NSTextAlignmentCenter;
    version.textColor = [Utility colorWithHexString:@"777777"];
    [_rootView addSubview:version];
    
}


-(void)service:(UIButton *)button{
    ServiceRule *ser = [[ServiceRule alloc]init];
    [self.navigationController pushViewController:ser animated:YES];
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
