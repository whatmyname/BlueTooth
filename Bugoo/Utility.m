//
//  Utility.m
//  ZTML
//
//  Created by 周涛 on 14/11/6.
//  Copyright (c) 2014年 long. All rights reserved.
//

#import "Utility.h"
#import <CommonCrypto/CommonDigest.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "FMDBManager.h"


@implementation Utility

+ (void) topAlertView:(NSString *)message
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:HXString(@"温馨提示") message:message delegate:nil cancelButtonTitle:HXString(@"确定") otherButtonTitles:nil];
    
    [alert show];
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString *MOBILE = @"[0-9]{11}";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}

+ (void)startTime:(UIButton *)sender
{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"重新发送" forState:UIControlStateNormal];
                [sender setTitleColor:UIColorFromRGB(0x13b6f1, 1) forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }else{
            //int minutes = timeout / 60;
            int seconds = timeout%60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [sender setTitleColor:UIColorFromRGB(0x575757, 1) forState:UIControlStateNormal];
                [sender setTitle:[NSString stringWithFormat:@"%@S后获取",strTime] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

+ (CGSize)getTextString:(NSString *)text textFont:(UIFont *)font frameWidth:(float)width
{
    CGSize constraint = CGSizeMake(width, MAXFLOAT);
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:text attributes:@{
                                                                                                     NSFontAttributeName:font
                                                                                                     }];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    return size;
}


+ (NSString *)currentTime:(NSDate *)date
{
    NSString *curTime = [NSString stringWithFormat:@"%d", (int)[date timeIntervalSince1970]];
    return curTime;
}

+ (NSString *)changeTime:(NSString *)timeStamp dataFormat:(NSString *)dataFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:dataFormat];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]];
    return [formatter stringFromDate:confromTimesp];
}


+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


+ (NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state = @"2g";
                    break;
                case 2:
                    state = @"3g";
                    break;
                case 3:
                    state = @"4g";
                    break;
                case 5:
                    state = @"wifi";
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}

+ (UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

+ (NSString *)compareTime:(int)timeStr
{
    NSDate *sendData = [NSDate dateWithTimeIntervalSince1970:timeStr];
    
    NSDateComponents *comps;
    NSCalendar *calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                        fromDate:sendData
                          toDate:[NSDate date]
                         options:0
             ];
    
    if (comps.year > 0) {
        return [NSString stringWithFormat:@"%ld年", (long)comps.year];
    }
    if (comps.month > 0) {
        return [NSString stringWithFormat:@"%ld个月", (long)comps.month];
    }
    if (comps.day > 0) {
        return [NSString stringWithFormat:@"%ld天", (long)comps.day];
    }
    return @"";
}

+ (NSString *)getAstroWithTime:(NSString *)timeStr{
    
    int m = [[timeStr substringWithRange:NSMakeRange(4, 2)] intValue];
    int d = [[timeStr substringWithRange:NSMakeRange(6, 2)] intValue];
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (m<1||m>12||d<1||d>31){
        return @"错误日期格式!";
    }
    if(m==2 && d>29)
    {
        return @"错误日期格式!!";
    }else if(m==4 || m==6 || m==9 || m==11) {
        if (d>30) {
            return @"错误日期格式!!!";
        }
    }
    result = [NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    return [result stringByAppendingString:@"座"];
}

+ (NSString *)changeDataStr:(NSString *)tempStr
{
    return [NSString stringWithFormat:@"%@年%@月%@日", [tempStr substringToIndex:4], [tempStr substringWithRange:NSMakeRange(4, 2)], [tempStr substringFromIndex:6]];
}

+ (void)setBadgeValue:(NSString*)val atTabIndex:(int)index atTabbarController:(UITabBarController *)tabbarController
{
    UITabBarItem *tab = [tabbarController.tabBar.items objectAtIndex:index];
    if ([val integerValue] <= 0) {
        tab.badgeValue = nil;
    }
    else {
        tab.badgeValue = val;
    }
}

+ (void)adjustViewCoordinate:(NSArray *)array
{
    float noProprotionValue = SC_DEVICE_SIZE.width/320.0;
    UIView *lastView;
    for (UIView *view in array) {
        if ([view isKindOfClass:[UIView class]] && (view.tag == 1 || view.tag == 2 || view.tag == 3)) {
            if (!lastView) {
                view.frame = CGRectMake(X(view), Y(view), noProprotionValue*WIDTH(view), HEIGHT(view));
            }
            else
            {
            }
            lastView = view;
        }
    }
}

+ (NSString *)getIPAddress {
    
    NSString *address = @"error";
    
    struct ifaddrs *interfaces = NULL;
    
    struct ifaddrs *temp_addr = NULL;
    
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) {
        
        // Loop through linked list of interfaces
        
        temp_addr = interfaces;
        
        while(temp_addr != NULL) {
            
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                
                // Check if interface is en0 which is the wifi connection on the iPhone
                
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    
                    // Get NSString from C String
                    
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
        
    }
    
    // Free memory
    
    freeifaddrs(interfaces);
    
    return address;
}

+ (NSString *)getMacAddress
{
    int mib[6];
    
    size_t len;
    
    char *buf;
    
    unsigned char *ptr;
    
    struct if_msghdr *ifm;
    
    struct sockaddr_dl *sdl;
    
    
    mib[0] = CTL_NET;
    
    mib[1] = AF_ROUTE;
    
    mib[2] = 0;
    
    mib[3] = AF_LINK;
    
    mib[4] = NET_RT_IFLIST;
    
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        
        printf("Error: if_nametoindex error/n");
        
        return NULL;
        
    }
    
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        
        printf("Error: sysctl, take 1/n");
        
        return NULL;
        
    }
    
    if ((buf = malloc(len)) == NULL) {
        
        printf("Could not allocate memory. error!/n");
        
        return NULL;
        
    }
    
    
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        
        printf("Error: sysctl, take 2");
        
        return NULL;
        
    }
    
    
    ifm = (struct if_msghdr *)buf;
    
    sdl = (struct sockaddr_dl *)(ifm + 1);
    
    ptr = (unsigned char *)LLADDR(sdl);
    
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    free(buf);
    
    return [outstring uppercaseString];
    
}


