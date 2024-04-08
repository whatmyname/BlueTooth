//
//  PressSeniorStting.m
//  Bugoo
//
//  Created by bugoo on 16/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "PressSeniorStting.h"
#import "HXTireValue.h"
@interface PressSeniorStting ()
{
    UILabel *pressU;
    UILabel *tempU;
    UILabel *ruleLU;
    UILabel *ruleRU;
}
@property (nonatomic,strong)UILabel *fUpRate;
@property (nonatomic,strong)UILabel *rUpRate;
@property (nonatomic,strong)UILabel *fLowRate;
@property (nonatomic,strong)UILabel *rLowRate;
@property (nonatomic,strong)UIView *rootView;
@property (nonatomic,strong)UILabel *tempRate;
@property (nonatomic,strong)Model *model;
@end

@implementation PressSeniorStting

- (void)viewDidLoad {
    [super viewDidLoad];
    _rootView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view))];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    [self.view addSubview:_rootView];
    _model = [NSKeyedUnarchiver unarchiveObjectWithData:currentD];
    self.title = HXString(@"高级设置");
    [self createUI];

}


-(void)createUI{
    UIView *unit = [UIView initMyView:CGRectMakeIPHONE6Adapt(0, 15, 375, 65+50+50)];
    
    UILabel *unitLabel = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 0, 375-15, 65)];
    unitLabel.text = HXString(@"压力上限");
    unitLabel.font = [UIFont systemFontOfSize:18];
    unitLabel.textColor = [Utility colorWithHexString:@"222222"];
    [unit addSubview:unitLabel];
    
    UIView *unitLine1 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(30, 65, 315, 1)];
    [unit addSubview:unitLine1];
    
    pressU = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(30, 78, 140, 22)];
    pressU.text = HXString(@"前轮=");
    if (kIsIphone5||kIsIphone4s) {
        pressU.font = [UIFont systemFontOfSize:14];
    }
    pressU.textColor = [Utility colorWithHexString:@"444444"];
    [unit addSubview:pressU];
    
    _fUpRate = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(178, 78, 145, 22)];
    _fUpRate.textColor = [Utility colorWithHexString:@"666666"];
    _fUpRate.textAlignment = NSTextAlignmentRight;
    _fUpRate.font = [UIFont systemFontOfSize:16];
    [unit addSubview:_fUpRate];
    if (kIsIphone5) {
        _fUpRate.font = [UIFont systemFontOfSize:14];
    }
    
    UIImageView *arrow1 = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(319, 81, 16, 16)];
    arrow1.image = [UIImage imageNamed:@"rightArrow"];
    [unit addSubview:arrow1];
    
    UIView *unitLine2 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(30, 65+50, 315, 1)];
    [unit addSubview:unitLine2];
    
    tempU = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(30, 128, 140, 22)];
    tempU.text = HXString(@"后轮=");
    tempU.textColor = [Utility colorWithHexString:@"444444"];
    if (kIsIphone5||kIsIphone4s) {
        tempU.font = [UIFont systemFontOfSize:14];
    }
    [unit addSubview:tempU];
    
    _rUpRate = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(178, 128, 145, 22)];
    
    _rUpRate.textColor = [Utility colorWithHexString:@"666666"];
    _rUpRate.textAlignment = NSTextAlignmentRight;
    _rUpRate.font = [UIFont systemFontOfSize:16];
    [unit addSubview:_rUpRate];
    if (kIsIphone5) {
        _rUpRate.font = [UIFont systemFontOfSize:14];
    }
    
    UIImageView *arrow2 = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(319, 81+50, 16, 16)];
    arrow2.image = [UIImage imageNamed:@"rightArrow"];
    [unit addSubview:arrow2];
    
    [_rootView addSubview:unit];

    
    
    
    UIView *rule = [UIView initMyView:CGRectMakeIPHONE6Adapt(0, 225, 375, 65+50+50)];
    
    
    UILabel *ruleLabel = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 0, 375-15, 65)];
    ruleLabel.text = HXString(@"压力下限");
    ruleLabel.font = [UIFont systemFontOfSize:18];
    ruleLabel.textColor = [Utility colorWithHexString:@"222222"];
    [rule addSubview:ruleLabel];
    
    UIView *ruleLine1 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(30, 65, 315, 1)];
    [rule addSubview:ruleLine1];
    
    ruleLU = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(30, 78, 140, 22)];
    ruleLU.text = HXString(@"前轮=");
    ruleLU.textColor = [Utility colorWithHexString:@"444444"];
    if (kIsIphone5||kIsIphone4s) {
        ruleLU.font = [UIFont systemFontOfSize:14];
    }
    [rule addSubview:ruleLU];
    
    _fLowRate = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(178, 78, 145, 22)];
    _fLowRate.textColor = [Utility colorWithHexString:@"666666"];
    _fLowRate.textAlignment = NSTextAlignmentRight;
    _fLowRate.font = [UIFont systemFontOfSize:16];
    [rule addSubview:_fLowRate];
    UIImageView *arrow3 = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(319, 81, 16, 16)];
    arrow3.image = [UIImage imageNamed:@"rightArrow"];
    [rule addSubview:arrow3];
    if (kIsIphone5||kIsIphone4s) {
        _fLowRate.font = [UIFont systemFontOfSize:14];
    }
    
    
    UIView *ruleLine2 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(30, 65+50, 315, 1)];
    [rule addSubview:ruleLine2];
    
    ruleRU = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(30, 128, 140, 22)];
    ruleRU.text = HXString(@"后轮=");
    ruleRU.textColor = [Utility colorWithHexString:@"444444"];
    if (kIsIphone5||kIsIphone4s) {
        ruleRU.font = [UIFont systemFontOfSize:14];
    }
    [rule addSubview:ruleRU];
    
    _rLowRate = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(178, 128, 145, 22)];
    _rLowRate.textColor = [Utility colorWithHexString:@"666666"];
    _rLowRate.textAlignment = NSTextAlignmentRight;
    _rLowRate.font = [UIFont systemFontOfSize:16];
    [rule addSubview:_rLowRate];
    if (kIsIphone5||kIsIphone4s) {
        _rLowRate.font = [UIFont systemFontOfSize:14];
    }
    
    
    UIImageView *arrow4 = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(319, 81+50, 16, 16)];
    arrow4.image = [UIImage imageNamed:@"rightArrow"];
    [rule addSubview:arrow4];
    
    [_rootView addSubview:rule];
    
    

    
    UIView *rate = [UIView initMyView:CGRectMakeIPHONE6Adapt(0, 435, 375, 65+50)];
    
    
    UILabel *rateLabel = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 0, 375-15, 65)];
    rateLabel.text = HXString(@"温度上限");
    rateLabel.font = [UIFont systemFontOfSize:18];
    rateLabel.textColor = [Utility colorWithHexString:@"222222"];
    [rate addSubview:rateLabel];
    
    UIView *rateLine1 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(30, 65, 315, 1)];
    [rate addSubview:rateLine1];
    
    UILabel *rateLU = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(30, 78, 180, 22)];
    rateLU.text = HXString(@"前轮和后轮=");
    rateLU.textColor = [Utility colorWithHexString:@"444444"];
    [rate addSubview:rateLU];
    
    _tempRate = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(178, 78, 145, 22)];
    _tempRate.textColor = [Utility colorWithHexString:@"007acc"];
    _tempRate.textAlignment = NSTextAlignmentRight;
    _tempRate.font = [UIFont systemFontOfSize:16];
    
    [rate addSubview:_tempRate];
    
    UIImageView *arrow5 = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(319, 81, 16, 16)];
    arrow5.image = [UIImage imageNamed:@"rightArrow"];
    [rate addSubview:arrow5];
    
    
    [_rootView addSubview:rate];
    
    
    [self setValue];
    
    UIButton *pressLUp = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 65, 375, 50)];
    [pressLUp addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventTouchUpInside];
    pressLUp.tag = 1;
    [unit addSubview:pressLUp];
    
    UIButton *pressRUp = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 114, 375, 50)];
    pressRUp.tag = 2;
    [pressRUp addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventTouchUpInside];
    [unit addSubview:pressRUp];
    
    
    UIButton *pressLLow = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 65, 375, 50)];
    [pressLLow addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventTouchUpInside];
    pressLLow.tag = 3;
    [rule addSubview:pressLLow];
    
    UIButton *pressRLow = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 114, 375, 50)];
    pressRLow.tag = 4;
    [pressRLow addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventTouchUpInside];
    [rule addSubview:pressRLow];
    
    
    UIButton *tempChange = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 65, 375, 50)];
    [rate addSubview:tempChange];
    [tempChange addTarget:self action:@selector(changeTemp:) forControlEvents:UIControlEventTouchUpInside];
    [self setDefauteModel];
    
}

