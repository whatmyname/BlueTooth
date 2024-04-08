//
//  AddDeciveView_3.m
//  Bugoo
//
//  Created by bugoo on 11/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "AddDeciveView_3.h"
#import "HXTireValue.h"
#import "SynchroVoiceViewController_1.h"


@interface AddDeciveView_3 ()
{
    NSString *tireFRuleValue;
    NSString *tireRRuleValue;
    NSString *tireTempUnit;
    NSString *tirePressUnit;
    UILabel *tireRValue;
    UILabel *tireFValue;
    
    NSString *KPAL;
    NSString *BARL;
    NSString *PSIL;
    
    NSString *KPAR;
    NSString *BARR;
    NSString *PSIR;
    
    NSUInteger number;
    
}
@property (nonatomic,strong)UIView *rootView;
@end

@implementation AddDeciveView_3

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.model check];
    
    self.title = HXString(@"监测设置");
    
    KPAL = @"240";
    BARL = @"2.4";
    PSIL = @"35";
    
    
    KPAR = @"240";
    BARR = @"2.4";
    PSIR  = @"35";
    
    tireRRuleValue = @"35";
    tireFRuleValue = @"35";
    
    tirePressUnit = @"PSI";
    tireTempUnit = @"℃";
    
    _rootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-64)];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    [self createUI];
    
    [self.view addSubview:_rootView];
    
    
    
    
}

-(void)createUI{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, WIDTH(self.view), Adapt_scaleV(56))];
    label.textAlignment = NSTextAlignmentCenter;
    label.text =HXString(@"请根据您的习惯\n和车辆实际情况进行设置");
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [Utility colorWithHexString:@"333333"];
    