+ (void)showImageListToSourceDic:(NSDictionary *)sourceDic selectIndex:(NSInteger)selectIndex
{
    NSArray *imageArrSmall = sourceDic[@"imageArrSmall"];
    NSArray *imageViewBig  = sourceDic[@"imageViewBig"];
    NSMutableArray *imageS = [NSMutableArray arrayWithCapacity:imageArrSmall.count];
    
    for (int i = 0; i < [imageViewBig count]; i ++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.srcImageView = (UIImageView *)imageArrSmall[i];
        
        photo.image = (UIImage *)imageViewBig[i];
        [imageS addObject:photo];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = selectIndex;
    browser.photos = imageS;
    [browser show];
}

+ (NSString *)toBtye:(const Byte *)bytes length:(NSInteger)length
{
    NSString *hexStr = @"";
    for (int i = 0; i < length; i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i]&0xff];///16进制数
        if([newHexStr length] == 1)
            hexStr = [NSString stringWithFormat:@"%@0%@", hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@", hexStr,newHexStr];
    }
    return hexStr;
}

+ (NSString *)toBit:(int)byte
{
    int bits;
    NSString *str = @"";
    for(int i = 7; i >= 0; i--)
    {
        bits = (byte >> i) & 0x01;
        str = [str stringByAppendingFormat:@"%d", bits];
    }
    return str;
}

//将十进制转化为十六进制
+ (NSString *)ToHex:(uint32_t)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    uint16_t ttmpig;
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
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    if (str.length%2 != 0) {
        str = [@"0" stringByAppendingString:str];
    }
    return str;
}

+ (int)chgeNum:(NSString *)str
{
    unsigned char ch;
    int len;
    double sum=0,arg;
    len = (int)str.length;
    for(int i=0;i<len;i++){
        ch = [str characterAtIndex:i];
        arg = ch;
        if(47<arg&&arg<58){
            arg = (arg-48)*pow(16.0,(len-1-i));
        }else{
            arg = (arg-55)*pow(16.0,(len-1-i));
        }
        sum = arg + sum;
    }
    return (int)sum;
}

