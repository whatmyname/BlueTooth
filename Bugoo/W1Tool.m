//
//  W1Tool.m
//  Bugoo
//
//  Created by bugoo on 7/4/17.
//  Copyright © 2017年 LoveGuoGuo. All rights reserved.
//

#import "W1Tool.h"
#import <CoreLocation/CoreLocation.h>
#define blueUUID @"b54adc00-67f9-11d9-9669-0800200c9a66"
@interface W1Tool()<CLLocationManagerDelegate>
{
    BOOL islow;
    Model *model;
}
@property (strong, nonatomic) CLBeaconRegion *beacon1;      //被扫描的iBeacon
@property (strong, nonatomic) CLLocationManager * locationmanager;

@end

@implementation W1Tool

+ (W1Tool *)loadGuide
{
    @synchronized(self)
    {
        static W1Tool *w1tool = nil;
        if (!w1tool) {
            w1tool = [[W1Tool alloc] init];
            
        }
        
        return w1tool;
    }
}

-(instancetype)init{
    if (self = [super init]) {
        [self creteUIW1];
        
        islow = NO;
    }
    return self;
}


-(void)setModel{
    if (currentD) {
        NSData *data = currentD;
        model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

-(BOOL)isLocation{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status)
    {
        return NO;
    }else{
        return YES;
    }
    

}

-(void)creteUIW1{
    DEFAULTS_INFO(@"YES", @"isregion");
    DEFAULTS_SYNCHRONIZE;
    self.beacon1 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:blueUUID] identifier:@"media"];//初始化监测的iBeacon信息
    self.beacon1.notifyEntryStateOnDisplay = YES;
    self.beacon1.notifyOnEntry = YES;
    self.beacon1.notifyOnExit = YES;
    self.locationmanager = [[CLLocationManager alloc]init];
    self.locationmanager.pausesLocationUpdatesAutomatically = NO;
//        NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//        if(phoneVersion.floatValue>=9.0){
//        [self.locationmanager setAllowsBackgroundLocationUpdates:YES];
//        }
    
    
    self.locationmanager.delegate = self;
    [self.locationmanager startUpdatingHeading];
    [self.locationmanager requestAlwaysAuthorization];
//  [self.locationmanager requestWhenInUseAuthorization];
//  self.locationmanager.desiredAccuracy = kCLLocationAccuracyKilometer;    //后台使用定位功能属性
    [self.locationmanager startUpdatingLocation];
    [self.locationmanager requestStateForRegion:self.beacon1];
    [self.locationmanager startMonitoringForRegion:self.beacon1];//开始MonitoringiBeacon

    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{

    if (status == kCLAuthorizationStatusAuthorizedAlways) {
    
    }else if(status==kCLAuthorizationStatusAuthorizedWhenInUse){
        NSLog(@"++++++++++++++++++-------------------------+++++++++++++++++++++++");
    }
    
}

-(void)startRanging{
 
    [self.locationmanager startRangingBeaconsInRegion:self.beacon1];//开始RegionBeacons

}



//发现有iBeacon进入监测范围
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    
//    DEFAULTS_INFO(@"YES", @"isregion");
//    DEFAULTS_SYNCHRONIZE;
//    
//#if defined(DEBUG)
////    [Utility topAlertView:@"进入监测范围"];
//#endif
    
    
    [self.locationmanager startRangingBeaconsInRegion:self.beacon1];//开始RegionBeacons
    
}


-(NSMutableArray *)learnArr{
    if (_learnArr==nil) {
        _learnArr = [[NSMutableArray alloc]init];
    }
    return _learnArr;
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
//    DEFAULTS_INFO(@"NO", @"isregion");
//    DEFAULTS_SYNCHRONIZE;
//#if defined(DEBUG)
////    [Utility topAlertView:@"退出监测范围"];
//#endif
    
}