-(void)setValue{

    if ([self.model.pressUnit isEqualToString:@"KPA"]) {
        pressU.text = [NSString stringWithFormat:@"%@=%.0f%@",HXString(@"前轮"),self.model.flUp,self.model.pressUnit];
        tempU.text = [NSString stringWithFormat:@"%@=%.0f%@",HXString(@"后轮"),self.model.rlUp,self.model.pressUnit];
        ruleLU.text = [NSString stringWithFormat:@"%@=%.0f%@",HXString(@"前轮"),self.model.flLow,self.model.pressUnit];
        ruleRU.text = [NSString stringWithFormat:@"%@=%.0f%@",HXString(@"后轮"),self.model.rlLow,self.model.pressUnit];
    }else if([self.model.pressUnit isEqualToString:@"BAR"]){
        pressU.text = [NSString stringWithFormat:@"%@=%.1f%@",HXString(@"前轮"),kpa2bar(self.model.flUp),self.model.pressUnit];
        tempU.text = [NSString stringWithFormat:@"%@=%.1f%@",HXString(@"后轮"),kpa2bar(self.model.rlUp),self.model.pressUnit];
        ruleLU.text = [NSString stringWithFormat:@"%@=%.1f%@",HXString(@"前轮"),kpa2bar(self.model.flLow),self.model.pressUnit];
        ruleRU.text = [NSString stringWithFormat:@"%@=%.1f%@",HXString(@"后轮"),kpa2bar(self.model.rlLow),self.model.pressUnit];
    }else{
        pressU.text = [NSString stringWithFormat:@"%@=%.0f%@",HXString(@"前轮"),kpa2psi(self.model.flUp),self.model.pressUnit];
        tempU.text = [NSString stringWithFormat:@"%@=%.0f%@",HXString(@"后轮"),kpa2psi(self.model.rlUp),self.model.pressUnit];
        ruleLU.text = [NSString stringWithFormat:@"%@=%.0f%@",HXString(@"前轮"),kpa2psi(self.model.flLow),self.model.pressUnit];
        ruleRU.text = [NSString stringWithFormat:@"%@=%.0f%@",HXString(@"后轮"),kpa2psi(self.model.rlLow),self.model.pressUnit];
        
    }
}