//+ (void)saveTireValue:(NSString *)tireID tirePressure:(float)tirePressure tireTemperature:(float)tireTemperature time:(long)time
//{
//    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970] - time;
//    
//    TireDataModel *model = [[TireDataModel alloc] init];
//    
//    NSCalendar *calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    
//    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
//                                          fromDate:[NSDate dateWithTimeIntervalSince1970:currentTime]];
//    
//    NSLog(@"temp:%d year:%ld month:%ld day:%ld time:%ld minute:%ld", (int)[[NSDate date] timeIntervalSince1970], (long)comps.year, (long)comps.month, (long)comps.day, (long)comps.hour, (long)comps.minute);
//    
//    model.tireID            = tireID;
//    model.tirePressure      = tirePressure;
//    model.tireTemperature   = tireTemperature;
//    model.insertTamp        = currentTime;
//    model.insertYear        = comps.year;
//    model.insertMonth       = comps.month;
//    model.insertDay         = comps.day;
//    model.insertTime        = comps.hour;
//    model.insertMinute      = comps.minute;
////    [_dateBase executeUpdate:sql,dic[@"time"],dic[@"tele"],dic[@"tpress"],dic[@"ttemp"],dic[@"tno"]];
////    NSDictionary *dic = @{@"time":[NSString stringWithFormat:@"%d",(int)model.insertTamp],@"tpress":[NSString stringWithFormat:@"%d",(int)model.tirePressure],@"ttemp":[NSString stringWithFormat:@"%d",(int)model.tireTemperature],@"tno":,};
//    [Administer sqliteTableInsert:kTireValue model:model];
//}

