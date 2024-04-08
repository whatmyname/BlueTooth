//
//  PressSetting.m
//  Bugoo
//
//  Created by bugoo on 16/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "PressSetting.h"
#import "HXTireValue.h"
#import "PressSeniorStting.h"
#import "SynchroVoiceViewController_3.h"
@interface PressSetting (){
    NSString *KPAL;
    NSString *BARL;
    NSString *PSIL;
    
    NSString *KPAR;
    NSString *BARR;
    NSString *PSIR;
    
    BOOL isSetting;
    
    
    BOOL isChange;
}
@property (nonatomic,strong)Model *model;
@property (nonatomic,strong)UIScrollView *rootView;
@property (nonatomic,strong)UILabel *lTire;
@property (nonatomic,strong)UILabel *rTire;
@property (nonatomic,strong)UILabel *lTireRate;
@property (nonatomic,strong)UILabel *rTireRate;
@property (nonatomic,strong)UILabel *tempRate;
@property (nonatomic,strong)UILabel *pressUnitLabel;
@property (nonatomic,strong)UILabel *tempUnitLabel;
@property (nonatomic,strong)NSString *pressUnit;
@property (nonatomic,strong)NSString *tempUnit;
@property (nonatomic,strong)NSString *lRule;
@property (nonatomic,strong)NSString *RRule;


@end

@implementation PressSetting

- (void)viewDidLoad {
    [super viewDidLoad];
    _rootView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view))];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    self.title = HXString(@"轮胎监测设置");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:HXString(@"高级") style:UIBarButtonItemStyleDone target:self action:@selector(senior)];
    
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bar-back"] style:UIBarButtonItemStyleDone target:self action:@selector(goback:)];
//    UIBarButtonItem *bar2 = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(goback:)];
//    
    self.navigationItem.leftBarButtonItem = bar1;
    
    [self getDefauteModel];
    
#pragma -mark 单位
    
    UIView *unit = [UIView initMyView:CGRectMakeIPHONE6Adapt(0, 15, 375, 65+50+50)];
    
    UILabel *unitLabel = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 0, 375-15, 65)];
    unitLabel.text = HXString(@"单位");
    unitLabel.font = [UIFont systemFontOfSize:18];
    unitLabel.textColor = [Utility colorWithHexString:@"222222"];
    [unit addSubview:unitLabel];
    
    UIView *unitLine1 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(30, 65, 315, 1)];
    [unit addSubview:unitLine1];
    
    UILabel *pressU = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(40, 78, 130, 22)];
    pressU.text = HXString(@"压力");
    [unit addSubview:pressU];
    
    _pressUnitLabel = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(188, 78, 130, 22)];
    _pressUnitLabel.textColor = [Utility colorWithHexString:@"007acc"];
    _pressUnitLabel.textAlignment = NSTextAlignmentRight;
    _pressUnitLabel.font = [UIFont systemFontOfSize:16];
    [unit addSubview:_pressUnitLabel];

    
    UIImageView *arrow1 = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(319, 81, 16, 16)];
    arrow1.image = [UIImage imageNamed:@"rightArrow"];
    [unit addSubview:arrow1];
    
    UIView *unitLine2 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(30, 65+50, 315, 1)];
    [unit addSubview:unitLine2];
    
    UILabel *tempU = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(40, 128, 130, 22)];
    tempU.text = HXString(@"温度");
    [unit addSubview:tempU];
    
    _tempUnitLabel = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(188, 128, 130, 22)];
    
    _tempUnitLabel.textColor = [Utility colorWithHexString:@"007acc"];
    _tempUnitLabel.textAlignment = NSTextAlignmentRight;
    _tempUnitLabel.font = [UIFont systemFontOfSize:16];
    [unit addSubview:_tempUnitLabel];

    
    [self setUnitValue];
    
    UIImageView *arrow2 = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(319, 81+50, 16, 16)];
    arrow2.image = [UIImage imageNamed:@"rightArrow"];
    [unit addSubview:arrow2];
    
    [_rootView addSubview:unit];
    
    UILabel *section1  = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 185, 345, 20)];
    section1.text = HXString(@"根据您的习惯设置单位");
    section1.font = [UIFont systemFontOfSize:14];
    section1.textColor = [Utility colorWithHexString:@"8a8a8a"];
    section1.backgroundColor = [UIColor clearColor];
    [_rootView addSubview:section1];
    