//    label.lineBreakMode = NSLineBreakByWordWrapping;

    CGSize size = [label sizeThatFits:CGSizeMake(WIDTH(self.view), MAXFLOAT)];
    
    [label setFrame:CGRectMake(X(label), Y(label)-5, WIDTH(self.view), size.height)];
    
    [_rootView addSubview:label];

    UILabel *pressUnit = [[UILabel alloc]initWithFrame:CGRectMake(0,Adapt_scaleV(91), WIDTH(self.view),Adapt_scaleV(25))];
    pressUnit.backgroundColor = [UIColor clearColor];
    pressUnit.text = HXString(@"胎压单位");
    pressUnit.textAlignment = NSTextAlignmentCenter;
    pressUnit.textColor = [Utility colorWithHexString:@"333333"];
    [_rootView addSubview:pressUnit];
    
    float button_width = (WIDTH(self.view)-45)/3;
    for (int i=0;i<3 ; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(15+i*button_width+i*7.5, Adapt_scaleV(126), button_width,Adapt_scaleV(50))];
        switch (i) {
            case 0:
                [button setTitle:@"PSI" forState:UIControlStateNormal];
                break;
            case 1:
                [button setTitle:@"BAR" forState:UIControlStateNormal];
                break;
            case 2:
                [button setTitle:@"KPA" forState:UIControlStateNormal];
            default:
                break;
        }
        [_rootView addSubview:button];
        button.tag = i+101;
        [button setTitleColor:[Utility colorWithHexString:@"555555"] forState:UIControlStateNormal];
        button.layer.borderColor = [Utility colorWithHexString:@"babfbf"].CGColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 15;
        button.layer.borderWidth = 1;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.backgroundColor = [Utility colorWithHexString:@"faffff"];
        [button setTitleColor:[Utility colorWithHexString:@"0079cc"] forState:UIControlStateSelected];
        if (i==0) {
            button.selected = YES;
            [button setTitleColor:[Utility colorWithHexString:@"13b6f1"] forState:UIControlStateNormal];
            button.backgroundColor = [Utility colorWithHexString:@"D8D8D8"];
        }
        [button addTarget:self action:@selector(chosePressUnit:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *tempUnit = [[UILabel alloc]initWithFrame:CGRectMake(0,Adapt_scaleV(196), WIDTH(self.view), Adapt_scaleV(25))];
    tempUnit.backgroundColor = [UIColor clearColor];
    tempUnit.text = HXString(@"温度单位");
    tempUnit.textColor = [Utility colorWithHexString:@"333333"];
    [_rootView addSubview:tempUnit];
    tempUnit.textAlignment = NSTextAlignmentCenter;
    
    float tempbutton_width = (WIDTH(self.view)-30)/2;
    for (int i=0;i<2; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(15+i*tempbutton_width+i*7.5, Adapt_scaleV(231), tempbutton_width,Adapt_scaleV(50))];
        switch (i) {
            case 0:
                [button setTitle:@"℃" forState:UIControlStateNormal];
                break;
            case 1:
                [button setTitle:@"℉" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        [_rootView addSubview:button];
        button.tag = i+201;
        [button setTitleColor:[Utility colorWithHexString:@"555555"] forState:UIControlStateNormal];
        button.layer.borderColor = [Utility colorWithHexString:@"babfbf"].CGColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 15;
        button.layer.borderWidth = 1;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.backgroundColor = [Utility colorWithHexString:@"faffff"];
        [button setTitleColor:[Utility colorWithHexString:@"0079cc"] forState:UIControlStateSelected];
        if (i==0) {
            button.selected = YES;
            [button setTitleColor:[Utility colorWithHexString:@"13b6f1"] forState:UIControlStateNormal];
            button.backgroundColor = [Utility colorWithHexString:@"D8D8D8"];
        }
        
        [button addTarget:self action:@selector(choseTempUnit:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *pressRuleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Adapt_scaleV(301), WIDTH(self.view), Adapt_scaleV(25))];
    pressRuleLabel.backgroundColor = [UIColor clearColor];
    pressRuleLabel.text = HXString(@"胎压标准值");
    pressRuleLabel.textColor = [Utility colorWithHexString:@"333333"];
    pressRuleLabel.textAlignment = NSTextAlignmentCenter;
    [_rootView addSubview:pressRuleLabel];
    
    UIView *Fview = [[UIView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15,336, 345,50)];
    Fview.layer.borderColor = [Utility colorWithHexString:@"babfbf"].CGColor;
    Fview.layer.borderWidth = 1;
    Fview.layer.cornerRadius = 15;
    Fview.backgroundColor = [Utility colorWithHexString:@"d8d8d8"];
    UILabel *tireFRule = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(23, 14, 150, 22)];
    tireFRule.text = HXString(@"前轮胎压标准值");
    tireFRule.textColor = [Utility colorWithHexString:@"555555"];
    tireFRule.font = [UIFont systemFontOfSize:16];
    tireFRule.textAlignment = NSTextAlignmentRight;
    [Fview addSubview:tireFRule];
    
    
    tireFValue = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(178, 14, 75, 22)];
    tireFValue.textColor = [Utility colorWithHexString:@"007acc"];
    tireFValue.text = [NSString stringWithFormat:@"%@ %@",tireFRuleValue,tirePressUnit];
    tireFValue.font = [UIFont systemFontOfSize:16];
    tireFValue.textAlignment = NSTextAlignmentRight;
    [Fview addSubview:tireFValue];
    
    UIImageView *imageF = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(258.75, 19.13, 11.74, 11.74)];
    imageF.image =  [UIImage imageNamed:@"rightArrow"];
    
    [Fview addSubview:imageF];
    
    UIButton *buttonF = [[UIButton alloc]initWithFrame:Fview.bounds];
    [Fview addSubview:buttonF];
    buttonF.tag = 1;
    [buttonF addTarget:self action:@selector(setRuleValue:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView addSubview:Fview];
    
    
    UIView *Rview = [[UIView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15,396, 345,50)];
    Rview.layer.borderColor = [Utility colorWithHexString:@"babfbf"].CGColor;
    Rview.layer.borderWidth = 1;
    Rview.layer.cornerRadius = 15;
    Rview.backgroundColor = [Utility colorWithHexString:@"d8d8d8"];
    UILabel *tireRRule = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(23, 14, 150, 22)];
    tireRRule.text = HXString(@"后轮胎压标准值");
    tireRRule.textColor = [Utility colorWithHexString:@"555555"];
    tireRRule.font = [UIFont systemFontOfSize:16];
    tireRRule.textAlignment = NSTextAlignmentRight;
    [Rview addSubview:tireRRule];
    
    
    tireRValue = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(178, 14, 75, 22)];
    tireRValue.textColor = [Utility colorWithHexString:@"007acc"];
    tireRValue.text = [NSString stringWithFormat:@"%@ %@",tireRRuleValue,tirePressUnit];
    tireRValue.font = [UIFont systemFontOfSize:16];
    tireRValue.textAlignment = NSTextAlignmentRight;
    [Rview addSubview:tireRValue];
    
    UIImageView *imageR = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(258.75, 19.13, 11.74, 11.74)];
    imageR.image =  [UIImage imageNamed:@"rightArrow"];
    
    [Rview addSubview:imageR];
    
    UIButton *buttonR = [[UIButton alloc]initWithFrame:Rview.bounds];
    [Rview addSubview:buttonR];
    buttonR.tag = 2;
    [buttonR addTarget:self action:@selector(setRuleValue:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView addSubview:Rview];
    
    
    
    UIButton *down = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(98, 499, 180, 50)];
    [down setTitle:HXString(@"完成") forState:UIControlStateNormal];
    down.layer.cornerRadius = 15;
    down.layer.borderWidth = 1;
    down.backgroundColor = [Utility colorWithHexString:@"d8d8d8"];
    down.layer.masksToBounds = YES;
    down.layer.borderColor = [Utility colorWithHexString:@"babfbf"].CGColor;
    [down setTitleColor:[Utility colorWithHexString:@"007acc"] forState:UIControlStateNormal];
    [down addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView addSubview:down];

}



