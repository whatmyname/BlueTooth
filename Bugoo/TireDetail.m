//
//  TireDetail.m
//  Bugoo
//
//  Created by bugoo on 10/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "TireDetail.h"

#define kCountTime 600
#define NotiTime  1200
@interface TireDetail()
{
    float currentPress;
    float currentTemp;
    int electricity;
    int sinageTime;
    float up;
    float low;
    float tempLimte;
    float upRate;
    float lowRate;
    int Leak;
    BOOL alert1;            //超低压
    BOOL alert2;            //低压
    BOOL alert3;            //高压
    BOOL alert4;            //温度异常
    BOOL alert5;            //发射器电量低
    BOOL alert6;            //信号异常
    BOOL alert7;            //快速而泄气
    float value;            //快速泄气比较值
    int singalNumer;        //信号计数
    int notiNumer;
    NSString *currentTitle;
    NSString *oldTitle;
    NSString *tireId;
    
}
@property (nonatomic,strong)UIImageView *back;    //背景图片
@property (nonatomic,strong)UIImageView *alert;   //异常图片
@property (nonatomic,strong)UILabel *press;       //压力数值
@property (nonatomic,strong)UILabel *pressUnit;   //压力单位
@property (nonatomic,strong)UILabel *temp;        //温度数值
@property (nonatomic,strong)UILabel *tempUnit;    //温度单位
@property (nonatomic,strong)UILabel *title;       //轮胎位置
@property (nonatomic,strong)UILabel *detailUnusual;  //轮胎详情
@property (nonatomic,strong)UIImageView *eleLow;     //电量低警示
@property (nonatomic,strong)UIImageView *tempOver;   //温度高警示
@property (nonatomic,strong)UIImageView *signal;     //信号异常警示
@property (nonatomic,strong)NSTimer *timer;         //信号异常计时器
@end


@implementation TireDetail

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andModel:(Model *)model{
    if (self=[super initWithFrame:frame]) {
        self.model = model;
        _title = [[UILabel alloc]init];
        _title.text = title;
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    _back = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 150, 150)];
    
    _back.image = [UIImage imageNamed:@"normal"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tireValueChangeNotification:) name:kTireValueChangeNotification object:nil];

    
    [self addSubview:_back];
//    NSLog(@"%@",_back);

//    [_model check];
    
    _alert = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"alert"]];
    _alert.center = CGPointMake(_back.center.x, _alert.center.y+16);
    _alert.hidden = YES;
    [self addSubview:_alert];
    
    
    _eleLow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lowPower"]];
    _eleLow.hidden = YES;
    [_eleLow setFrame:CGRectMake(Adapt_IPHONE6_scaleL(20),Adapt_IPHONE6_scaleV(66), WIDTH(_eleLow), HEIGHT(_eleLow))];
    [self addSubview:_eleLow];
    
    
    _signal = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(117, 66, 13, 19)];
    _signal.image = [UIImage imageNamed:@"sigal"];
    _signal.hidden = YES;