#pragma -mark 压力标准值
    
    
    UIView *rule = [UIView initMyView:CGRectMakeIPHONE6Adapt(0, 225, 375, 65+50+50)];
    
    
    UILabel *ruleLabel = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 0, 375-15, 65)];
    ruleLabel.text = HXString(@"压力标准值");
    ruleLabel.font = [UIFont systemFontOfSize:18];
    ruleLabel.textColor = [Utility colorWithHexString:@"222222"];
    [rule addSubview:ruleLabel];
    
    UIView *ruleLine1 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(30, 65, 315, 1)];
    [rule addSubview:ruleLine1];
    
    UILabel *ruleLU = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(40, 78, 130, 22)];
    ruleLU.text = HXString(@"前轮");
    [rule addSubview:ruleLU];
    
    _lTire = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(188, 78, 130, 22)];
    _lTire.textColor = [Utility colorWithHexString:@"007acc"];
    _lTire.textAlignment = NSTextAlignmentRight;
    _lTire.font = [UIFont systemFontOfSize:16];
    [rule addSubview:_lTire];
    UIImageView *arrow3 = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(319, 81, 16, 16)];
    arrow3.image = [UIImage imageNamed:@"rightArrow"];
    [rule addSubview:arrow3];
    
    UIView *ruleLine2 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(30, 65+50, 315, 1)];
    [rule addSubview:ruleLine2];
    
    UILabel *ruleRU = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(40, 128, 130, 22)];
    ruleRU.text = HXString(@"后轮");
    [rule addSubview:ruleRU];
    
    _rTire = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(188, 128, 130, 22)];
    _rTire.textColor = [Utility colorWithHexString:@"007acc"];
    _rTire.textAlignment = NSTextAlignmentRight;
    _rTire.font = [UIFont systemFontOfSize:16];
    [rule addSubview:_rTire];
    
    [self setRule];
    
    UIImageView *arrow4 = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(319, 81+50, 16, 16)];
    arrow4.image = [UIImage imageNamed:@"rightArrow"];
    [rule addSubview:arrow4];
    
    [_rootView addSubview:rule];
    
    UILabel *section2  = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 395, 345, 20*2)];
    section2.text = HXString(@"标准值是您的轮胎正常状态下的压力数值");
    section2.numberOfLines = 2;
    section2.font = [UIFont systemFontOfSize:14];
    section2.textColor = [Utility colorWithHexString:@"8a8a8a"];
    section2.backgroundColor = [UIColor clearColor];
    [_rootView addSubview:section2];
    
    
#pragma -mark 压力安全范围
    
    UIView *rate = [UIView initMyView:CGRectMakeIPHONE6Adapt(0, 435+6, 375, 65+50+50)];
    
    
    UILabel *rateLabel = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 0, 375-15, 65)];
    rateLabel.text = HXString(@"压力安全范围");
    rateLabel.font = [UIFont systemFontOfSize:18];
    rateLabel.textColor = [Utility colorWithHexString:@"222222"];
    [rate addSubview:rateLabel];
    
    UIView *rateLine1 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(30, 65, 315, 1)];
    [rate addSubview:rateLine1];
    
    UILabel *rateLU = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(40, 78, 130, 22)];
    rateLU.text = HXString(@"前轮");
    [rate addSubview:rateLU];
    
    _lTireRate = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(188, 78, 130, 22)];
    _lTireRate.textColor = [Utility colorWithHexString:@"999999"];
    _lTireRate.textAlignment = NSTextAlignmentRight;
    _lTireRate.font = [UIFont systemFontOfSize:16];
    [rate addSubview:_lTireRate];