-(void)cleanStatueView{
    for (int i=101; i<=103; i++) {
        
        UIButton *btn = [_rootView viewWithTag:i];
        btn.selected = NO;
        btn.backgroundColor = [Utility colorWithHexString:@"faffff"];
        [btn setTitleColor:[Utility colorWithHexString:@"555555"] forState:UIControlStateNormal];

    }
    
}


-(void)clear:(UIButton*)button{
    NSMutableArray *arr = Peripherals_Arr?[NSMutableArray arrayWithArray:Peripherals_Arr]:[NSMutableArray array];
    self.model.pressUnit = tirePressUnit;
    self.model.tempUnit = tireTempUnit;
    number = arr.count;
    self.model.name = [NSString stringWithFormat:@"Motor%lu",number];
    [self cheackName];
    
    self.model.fUpRate = 0.25;
    self.model.fLowRate = 0.25;
    self.model.rUpRate = 0.25;
    self.model.rLowRate = 0.25;
    self.model.temp = 80;
    self.model.fRule = KPAL.floatValue;
    self.model.rRule = KPAR.floatValue;
    self.model.flUp = KPAL.floatValue*1.25;
    self.model.rlUp = KPAR.floatValue*1.25;
    self.model.flLow = KPAL.floatValue*0.75;
    self.model.rlLow = KPAR.floatValue*0.75;
    self.model.voiceType = voice1;
    self.model.isShake = 1;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.model];
    [arr addObject:data];
    if (arr.count>0) {
        [arr exchangeObjectAtIndex:0 withObjectAtIndex:arr.count-1];
    }
    
    
    
    DEFAULTS_INFO(data, @"Device");
    DEFAULTS_INFO(arr, @"Per");
    DEFAULTS_SYNCHRONIZE;
//    [self.model setDefault];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:HXString(@"请选择") message:HXString(@"该选择对后续使用有一定影响，请根据您的实际情况进行选择") preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *Action = [UIAlertAction actionWithTitle:HXString(@"没有语音棒，完成") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
        
    }];
    UIAlertAction *twoAc = [UIAlertAction actionWithTitle:HXString(@"有语音棒，去同步") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        SynchroVoiceViewController_1 *s1 = [[SynchroVoiceViewController_1 alloc]init];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:s1];
        
        [self presentViewController:nc animated:YES completion:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];

    }];
    
    [alert addAction:Action];
    [alert addAction:twoAc];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)cheackName{
    NSMutableArray *arr = Peripherals_Arr?[NSMutableArray arrayWithArray:Peripherals_Arr]:[NSMutableArray array];
  
    
    for (NSData *data in arr) {
        Model *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if ([model.name isEqualToString:self.model.name]) {
            self.model.name = [NSString stringWithFormat:@"Motor%lu",number++];
            [self cheackName];
        }
    }
}



-(void)chosePressUnit:(UIButton *)button{
    [self cleanStatueView];
    [button setSelected:YES];
    [button setTitleColor:[Utility colorWithHexString:@"13b6f1"] forState:UIControlStateNormal];
    button.backgroundColor = [Utility colorWithHexString:@"D8D8D8"];
    [self reSetPressValue:button];
}