//    _signal.center = CGPointMakeIPHONE6Adapt(WIDTH(_back)-20-WIDTH(_signal)/2,_eleLow.center.y);
    [self addSubview:_signal];
    
    _press = [[UILabel alloc]initWithFrame:CGRectMake(0,Adapt_IPHONE6_scaleV(35), WIDTH(self),Adapt_IPHONE6_scaleV(43))];
    _press.textColor = [Utility colorWithHexString:@"ffffff"];
    _press.textAlignment = NSTextAlignmentCenter;
    _press.text = @"---";
    _press.font  = [UIFont systemFontOfSize:36];
    
    [self addSubview:_press];
    
    _pressUnit = [[UILabel alloc]initWithFrame:CGRectMake(0, MAXY(_press ), WIDTH(self),Adapt_IPHONE6_scaleV(16))];
    _pressUnit.textColor = [Utility colorWithHexString:@"ffffff"];
    _pressUnit.textAlignment = NSTextAlignmentCenter;
    _pressUnit.text = self.model.pressUnit;
    _pressUnit.font = [UIFont systemFontOfSize:14];
    [self addSubview:_pressUnit];
    
    
    _tempOver = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tempover"]];
    _tempOver.hidden = YES;
    [_tempOver setFrame:CGRectMake(Adapt_IPHONE6_scaleL(32), HEIGHT(_back)-16-HEIGHT(_tempOver), WIDTH(_tempOver), HEIGHT(_tempOver))];
    [self addSubview:_tempOver];
    
    _temp = [[UILabel alloc]initWithFrame:CGRectMake(0, Y(_tempOver), WIDTH(self),Adapt_IPHONE6_scaleV(24))];
    _temp.textColor = [Utility colorWithHexString:@"ffffff"];
    _temp.textAlignment = NSTextAlignmentCenter;
    _temp.text = @"--";
    _temp.font = [UIFont systemFontOfSize:20];
    [self addSubview:_temp];
    
    _tempUnit = [[UILabel alloc]initWithFrame:CGRectMake(0, Y(_temp)+2,Adapt_IPHONE6_scaleL(20),Adapt_IPHONE6_scaleV(20))];
    _tempUnit.center = CGPointMake(WIDTH(_back)-Adapt_IPHONE6_scaleL(50), _tempUnit.center.y);
    _tempUnit.textColor = [Utility colorWithHexString:@"ffffff"];
    _tempUnit.textAlignment = NSTextAlignmentCenter;
    _tempUnit.text = self.model.tempUnit;
    _tempUnit.font = [UIFont systemFontOfSize:14];
    [self addSubview:_tempUnit];
    
    [_title setFrame:CGRectMake(0, MAXY(_back)+5, WIDTH(self),Adapt_IPHONE6_scaleV(25))];
    _title.textColor = [Utility colorWithHexString:@"e9e9e9"];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.font = [UIFont systemFontOfSize:18];
    [self addSubview:_title];
    
    _detailUnusual = [[UILabel alloc]initWithFrame:CGRectMake(0, MAXY(_title)+5, WIDTH(self),Adapt_IPHONE6_scaleV(25))];
    _detailUnusual.textColor = [Utility colorWithHexString:@"e9e9e9"];
    _detailUnusual.textAlignment = NSTextAlignmentCenter;
    _detailUnusual.font = [UIFont systemFontOfSize:18];
    _detailUnusual.text = HXString(@"");
    _detailUnusual.numberOfLines = 0;
    [self addSubview:_detailUnusual];
    
    notiNumer = 1;
    [self setVale];
}

-(void)setVale{
    if ([self.title.text isEqualToString:HXString(@"前轮")]) {
        up = self.model.flUp;
        low = self.model.flLow;
        upRate = self.model.fUpRate;
        lowRate = self.model.fLowRate;
    }else{
        up = self.model.rlUp;
        low = self.model.rlLow;
        upRate = self.model.rUpRate;
        lowRate = self.model.rLowRate;
        
    }
    tempLimte = self.model.temp;
    Leak = 15;
}

- (void)tireValueChangeNotification:(NSNotification *)notification {
    
    
    
    
    NSDictionary *dic = notification.object;
    
    NSString *press = dic[@"tirePressure"];
    NSString *temp =dic[@"tireTemperature"];
    NSString *eleString = dic[@"Electricity"];
    tireId = dic[@"tireID"];
    if ([dic[@"tireID"] isEqualToString:self.tId]) {
        if ([self.model.pressUnit isEqualToString:@"KPA"]) {
            _press.text = [NSString stringWithFormat:@"%@",press] ;
        }else if([self.model.pressUnit isEqualToString:@"BAR"]){
            _press.text = [NSString stringWithFormat:@"%.1f",kpa2bar(press.floatValue)] ;
        }else{
            _press.text = [NSString stringWithFormat:@"%.0f",kpa2psi(press.floatValue)] ;
        }
        
        
        
        if ([self.model.tempUnit isEqualToString:@"℃"]) {
            _temp.text = [NSString stringWithFormat:@"%@",temp];
        }else{
            _temp.text = [NSString stringWithFormat:@"%.0f",cen2fah(temp.floatValue)] ;
        }
        
        currentPress = press.floatValue;
        currentTemp = temp.floatValue;
        electricity = eleString.intValue;
        [self setStatue:currentPress andTemp:currentTemp andEle:electricity];
       
    }
    
}

-(void)timerCount{
    if(sinageTime) {
        sinageTime--;
        alert6 = NO;
        [self.timer invalidate];
        self.timer = nil;
        _signal.hidden = NO;
        [_back setImage:[UIImage imageNamed:@"unusual"]];
        _alert.hidden = NO;
        _changeTireUn();
    }else{
        alert6 = YES;
        _signal.hidden = NO;
        _alert.hidden = YES;
        ;
        [_back setImage:[UIImage imageNamed:@"normal"]];
        _changeTire();
    }
    
    
    if (notiNumer==0) {
        notiNumer=0;
    }else{
        notiNumer--;
    }
    
    
    if (Leak!=0) {
        Leak--;
    }else{
        Leak=0;
    }
    
    [self setVoice];
}