//    UIImageView *arrow5 = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(319, 81, 16, 16)];
//    arrow5.image = [UIImage imageNamed:@"rightArrow"];
//    [rate addSubview:arrow5];
    
    UIView *rateLine2 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(30, 65+50, 315, 1)];
    [rate addSubview:rateLine2];
    
    UILabel *rateRU = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(40, 128, 130, 22)];
    rateRU.text = HXString(@"后轮");
    [rate addSubview:rateRU];
    
    _rTireRate = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(188, 128, 130, 22)];
    _rTireRate.textColor = [Utility colorWithHexString:@"999999"];
    _rTireRate.textAlignment = NSTextAlignmentRight;
    _rTireRate.font = [UIFont systemFontOfSize:16];
    [rate addSubview:_rTireRate];
    
    
    [self setRateValue];
    
//    UIImageView *arrow6 = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(319, 81+50, 16, 16)];
//    arrow6.image = [UIImage imageNamed:@"rightArrow"];
//    [rate addSubview:arrow6];
    
    [_rootView addSubview:rate];
    
    UILabel *section3  = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 605, 345, 20*2)];
    section3.text = HXString(@"可通过\"高级\"更改压力安全范围");
    section3.numberOfLines = 2;
    section3.font = [UIFont systemFontOfSize:14];
    section3.textColor = [Utility colorWithHexString:@"8a8a8a"];
    section3.backgroundColor = [UIColor clearColor];
    [_rootView addSubview:section3];
    
#pragma -mark 温度安全范围
    
    UIView *temp = [UIView initMyView:CGRectMakeIPHONE6Adapt(0, 645+6, 375, 65)];
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 0, 375-15, 65)];
    tempLabel.text = HXString(@"温度安全范围");
    tempLabel.font = [UIFont systemFontOfSize:18];
    tempLabel.textColor = [Utility colorWithHexString:@"222222"];
    [temp addSubview:tempLabel];
    
    
    _tempRate = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(205, 21, 130, 22)];
    _tempRate.textColor = [Utility colorWithHexString:@"999999"];
    _tempRate.textAlignment = NSTextAlignmentRight;
    _tempRate.font = [UIFont systemFontOfSize:16];
    
    [temp addSubview:_tempRate];
    
    [self setTemp];
    
    [_rootView addSubview:temp];
    
    UILabel *section4  = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 716, 345, 20*2)];
    section4.text = HXString(@"可通过\"高级\"更改温度安全范围");
    section4.numberOfLines = 2;
    section4.font = [UIFont systemFontOfSize:14];
    if (kIsIphone4s||kIsIphone5) {
        section4.font = [UIFont systemFontOfSize:12];
    }
    section4.textColor = [Utility colorWithHexString:@"8a8a8a"];
    section4.backgroundColor = [UIColor clearColor];
    [_rootView addSubview:section4];
    
#pragma -mark 还原出厂设置
    
    UIView *setDefault = [UIView initMyView:CGRectMakeIPHONE6Adapt(0, 756+6, 375, 65)];
    UIButton *button = [[UIButton alloc]initWithFrame:setDefault.bounds];
    [button setTitle:HXString(@"还原出厂设置") forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitleColor:[Utility colorWithHexString:@"222222"] forState:UIControlStateNormal];
    [setDefault addSubview:button];
    [_rootView addSubview:setDefault];
    
    [_rootView setContentSize:CGSizeMake(WIDTH(self.view), MAXY(setDefault)+Adapt_IPHONE6_scaleV(65+44))];
    
    [self.view addSubview:_rootView];
    