//找的iBeacon后扫描它的信息
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{

    NSString *tireId;
    NSString *press;
    NSString *temp;
    
    
    int elect = 0;
      for (CLBeacon *beacon in beacons) {
        
        NSLog(@"major:%@",beacon.major);
       NSLog(@"%@",beacon.proximityUUID);
       NSString *tid = [self ToHex:beacon.major.integerValue];
        NSLog(@"minor:%@",beacon.minor);
       NSString *string = [self toBinarySystemWithDecimalSystem:beacon.minor.intValue length:16];
       tireId = [NSString stringWithFormat:@"%@%@",[string substringWithRange:NSMakeRange(0, 1)],tid];
          NSLog(@"%@",tireId);
       press =  [NSString stringWithFormat:@"%.0f",[self toDecimalSystemWithBinarySystem:[string substringFromIndex:8] ]*2.5];
        
       temp = [NSString stringWithFormat:@"%d",[self toDecimalSystemWithBinarySystem:[string substringWithRange:NSMakeRange(1, 7)]]-40];
//        NSLog(@"温度++++++++++++%@+++++++++++",temp);
        if ([temp isEqualToString:@"87"]) {
            elect = 1;
            islow = YES;
        }else if(!islow){
            elect = 0;
        }
      
        
        
        if (_isLearn) {
        
            if (press.intValue>180&&_learnArr.count<10) {
            [self.learnArr addObject:tireId];
            
            }
        
            if (press.intValue<160) {
                if ([self.learnArr containsObject:tireId]) {
                    _learnCall(tireId);
                    _isLearn = NO;
                    _learnArr = nil;
                }
            }
        }
        
//        NSLog(@"%ld",(long)beacon.rssi);
//        
//        if (beacon.proximity>CLProximityImmediate&&[USER(@"isregion") isEqualToString:@"YES"]) {
//            DEFAULTS_INFO(@"NO", @"isregion");
//            DEFAULTS_SYNCHRONIZE;
//            NSLog(@"%ld",(long)beacon.proximity);
////            [Utility topAlertView:@"渐行渐远了"];
//        }else if([USER(@"isregion") isEqualToString:@"NO"]&&beacon.proximity==CLProximityImmediate){
//            DEFAULTS_INFO(@"YES", @"isregion");
//            DEFAULTS_SYNCHRONIZE;
//        }
    
    }
    
  
    
  
    
    if(([tireId isEqualToString:model.lfid]||[tireId isEqualToString:model.rfid])&&!_isLearn){
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kTireValueChangeNotification object:@{@"tireID": tireId,
                                                                                                         @"tirePressure": @(press.intValue),
                                                                                                         @"Electricity": @(elect),
                                                                                                         @"tireTemperature":@(temp.intValue)}];
//        NSString *ttid;
//        if ([tireId isEqualToString:model.lfid]) {
//            ttid = @"0";
//        }else if([tireId isEqualToString:model.rfid]){
//            ttid = @"1";
//        }else if([tireId isEqualToString:model.lrid]){
//            ttid = @"2";
//        }else if ([tireId isEqualToString:model.rrid]){
//            ttid = @"3";
//        }
        
//        NSInteger currentTime = [[NSDate date]timeIntervalSince1970];
//        NSString *s = [NSString stringWithFormat:@"%d",press.intValue-100];
//        [Utility saveTireWithTirePress:s andTireTemp:temp andTime:[NSString stringWithFormat:@"%ld",(long)currentTime] andTele:[NSString stringWithFormat:@"%d",elect] andTchangValue:[NSString stringWithFormat:@"%d",0] and:ttid andID:[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]]];
    }

    
}




-(void)stopRanging{
    [self.locationmanager stopRangingBeaconsInRegion:self.beacon1];
    
}


- (int)toDecimalSystemWithBinarySystem:(NSString *)binary
{
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    return ll;
//    NSString * result = [NSString stringWithFormat:@"%d",ll];
//    
//    switch (result.intValue) {
//        case 10:
//            return @"A";
//            break;
//        case 11:
//            return @"B";
//            break;
//        case 12:
//            return @"C";
//            break;
//        case 13:
//            return @"D";
//            break;
//        case 14:
//            return @"E";
//            break;
//        case 15:
//            return @"F";
//            break;
//        default:
//            break;
//    }
//    
//    return result;
}


//十进制转二进制
- (NSString *)toBinarySystemWithDecimalSystem:(int)num length:(int)length
{
    int remainder = 0;      //余数
    int divisor = 0;        //除数
    
    NSString * prepare = @"";
    
    while (true)
    {
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%d",remainder];
        
        if (divisor == 0)
        {
            break;
        }
    }
    //倒序输出
    NSString * result = @"";
    for (int i = length -1; i >= 0; i --)
    {
        if (i <= prepare.length - 1) {
            result = [result stringByAppendingFormat:@"%@",
                      [prepare substringWithRange:NSMakeRange(i , 1)]];
            
        }else{
            result = [result stringByAppendingString:@"0"];
            
        }
    }
    return result;
}

//- (NSData*)stringToByte:(NSString*)string
//{
//    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
//    if ([hexString length]%2!=0)
//    {
//        return nil;
//    }
//    Byte tempbyt[1]={0};
//    NSMutableData* bytes=[NSMutableData data];
//    for(int i=0;i<[hexString length];i++)
//    {
//        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
//        int int_ch1;
//        if(hex_char1 >= '0' && hex_char1 <='9')
//            int_ch1 = (hex_char1-48)*16; //// 0 的Ascll - 48
//        else if(hex_char1 >= 'A' && hex_char1 <='F')
//            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
//        else
//            return nil;
//        
//        i++;
//        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
//        int int_ch2;
//        if(hex_char2 >= '0' && hex_char2 <='9')
//            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
//        else if(hex_char2 >= 'A' && hex_char2 <='F')
//            int_ch2 = hex_char2-55; //// A 的Ascll - 65
//        else
//            return nil;
//        tempbyt[0] = int_ch1+int_ch2; ///将转化后的数放入Byte数组里
//        [bytes appendBytes:tempbyt length:1];
//    }
//    return bytes;
//}


-(NSString *)ToHex:(long long int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    if (str.length<4) {
        return [NSString stringWithFormat:@"0%@",str];
    }
    
    return str;
}



@end