-(void)setStatue:(float)press andTemp:(float)temp andEle:(int)ele{
    if(_timer==nil){
        _timer = [NSTimer  timerWithTimeInterval:1 target:self selector:@selector(timerCount) userInfo:nil repeats:YES];
    }
    sinageTime = kCountTime;
    if (notiNumer!=0) {
        notiNumer = NotiTime;
    }
    
    if(press<=100){
        alert1 = YES;
        alert2 = NO;
        alert3 = NO;
    }else if(press<=low&&press>100){
        alert2 = YES;
        alert1 = NO;
        alert3 = NO;
    }else if(press>=up){
        alert3 = YES;
        alert1 = NO;
        alert2 = NO;
    }else{
        alert1 = NO;
        alert2 = NO;
        alert3 = NO;
    }
    
    if (temp>=tempLimte&&temp<=85) {
        alert4 = YES;
    }else{
        alert4 = NO;
    }
    
    if(ele){
        alert5 = YES;
        _eleLow.hidden = NO;
        _detailUnusual.text = HXString(@"发射器电量低");
    }else{
        alert5 = NO;
        _eleLow.hidden = YES;
        if ([_detailUnusual.text isEqualToString:HXString(@"发射器电量低")]) {
            _detailUnusual.text = @"";
        }
        
    }
    
    
    if (alert4) {
        _temp.textColor = alertColor;
        _tempUnit.textColor = alertColor;
        _tempOver.hidden = NO;
        _detailUnusual.text = HXString(@"胎温过高");
   
    }else{
        _temp.textColor = normalColor;
        _tempUnit.textColor = normalColor;
        _tempOver.hidden = YES;
        if ([_detailUnusual.text isEqualToString:HXString(@"胎温过高")])
        _detailUnusual.text = @"";
    }
    
    
    
    
    if (alert1||alert2||alert3) {
        _press.textColor = alertColor;
        _pressUnit.textColor = alertColor;
        _alert.hidden = NO;
        if (alert1) {
            _detailUnusual.text = HXString(@"胎压超低");
        }else if(alert2){
            _detailUnusual.text = HXString(@"胎压过低");
        }else if(alert3){
            _detailUnusual.text = HXString(@"胎压过高");
        }
    }else{
        _press.textColor = normalColor;
        _pressUnit.textColor = normalColor;
        _alert.hidden = YES;
        if ([_detailUnusual.text isEqualToString:HXString(@"胎压过低")]||[_detailUnusual.text isEqualToString:HXString(@"胎压超低")]||[_detailUnusual.text isEqualToString:HXString(@"胎压过高")])
        _detailUnusual.text = @"";
    }
    
    if(value){
        if (value-press>20&&Leak!=0) {
            alert7 = YES;
            Leak = 15;
//            if (![appDelegate.voiceArr containsObject:@"01-7"]) {
//                [appDelegate.voiceArr addObject:@"01-7"];
//            }
            _detailUnusual.text = HXString(@"快速泄气");
            value = press;
        }
        else{
            Leak = 15;
            value = press;
            alert7 = NO;
            if([_detailUnusual.text isEqualToString:HXString(@"快速泄气")])
            _detailUnusual.text = @"";
        }
        
    }else{
        value = press;
    }
    
    if (alert1||alert2||alert3||alert4||alert7) {
        [_back setImage:[UIImage imageNamed:@"unusual"]];
        _detailUnusual.textColor = alertColor;
        _title.textColor = alertColor;
        _changeTireUn();
        _alert.hidden = NO;
        
    }else{
        [_back setImage:[UIImage imageNamed:@"normal"]];
//        _detailUnusual.textColor = normalColor;
        _title.textColor = normalColor;
        _changeTire();
        _alert.hidden = YES;
    }
    
    [self setVoice];
    
    
    
    
    CGSize size = [_detailUnusual sizeThatFits:CGSizeMake(WIDTH(_detailUnusual), MAXFLOAT)];
    
    [_detailUnusual setFrame:CGRectMake(X(_detailUnusual), Y(_detailUnusual), WIDTH(_detailUnusual), size.height)];
    
    
}