#pragma -mark 添加按钮
    
    UIButton *pressUnitButton = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 65, 375, 50)];
    [pressUnitButton addTarget:self action:@selector(changePressUnit:) forControlEvents:UIControlEventTouchUpInside];
    [unit addSubview:pressUnitButton];
    
    UIButton *tempUnitButton = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 114, 375, 50)];
    [tempUnitButton addTarget:self action:@selector(changeTempUnit:) forControlEvents:UIControlEventTouchUpInside];
    [unit addSubview:tempUnitButton];
    
    
    UIButton *pressL = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 65, 375, 50)];
    [pressL addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventTouchUpInside];
    pressL.tag = 1;
    [rule addSubview:pressL];
    
    UIButton *pressR = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 114, 375, 50)];
    pressR.tag = 2;
    [pressR addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventTouchUpInside];
    [rule addSubview:pressR];
    
    UIButton *setDefaultButton = [[UIButton alloc]initWithFrame:setDefault.bounds];
    [setDefaultButton addTarget:self action:@selector(setDefault:) forControlEvents:UIControlEventTouchUpInside];
    [setDefault addSubview:setDefaultButton];
}

-(void)goback:(UIBarButtonItem*)bar{
    if (self.model.isVoice&&!isSetting&&isChange) {
        isSetting = YES;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:HXString(@"温馨提示") message:HXString(@"是否同步语音棒") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:HXString(@"下次再说") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *synac = [UIAlertAction actionWithTitle:HXString(@"去同步") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            SynchroVoiceViewController_3 *s1 = [[SynchroVoiceViewController_3 alloc]init];
            UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:s1];
            
            [self presentViewController:nc animated:YES completion:nil];
            
        }];
        
        [alert addAction:cancel];
        [alert addAction:synac];
        
        [self presentViewController:alert animated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma -mark 按钮方法
-(void)changePressUnit:(UIButton *)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:HXString(@"选择压力单位") preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *KPA = [UIAlertAction actionWithTitle:@"KPA" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setUnit:@"KPA"];
        isChange = YES;
        
    }];
    UIAlertAction *BAR = [UIAlertAction actionWithTitle:@"BAR" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self setUnit:@"BAR"];
        isChange = YES;
        
    }];
    UIAlertAction *PSI = [UIAlertAction actionWithTitle:@"PSI" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self setUnit:@"PSI"];
        isChange = YES;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:HXString(@"取消") style:UIAlertActionStyleCancel handler:nil];
    
    
    [alert addAction:KPA];
    [alert addAction:BAR];
    [alert addAction:PSI];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)changeTempUnit:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:HXString(@"选择温度单位") preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cen = [UIAlertAction actionWithTitle:@"℃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setTempUnit:@"℃"];
        isChange = YES;
        
    }];
    UIAlertAction *fah = [UIAlertAction actionWithTitle:@"℉" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self setTempUnit:@"℉"];
        isChange = YES;
    }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:HXString(@"取消") style:UIAlertActionStyleCancel handler:nil];
    
    
    [alert addAction:cen];
    [alert addAction:fah];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)setTempUnit:(NSString *)unit{
    self.model.tempUnit = unit;
    [self.model setDefault];
    [self setUnitValue];
}

-(void)setUnit:(NSString *)unit{
    self.model.pressUnit = unit;
    [self.model setDefault];
    [self setUnitValue];
}