-(void)choseTempUnit:(UIButton *)button{
    [self cleanTempStatueView];
    
    [button setSelected:YES];
    
    [button setTitleColor:[Utility colorWithHexString:@"13b6f1"] forState:UIControlStateNormal];
    button.backgroundColor = [Utility colorWithHexString:@"D8D8D8"];
    
    tireTempUnit = button.currentTitle;

}

-(void)cleanTempStatueView{
    for (int i=201; i<=202; i++) {
        
        UIButton *btn = [_rootView viewWithTag:i];
        btn.selected = NO;
        btn.backgroundColor = [Utility colorWithHexString:@"faffff"];
        [btn setTitleColor:[Utility colorWithHexString:@"555555"] forState:UIControlStateNormal];
        
    }
}


-(void)reSetPressValue:(UIButton *)tag{
    
    switch (tag.tag) {
        case 101:{

            tireFValue.text = PSIL;
            tireRValue.text = PSIR;
        }
            break;
        case 102:{
    
            tireFValue.text = BARL;
            tireRValue.text = BARR;
        }
            break;
        case 103:{
     
            tireFValue.text = KPAL;
            tireRValue.text = KPAR;
        }
            break;
        default:
            break;
    }
    
    tireFValue.text = [NSString stringWithFormat:@"%@ %@",tireFValue.text,tag.currentTitle];
    tireRValue.text = [NSString stringWithFormat:@"%@ %@",tireRValue.text,tag.currentTitle];
    
    tirePressUnit = tag.currentTitle;
 
    
}



-(void)setRuleValue:(UIButton *)button{
   HXTireValue *hx = [HXTireValue loadGuide:CGRectMake(0, 64, WIDTH(self.view), HEIGHT(self.view)) andUnit:tirePressUnit];
    
    hx.comBlock = ^(NSString *string){
        if (button.tag==1) {
            tireFRuleValue = string;
            tireFValue.text = [NSString stringWithFormat:@"%@ %@",tireFRuleValue,tirePressUnit];
            if ([tirePressUnit isEqualToString:@"KPA"]) {
                KPAL = string;
                BARL = [NSString stringWithFormat:@"%.1f",kpa2bar(tireFRuleValue.floatValue)];
                PSIL = [NSString stringWithFormat:@"%.0f",kpa2psi(tireFRuleValue.floatValue)];
            }else if ([tirePressUnit isEqualToString:@"BAR"]) {
                KPAL = [NSString stringWithFormat:@"%.0f",bar2kpa(tireFRuleValue.floatValue)];
                BARL = string;
                PSIL = [NSString stringWithFormat:@"%.0f",bar2psi(tireFRuleValue.floatValue)];
            }else{
                KPAL = [NSString stringWithFormat:@"%.0f",psi2kpa(tireFRuleValue.floatValue)];
                BARL = [NSString stringWithFormat:@"%.1f",psi2bar(tireFRuleValue.floatValue)];
                PSIL = string;
            }
        }
        else{
            tireRRuleValue = string;
            tireRValue.text = [NSString stringWithFormat:@"%@ %@",tireRRuleValue,tirePressUnit];
            if ([tirePressUnit isEqualToString:@"KPA"]) {
                KPAR = string;
                BARR = [NSString stringWithFormat:@"%.1f",kpa2bar(tireRRuleValue.floatValue)];
                PSIR = [NSString stringWithFormat:@"%.0f",kpa2psi(tireRRuleValue.floatValue)];
            }else if ([tirePressUnit isEqualToString:@"BAR"]) {
                KPAR = [NSString stringWithFormat:@"%.0f",bar2kpa(tireRRuleValue.floatValue)];
                BARR = string;
                PSIR = [NSString stringWithFormat:@"%.0f",bar2psi(tireRRuleValue.floatValue)];
            }else{
                KPAR = [NSString stringWithFormat:@"%.0f",psi2kpa(tireRRuleValue.floatValue)];
                BARR = [NSString stringWithFormat:@"%.1f",psi2bar(tireRRuleValue.floatValue)];
                PSIR = string;
            }
        }
        [hx removeFromSuperview];
        
//        NSLog(@"KPAL:%@",KPAL);
//        NSLog(@"BARL:%@",BARL);
//        NSLog(@"PSIL:%@",PSIL);
//        
//        NSLog(@"KPAR:%@",KPAR);
//        NSLog(@"BARR:%@",BARR);
//        NSLog(@"PSIR:%@",PSIR);
    };
    hx.cancelBlock = ^(){
        [hx removeFromSuperview];
    };
    [hx show];
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