-(void)sendNoti:(NSString *)string{
    UIApplication *application = [UIApplication sharedApplication];
    if (application.applicationState == UIApplicationStateActive) {
        return;
    }else if (application.applicationState == UIApplicationStateInactive)
    {
        
    }else if(application.applicationState == UIApplicationStateBackground){
        UILocalNotification *localnotification = [[UILocalNotification alloc]init];
        /**
         *  设置推送的相关属性
         */
        localnotification.fireDate = [NSDate dateWithTimeInterval:0 sinceDate:[NSDate date]];//通知触发时间
        localnotification.alertBody = string;//通知具体内容
        localnotification.alertTitle = @"Bugoo TPMS";//谁发出的通知
        
        //        NSString *path = [[NSBundle mainBundle] pathForResource:@"01-1" ofType:@"mp3"];
        //        localnotification.soundName = path;//通知时的音效
        //        localnotification.applicationIconBadgeNumber = 1;
        localnotification.alertAction = @"";
        [[UIApplication sharedApplication] scheduleLocalNotification:localnotification];
        [[UIApplication sharedApplication] presentLocalNotificationNow:localnotification];//立即发出本通知
        
    }

}


-(void)setVoice{
    
    if(self.model.voiceType!=Mute){
        _alertShow();
    }
    
    if ([tireId isEqualToString:self.model.lfid]) {
        if (alert5) {
            _addVoice(HXString(@"01-1"));
            currentTitle = [NSString stringWithFormat:@"%@ %@",HXString(@"前轮"),HXString(@"发射器电量低")] ;
        }else{
            _rmVoice(HXString(@"01-1"));
        }
        
        if (alert1) {
            _addVoice(HXString(@"01-6"));
            currentTitle = [NSString stringWithFormat:@"%@ %@",HXString(@"前轮"),HXString(@"胎压超低")] ;
            
        }else{
            _rmVoice(HXString(@"01-6"));
        }
        
        if (alert2) {
            _addVoice(HXString(@"01-2"));
            currentTitle = [NSString stringWithFormat:@"%@ %@",HXString(@"前轮"),HXString(@"胎压过低")] ;
            
        }else{
            _rmVoice(HXString(@"01-2"));
        }
        
        if (alert3) {
            _addVoice(HXString(@"01-3"));
            currentTitle = [NSString stringWithFormat:@"%@ %@",HXString(@"前轮"),HXString(@"胎压过高")] ;
            
        }else{
            _rmVoice(HXString(@"01-3"));
        }
        
        if (alert4) {
            _addVoice(HXString(@"01-5"));
            currentTitle = [NSString stringWithFormat:@"%@ %@",HXString(@"前轮"),HXString(@"胎温过高")] ;
            
        }else{
            _rmVoice(HXString(@"01-5"));
        }
        
//        if (alert7){
//            _addVoice(HXString(@"01-7"));
//            currentTitle = HXString(@"前轮信号异常");
//            
//        }else{
//            _rmVoice(HXString(@"01-7"));
//        }
        
        
        
    }else if([tireId isEqualToString:self.model.rfid]){
        
        if (alert5) {
            _addVoice(HXString(@"02-1"));
            currentTitle = [NSString stringWithFormat:@"%@ %@",HXString(@"后轮"),HXString(@"发射器电量低")] ;
        }else{
            _rmVoice(HXString(@"02-1"));
            
        }
        
        if (alert1) {
            _addVoice(HXString(@"02-6"));
            currentTitle = [NSString stringWithFormat:@"%@ %@",HXString(@"后轮"),HXString(@"胎压超低")] ;
            
        }else{
            _rmVoice(HXString(@"02-6"));
        }
        
        if (alert2) {
            _addVoice(HXString(@"02-2"));
            currentTitle = [NSString stringWithFormat:@"%@ %@",HXString(@"后轮"),HXString(@"胎压过低")] ;
            
        }else{
            _rmVoice(HXString(@"02-2"));
        }
        
        if (alert3) {
            _addVoice(HXString(@"02-3"));
            currentTitle = [NSString stringWithFormat:@"%@ %@",HXString(@"后轮"),HXString(@"胎压过高")] ;
            
        }else{
            _rmVoice(HXString(@"02-3"));
        }
        
        if (alert4) {
            _addVoice(HXString(@"02-5"));
            currentTitle = [NSString stringWithFormat:@"%@ %@",HXString(@"后轮"),HXString(@"胎温过高")] ;
            
        }else{
            _rmVoice(HXString(@"02-5"));
        }
//        if (alert7){
//            _addVoice(HXString(@"02-7"));
//            currentTitle = HXString(@"后轮信号异常");
//            
//        }else{
//            _rmVoice(HXString(@"02-7"));
//        }
        
    }
    
    
    
   
    
    if ([oldTitle isEqualToString:currentTitle]) {
        if (notiNumer==0) {
            NSLog(@"%d",notiNumer);
            oldTitle = currentTitle;
            [self sendNoti:currentTitle];
        }
        
        
    }else{
        
        oldTitle = currentTitle;
        [self sendNoti:currentTitle];
    }
    
    
}




@end