-(void)changeValue:(UIButton *)button{
    HXTireValue *hx = [HXTireValue loadGuide:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)) andUnit:_pressUnit];
    
    hx.comBlock = ^(NSString *string){
        if (button.tag==1) {
            if ([_pressUnit isEqualToString:@"KPA"]) {
                KPAL = string;
                BARL = [NSString stringWithFormat:@"%.1f",kpa2bar(string.floatValue)];
                PSIL = [NSString stringWithFormat:@"%.0f",kpa2psi(string.floatValue)];
                
            }else if ([_pressUnit isEqualToString:@"BAR"]) {
                KPAL = [NSString stringWithFormat:@"%.0f",bar2kpa(string.floatValue)];
                BARL = string;
                PSIL = [NSString stringWithFormat:@"%.0f",bar2psi(string.floatValue)];
            }else{
                KPAL = [NSString stringWithFormat:@"%.0f",psi2kpa(string.floatValue)];
                BARL = [NSString stringWithFormat:@"%.1f",psi2bar(string.floatValue)];
                PSIL = string;
            }
            self.model.fRule = KPAL.floatValue;
            self.model.flUp = self.model.fRule*(1+self.model.fUpRate);
            self.model.flLow = self.model.fRule*(1-self.model.fLowRate);
         
            [self.model setDefault];
            [self setUnitValue];
        }
        else{
            if ([_pressUnit isEqualToString:@"KPA"]) {
                KPAR = string;
                BARR = [NSString stringWithFormat:@"%.1f",kpa2bar(string.floatValue)];
                PSIR = [NSString stringWithFormat:@"%.0f",kpa2psi(string.floatValue)];
            }else if ([_pressUnit isEqualToString:@"BAR"]) {
                KPAR = [NSString stringWithFormat:@"%.0f",bar2kpa(string.floatValue)];
                BARR = string;
                PSIR = [NSString stringWithFormat:@"%.0f",bar2psi(string.floatValue)];
            }else{
                KPAR = [NSString stringWithFormat:@"%.0f",psi2kpa(string.floatValue)];
                BARR = [NSString stringWithFormat:@"%.1f",psi2bar(string.floatValue)];
                PSIR = string;
            }
            self.model.rRule = KPAR.floatValue;
            self.model.rlUp = self.model.rRule*(1+self.model.rUpRate);
            self.model.rlLow = self.model.rRule*(1-self.model.rLowRate);
            [self.model setDefault];
            [self setUnitValue];
        }
        isChange = YES;
        [hx removeFromSuperview];
    };
    hx.cancelBlock = ^(){
        [hx removeFromSuperview];
    };
    [self.view addSubview:hx];

}

-(void)setDefault:(UIButton *)button{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:HXString(@"还原出厂设置") message:HXString(@"将您的轮胎监测设置还原成出厂的数据") preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cen = [UIAlertAction actionWithTitle:HXString(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        isChange = YES;
        [self.model setDefaultValue];
        [self getDefauteModel];
        
    }];
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:HXString(@"取消") style:UIAlertActionStyleCancel handler:nil];
    
    
    [alert addAction:cen];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    

    
}


#pragma -mark 设定新值

-(void)getDefauteModel{
    self.model = [NSKeyedUnarchiver unarchiveObjectWithData:currentD];
    [self setUnitValue];
}

-(void)setUnitValue{
    _pressUnit = self.model.pressUnit;
    _tempUnit = self.model.tempUnit;
    _pressUnitLabel.text = _pressUnit;
    _tempUnitLabel.text = _tempUnit;
    [self setRule];
    [self setRateValue];
    [self setTemp];
}



-(void)setRule{
    KPAL = [NSString stringWithFormat:@"%.0f",self.model.fRule];
    BARL = [NSString stringWithFormat:@"%.1f",kpa2bar(self.model.fRule)];
    PSIL = [NSString stringWithFormat:@"%.0f",kpa2psi(self.model.fRule)];
    
    KPAR = [NSString stringWithFormat:@"%.0f",self.model.rRule];
    BARR = [NSString stringWithFormat:@"%.1f",kpa2bar(self.model.rRule)];
    PSIR = [NSString stringWithFormat:@"%.0f",kpa2psi(self.model.rRule)];
    
    if ([_pressUnit isEqualToString:@"KPA"]) {
        _lTire.text = [NSString stringWithFormat:@"%@ %@",KPAL,_pressUnit];
        _rTire.text = [NSString stringWithFormat:@"%@ %@",KPAR,_pressUnit];
    }else if([_pressUnit isEqualToString:@"BAR"]){
        _lTire.text = [NSString stringWithFormat:@"%@ %@",BARL,_pressUnit];
        _rTire.text = [NSString stringWithFormat:@"%@ %@",BARR,_pressUnit];
    }else{
        _lTire.text = [NSString stringWithFormat:@"%@ %@",PSIL,_pressUnit];
        _rTire.text = [NSString stringWithFormat:@"%@ %@",PSIR,_pressUnit];
    }
}