+ (BOOL)saveTireWithTirePress:(NSString *)tirePress andTireTemp:(NSString *)temp andTime:(NSString *)time andTele:(NSString *)tele andTchangValue:(NSString *)tchangvalue and:(NSString *)tid andID:(NSString *)ID{
    FMDBManager *fm  =[FMDBManager createDBbase];
//    [fm selectDB];
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"MAC"]);
    NSString *string = [[NSUserDefaults standardUserDefaults]objectForKey:@"MAC"];
    NSDictionary *dic = @{@"id":ID,@"d":time,@"p":tirePress,@"t":temp,@"v":tele,@"mac":string,@"upload":@"0",@"tchangvalue":tchangvalue,@"n":tid};
    return [fm insertData:dic];
}
+ (NSString *)getBinaryByhex:(NSString *)hex
{
    NSMutableDictionary  *hexDic = [[NSMutableDictionary alloc] init];
    
    hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSString *binaryString = [[NSString alloc] init];
    
    for (int i=0; i<[hex length]; i++) {
        
        NSRange rage;
        
        rage.length = 1;
        
        rage.location = i;
        
        NSString *key = [hex substringWithRange:rage];
        
        binaryString = [NSString stringWithFormat:@"%@%@", binaryString, [NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
        
    }
    
    //NSLog(@"转化后的二进制为:%@",binaryString);
    return binaryString;
    
}

+ (NSInteger)toDecimalSystemWithBinarySystem:(NSString *)binary
{
    
    int ll = 0 ;
    int temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    return [result integerValue] ;
}


// 普通字符串转成数据流
+ (NSData*)stringToByte:(NSString*)string
{
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0)
    {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16; //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            return nil;
        
        i++;
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            return nil;
        tempbyt[0] = int_ch1+int_ch2; ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}

+ (UIImage *)imageElectricity:(NSInteger)electricity
{
    UIImage *image;
    if (electricity == 1) {
        image = [UIImage imageNamed:@"icon_electricity_0"];
    }
    else {
        image = [UIImage imageNamed:@"icon_electricity_4"];
    }
    return image;
    //    UIImage *image;
    //    if (electricity >= 80) {
    //        image = [UIImage imageNamed:@"icon_electricity_4"];
    //    }
    //    else if (electricity >= 60) {
    //        image = [UIImage imageNamed:@"icon_electricity_3"];
    //    }
    //    else if (electricity >= 40) {
    //        image = [UIImage imageNamed:@"icon_electricity_2"];
    //    }
    //    else if (electricity >= 20) {
    //        image = [UIImage imageNamed:@"icon_electricity_1"];
    //    }
    //    else {
    //        image = [UIImage imageNamed:@"icon_electricity_0"];
    //    }
    //    return image;
}

+ (UIImage *)imageWeather:(NSString *)weather
{
    UIImage *image;
    NSArray *strings = [weather componentsSeparatedByString:@"转"];
    weather = strings.firstObject;
    
    // 0.
    if ([weather isEqualToString:@"晴"]) {
        image = [UIImage imageNamed:@"1晴.png"];
    }
    // 1.
    else if ([weather isEqualToString:@"多云"]) {
        image = [UIImage imageNamed:@"2多云.png"];
    }
    // 2.
    else if ([weather isEqualToString:@"阴"]) {
        image = [UIImage imageNamed:@"3阴.png"];
    }
    // 3.
    else if ([weather isEqualToString:@"阵雨"]) {
        image = [UIImage imageNamed:@"4阵雨.png"];
    }
    // 4.
    else if ([weather isEqualToString:@"雷阵雨"]) {
        image = [UIImage imageNamed:@"5雷阵雨.png"];
    }
    // 5.
    else if ([weather isEqualToString:@"雷阵雨伴有冰雹"]) {
        image = [UIImage imageNamed:@"6雷阵雨伴有冰雹.png"];
    }
    // 6.
    else if ([weather isEqualToString:@"雨夹雪"]) {
        image = [UIImage imageNamed:@"7雨夹雪.png"];
    }
    // 7.
    else if ([weather isEqualToString:@"小雨"]) {
        image = [UIImage imageNamed:@"8小雨.png"];
    }
    // 8.
    else if ([weather isEqualToString:@"中雨"]) {
        image = [UIImage imageNamed:@"10中雨.png"];
    }
    // 9.
    else if ([weather isEqualToString:@"大雨"]) {
        image = [UIImage imageNamed:@"11大雨.png"];
    }
    // 10.
    else if ([weather isEqualToString:@"暴雨"]) {
        image = [UIImage imageNamed:@"12暴雨.png"];
    }
    // 11.
    else if ([weather isEqualToString:@"大暴雨"]) {
        image = [UIImage imageNamed:@"13大暴雨.png"];
    }
    // 12.
    else if ([weather isEqualToString:@"特大暴雨"]) {
        image = [UIImage imageNamed:@"14特大暴雨.png"];
    }
    // 13.
    else if ([weather isEqualToString:@"阵雪"]) {
        image = [UIImage imageNamed:@"15阵雪.png"];
    }
    // 14.
    else if ([weather isEqualToString:@"小雪"]) {
        image = [UIImage imageNamed:@"16小雪.png"];
    }
    // 15.
    else if ([weather isEqualToString:@"中雪"]) {
        image = [UIImage imageNamed:@"17中雪.png"];
    }
    // 16.
    else if ([weather isEqualToString:@"大雪"]) {
        image = [UIImage imageNamed:@"18大雪.png"];
    }
    // 17.
    else if ([weather isEqualToString:@"暴雪"]) {
        image = [UIImage imageNamed:@"19暴雪.png"];
    }
    // 18.
    else if ([weather isEqualToString:@"雾"]) {
        image = [UIImage imageNamed:@"20雾.png"];
    }
    // 19.
    else if ([weather isEqualToString:@"冻雨"]) {
        image = [UIImage imageNamed:@"21冻雨.png"];
    }
    // 20.
    else if ([weather isEqualToString:@"沙尘暴"]) {
        image = [UIImage imageNamed:@"22沙尘暴.png"];
    }
    // 21.
    else if ([weather isEqualToString:@"小雨-中雨"]) {
        image = [UIImage imageNamed:@"23小雨-中雨.png"];
    }
    // 22.
    else if ([weather isEqualToString:@"中雨-大雨"]) {
        image = [UIImage imageNamed:@"24中雨-大雨.png"];
    }
    // 23.
    else if ([weather isEqualToString:@"大雨-暴雨"]) {
        image = [UIImage imageNamed:@"25大雨-暴雨.png"];
    }
    // 24.
    else if ([weather isEqualToString:@"暴雨-大暴雨"]) {
        image = [UIImage imageNamed:@"26暴雨-大暴雨.png"];
    }
    // 25.
    else if ([weather isEqualToString:@"大暴雨-特大暴雨"]) {
        image = [UIImage imageNamed:@"27大暴雨-特大暴雨.png"];
    }
    // 26.
    else if ([weather isEqualToString:@"小雪-中雪"]) {
        image = [UIImage imageNamed:@"28小雪-中雪.png"];
    }
    // 27.
    else if ([weather isEqualToString:@"中雪-大雪"]) {
        image = [UIImage imageNamed:@"29中雪-大雪.png"];
    }
    // 28.
    else if ([weather isEqualToString:@"大雪-暴雪"]) {
        image = [UIImage imageNamed:@"30大雪-暴雪.png"];
    }
    // 29.
    else if ([weather isEqualToString:@"浮尘"]) {
        image = [UIImage imageNamed:@"31浮沉.png"];
    }
    // 30.
    else if ([weather isEqualToString:@"扬沙"]) {
        image = [UIImage imageNamed:@"32扬沙.png"];
    }
    // 31.
    else if ([weather isEqualToString:@"强沙尘暴"]) {
        image = [UIImage imageNamed:@""];
    }
    // 53.
    else if ([weather isEqualToString:@"霾"]) {
        image = [UIImage imageNamed:@"33霾.png"];
    }
    return image;
}
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *) colorWithHexString: (NSString *)color andAlpha:(float)alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

+ (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}


+ (BOOL)checkPassword:(NSString *)password{
    NSString *passwordRule = @"^[a-zA-Z0-9]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRule];
    
    return [pred evaluateWithObject:password];
}

+ (BOOL)checkEmail:(NSString *)email{
    
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [emailTest evaluateWithObject:email];
    
}

+(NSString *)getTime:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSInteger year = [dateComponent year];
    NSInteger month =  [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour =  [dateComponent hour];
    NSInteger minute =  [dateComponent minute];
//    NSInteger second = [dateComponent second];
    
    NSString *dateString = [NSString stringWithFormat:@"%02ld.%02ld.%02ld. %02ld:%02ld",(long)year,(long)month,(long)day,(long)hour,(long)minute];
    
    return dateString;
}



+(NSString *)getTime1:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    //    NSInteger year = [dateComponent year];
//    NSInteger month =  [dateComponent month];
//    NSInteger day = [dateComponent day];
    NSInteger hour =  [dateComponent hour];
    NSInteger minute =  [dateComponent minute];
    //    NSInteger second = [dateComponent second];
    
    NSString *dateString = [NSString stringWithFormat:@"%02ld:%02ld",(long)hour,(long)minute];
    
    return dateString;
}