-(void)changeValue:(UIButton *)button{
    HXTireValue *hx = [HXTireValue loadGuide:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)) andUnit:@"rate"];
    
    hx.comBlock = ^(NSString *string){
        
        switch (button.tag) {
            case 1:
            {
                self.model.fUpRate = string.floatValue;
                self.model.flUp = self.model.fRule*(1+self.model.fUpRate);
                [self.model setDefault];
                [self setDefauteModel];
            }
                break;
            case 2:
            {
                self.model.rUpRate = string.floatValue;
                self.model.rlUp = self.model.rRule*(1+self.model.rUpRate);
                [self.model setDefault];
                [self setDefauteModel];
            }
                break;
            case 3:
            {
                self.model.fLowRate = string.floatValue;
                self.model.flLow = self.model.fRule*(1-self.model.fLowRate);
                [self.model setDefault];
                [self setDefauteModel];
            }
                break;
            case 4:
            {
                self.model.rLowRate = string.floatValue;
                self.model.rlLow = self.model.rRule*(1-self.model.rLowRate);
                [self.model setDefault];
                [self setDefauteModel];
            }
            default:
                break;
        }
        [self setValue];
        _change();
        [hx removeFromSuperview];
    };
    hx.cancelBlock = ^(){
        [hx removeFromSuperview];
    };
    
    [_rootView addSubview:hx];
}

-(void)changeTemp:(UIButton *)button{
    HXTireValue *hx;
    if ([self.model.tempUnit isEqualToString:@"℃"]) {
        hx = [HXTireValue loadGuide:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)) andUnit:@"temp"];
        
        hx.comBlock = ^(NSString *string){
            
            self.model.temp = string.floatValue;
            [self.model setDefault];
            [self setDefauteModel];
             _change();
            [hx removeFromSuperview];
        };
        hx.cancelBlock = ^(){
            [hx removeFromSuperview];
        };
        [_rootView addSubview:hx];
    }else{
        hx = [HXTireValue loadGuide:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)) andUnit:@"temp2"];
        
        hx.comBlock = ^(NSString *string){
            
            self.model.temp = fah2cen(string.floatValue);
            [self.model setDefault];
            [self setDefauteModel];
            
            _change();
            [hx removeFromSuperview];
        };
        hx.cancelBlock = ^(){
            [hx removeFromSuperview];
        };
        [_rootView addSubview:hx];
    }
    
   
  
}

-(void)setDefauteModel{
    _model = [NSKeyedUnarchiver unarchiveObjectWithData:currentD];
//    [self.model check];
    [self setRateValue];
    [self setTempValue];
}

-(void)setRateValue{
    
    NSString *fu = [NSString stringWithFormat:@"%@x(1+%.2f)",HXString(@"标准值"),_model.fUpRate];
    NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
    [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-5, 4)];
    _fUpRate.attributedText = strFU;
    
    
    NSString *ru = [NSString stringWithFormat:@"%@x(1+%.2f)",HXString(@"标准值"),_model.rUpRate];
    NSMutableAttributedString *strRU = [[NSMutableAttributedString alloc]initWithString:ru];
    [strRU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strRU.length-5, 4)];
    _rUpRate.attributedText = strRU;
    
    
    NSString *fl = [NSString stringWithFormat:@"%@x(1-%.2f)",HXString(@"标准值"),_model.fLowRate];
    NSMutableAttributedString *strFL = [[NSMutableAttributedString alloc]initWithString:fl];
    [strFL addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFL.length-5, 4)];
    _fLowRate.attributedText = strFL;

    NSString *rl = [NSString stringWithFormat:@"%@x(1-%.2f)",HXString(@"标准值"),_model.rLowRate];
    NSMutableAttributedString *strRL = [[NSMutableAttributedString alloc]initWithString:rl];
    [strRL addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strRL.length-5, 4)];
    _rLowRate.attributedText = strRL;
    
}



-(void)setTempValue{
    NSString *tempUnit = self.model.tempUnit;
    if ([tempUnit isEqualToString:@"℃"]) {
        _tempRate.text = [NSString stringWithFormat:@"%.0f %@",_model.temp,tempUnit];
    }else{
        _tempRate.text = [NSString stringWithFormat:@"%.0f %@",cen2fah(_model.temp),tempUnit];
    }
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