-(void)setRateValue{
    KPAL = [NSString stringWithFormat:@"%.0f",self.model.fRule];
    BARL = [NSString stringWithFormat:@"%.1f",kpa2bar(self.model.fRule)];
    PSIL = [NSString stringWithFormat:@"%.0f",kpa2psi(self.model.fRule)];
    
    KPAR = [NSString stringWithFormat:@"%.0f",self.model.rRule];
    BARR = [NSString stringWithFormat:@"%.1f",kpa2bar(self.model.rRule)];
    PSIR = [NSString stringWithFormat:@"%.0f",kpa2psi(self.model.rRule)];

    
    if ([_pressUnit isEqualToString:@"KPA"]) {
        _lTireRate.text = [NSString stringWithFormat:@"%.0f~%.0f %@",KPAL.floatValue*(1-self.model.fLowRate),KPAL.floatValue*(1+self.model.fUpRate),_pressUnit];
        _rTireRate.text = [NSString stringWithFormat:@"%.0f~%.0f %@",KPAR.floatValue*(1-self.model.rLowRate),KPAR.floatValue*(1+self.model.rUpRate),_pressUnit];
    }else if([_pressUnit isEqualToString:@"BAR"]){
//        _lTireRate.text = [NSString stringWithFormat:@"%@~%@ %@",BARL,_pressUnit];
//        _rTireRate.text = [NSString stringWithFormat:@"%@~%@ %@",BARR,_pressUnit];
        _lTireRate.text = [NSString stringWithFormat:@"%.1f~%.1f %@",BARL.floatValue*(1-self.model.fLowRate),BARL.floatValue*(1+self.model.fUpRate),_pressUnit];
        _rTireRate.text = [NSString stringWithFormat:@"%.1f~%.1f %@",BARR.floatValue*(1-self.model.rLowRate),BARR.floatValue*(1+self.model.rUpRate),_pressUnit];
    }else{
//        _lTireRate.text = [NSString stringWithFormat:@"%@~%@ %@",PSIL,_pressUnit];
//        _rTireRate.text = [NSString stringWithFormat:@"%@~%@ %@",PSIR,_pressUnit];
        _lTireRate.text = [NSString stringWithFormat:@"%.0f~%.0f %@",PSIL.floatValue*(1-self.model.fLowRate),PSIL.floatValue*(1+self.model.fUpRate),_pressUnit];
        _rTireRate.text = [NSString stringWithFormat:@"%.0f~%.0f %@",PSIR.floatValue*(1-self.model.rLowRate),PSIR.floatValue*(1+self.model.rUpRate),_pressUnit];
    }
}

-(void)setTemp{
    _tempUnit = self.model.tempUnit;
    if ([_tempUnit isEqualToString:@"℃"]) {
        _tempRate.text = [NSString stringWithFormat:@"%@%.0f %@",HXString(@"小于"),_model.temp,_tempUnit];
    }else{
        _tempRate.text = [NSString stringWithFormat:@"%@%.0f %@",HXString(@"小于"),cen2fah(_model.temp),_tempUnit];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [self getDefauteModel];
}

-(void)senior{
    PressSeniorStting *press = [[PressSeniorStting alloc]init];
    
    press.change = ^(){
        isChange = YES;
    };
    [self.navigationController pushViewController:press animated:YES];
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