+ (CGRect)getRect:(CGRect)rect{
    CGRect r = [UIScreen mainScreen].bounds;
    return CGRectMake(rect.origin.x/375.0*r.size.width, rect.origin.y/667.0*r.size.height, rect.size.width/375.0*r.size.width, rect.size.height/667.0*r.size.height);
}



+ (NSArray *)getPinyin:(NSMutableArray *)chineseArr{
    NSMutableArray *pinyinArr = [[NSMutableArray alloc]init];
    
    for (NSString *chinese in chineseArr) {
        NSMutableString *mutableString = [NSMutableString stringWithString:chinese];
        // Boolean CFStringTransform(CFMutableStringRef string, CFRange *range, CFStringRef transform, Boolean reverse);
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false); // 汉字转成拼音(不知道为什么英文是拉丁语的意思)
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false); // 去掉音调
        [pinyinArr addObject:mutableString];
    }
    NSArray *sortArr = [pinyinArr sortedArrayUsingSelector:@selector(compare:)];
    return sortArr;
}



//+ (NSString *)UTF8STRING:(NSString *)string{
//    return  [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}
//
//+ (NSString *)getNomberString:(NSString *)string{
//    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}


+(UIView *)setMyView:(CGRect)rect andLabel:(NSString *)string andButton:(UIButton *)button andMyLabel:(UILabel *)label{
    
    float mywidth;
    float myheight;
    mywidth = WIDTH([Utility mainWindow])/375;
    myheight = HEIGHT([Utility mainWindow])/667;
    
    
    UIView *view = [[UIView alloc]initWithFrame:rect];
    view.layer.borderColor = [Utility colorWithHexString:@"f1f1f1" andAlpha:0.3].CGColor;
    view.layer.borderWidth = 1;
//    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 40*myheight, WIDTH(view), 14*myheight)];
//    title.textColor = [Utility colorWithHexString:@"f1f1f1"];
//    title.text = string;
//    title.textAlignment = NSTextAlignmentCenter;
//    [view addSubview:title];
    
    [label setFrame:CGRectMake(0, HEIGHT(view)-(40+14)*myheight, WIDTH(view), 16*myheight)];
    label.text = @"ID:等待学习";
    label.textColor = [Utility colorWithHexString:@"f1f1f1"];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    [button setFrame:CGRectMake(0, 0, WIDTH(view), HEIGHT(view))];
    button.titleEdgeInsets = UIEdgeInsetsMake(50*myheight, 0, HEIGHT(button)-50*myheight, 0);
    [button setTitle:string forState:UIControlStateNormal];
    [view addSubview:button];
    return view;
}

+ (NSString *)uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}



//+ (void)push:(id)sender andTitle:(NSString *)title andButtonTitle:(NSString *)buttonTitle andAction:(void (^)())block{
//    UIAlertController *view = [UIAlertController alertControllerWithTitle:@"温馨提示" message:title preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:block];
//    [view addAction:action];
//    
//}
@end
