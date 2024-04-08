//
//  Utility.h
//  ZTML
//
//  Created by 周涛 on 14/11/6.
//  Copyright (c) 2014年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface Utility : NSObject

@property (nonatomic,strong)NSString *tid;

//提示框
+ (void)topAlertView:(NSString *)message;
//是否是手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//倒计时
+ (void)startTime:(UIButton *)sender;
//自适应宽度
+ (CGSize)getTextString:(NSString *)text textFont:(UIFont *)font frameWidth:(float)width;
//返回时间戳字符串 从1970
+ (NSString *)currentTime:(NSData *)data;
//返回时间戳字符串
+ (NSString *)changeTime:(NSString *)timeStamp dataFormat:(NSString *)dataFormat;
//MD5加密
+ (NSString *)md5:(NSString *)str;
//获取网络状态
+ (NSString *)getNetWorkStates;
//获取主屏幕
+ (UIWindow *)mainWindow;

+ (NSString *)compareTime:(int)timeStr;

//返回星座
+ (NSString *)getAstroWithTime:(NSString *)timeStr;
//解析时间
+ (NSString *)changeDataStr:(NSString *)tempStr;

+ (void)setBadgeValue:(NSString*)val atTabIndex:(int)index atTabbarController:(UITabBarController *)tabbarController;

+ (void)adjustViewCoordinate:(NSArray *)array;
//获取IP地址
+ (NSString *)getIPAddress;
//获取MAC地址
+ (NSString *)getMacAddress;

+ (void)showImageListToSourceDic:(NSDictionary *)sourceDic selectIndex:(NSInteger)selectIndex;

+ (NSString *)toBtye:(const Byte *)bytes length:(NSInteger)length;

+ (NSString *)toBit:(int)byte;

+ (NSString *)ToHex:(uint32_t)tmpid;

+ (int)chgeNum:(NSString *)str;

//+ (void)saveTireValue:(NSString *)tireID tirePressure:(float)tirePressure tireTemperature:(float)tireTemperature time:(long)time;

+ (NSString *)getBinaryByhex:(NSString *)hex;

+ (NSInteger)toDecimalSystemWithBinarySystem:(NSString *)binary;

+ (NSData*)stringToByte:(NSString*)string;

+ (UIImage *)imageElectricity:(NSInteger)electricity;

+ (UIImage *)imageWeather:(NSString *)weather;

+ (NSDate *)dateFromString:(NSString *)dateString;

+ (BOOL)saveTireWithTirePress:(NSString *)tirePress andTireTemp:(NSString *)temp andTime:(NSString *)time andTele:(NSString *)tele andTchangValue:(NSString *)tchangvalue and:(NSString *)tid andID:(NSString *)ID;
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (UIColor *) colorWithHexString: (NSString *)color andAlpha:(float)alpha;
+ (BOOL)valiMobile:(NSString *)mobile;
+ (BOOL)checkEmail:(NSString *)email;
+ (BOOL)checkPassword:(NSString *)password;
+ (NSString *)getTime:(NSDate *)date;
+ (CGRect)getRect:(CGRect)rect;
+ (NSArray *)getPinyin:(NSArray *)chineseArr;
//+ (NSString *)UTF8STRING:(NSString *)string;
//+ (NSString *)getNomberString:(NSString *)string;
+(UIView *)setMyView:(CGRect)rect andLabel:(NSString *)string andButton:(UIButton *)button andMyLabel:(UILabel *)label;
+ (NSString *)uuidString;
+(NSString *)getTime1:(NSDate *)date;
@end
