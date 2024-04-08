//
//  MacroMethod.h
//  SexIndustry
//
//  Created by Sha Na on 13-2-25.
//  Copyright (c) 2013年 Sha Na. All rights reserved.
//

//国家化
//#define HXString(a) NSLocalizedString(a, nil)


//设置DEBUG调试的输出方式
#if !defined(DEBUG) || DEBUG == 0
#define CCLOG(...) do {} while (0)
#define CCLOGINFO(...) do {} while (0)
#define CCLOGERROR(...) do {} while (0)

#elif DEBUG == 1
#define CCLOG(...) NSLog(__VA_ARGS__)
#define CCLOGERROR(...) NSLog(__VA_ARGS__)
#define CCLOGINFO(...) do {} while (0)

#elif DEBUG > 1
#define CCLOG(...) NSLog(__VA_ARGS__)
#define CCLOGERROR(...) NSLog(__VA_ARGS__)
#define CCLOGINFO(...) NSLog(__VA_ARGS__)
#endif // DEBUG


//设置DEBUG调试的输出方式
#if !defined(DEBUG) || DEBUG == 0
#define XXLOG do {} while (0)

#elif DEBUG == 1
#define XXLOG NSLog(@"-->> <<%@>> -->> <<%@>> ", self.class, NSStringFromSelector(_cmd));

#elif DEBUG > 1
#define XXLOG NSLog(@"-->> <<%@>> -->> <<%@>> ", self.class, NSStringFromSelector(_cmd));
#endif // DEBUG


/**
 *	@brief	手机信息
 */
#define System_Version [[UIDevice currentDevice] systemVersion]                                             //用户手机系统版本
#define System_Model   [[UIDevice currentDevice] model]                                                     //用户手机型号
#define App_Version    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]  //app的版本号

/**
 *	@brief	视图信息
 */

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

#define kIsIphone4s    (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 480)))
#define kIsIphone5     (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568)))
#define kIsIphone6     (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 667)))
#define kIsIphone6p    (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736)))

#define kScreenHeight  (kIsIphone4s ? 480.f : (kIsIphone5 ? 568.f : (kIsIphone6 ? 667.f : 736)))
#define kScreenWidth   (kIsIphone4s ? 320.f : (kIsIphone5 ? 320.f : (kIsIphone6 ? 375.f : 414)))

#define kStatusBarHeight   (20.f)
#define kTopBarHeight      (44.f)
#define kBottomBarHeight   (49.f)


#define kScreenDrawIOS7FrameY         (64.0)
#define kScreenDrawIOS6FrameY         (44.0)

#define X(v)               (v).frame.origin.x
#define Y(v)               (v).frame.origin.y
#define WIDTH(v)           (v).frame.size.width
#define HEIGHT(v)          (v).frame.size.height

#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)

#define SC_DEVICE_BOUNDS    [[UIScreen mainScreen] bounds]
#define SC_DEVICE_SIZE      [[UIScreen mainScreen] bounds].size

#define SC_APP_FRAME        [[UIScreen mainScreen] applicationFrame]
#define SC_APP_SIZE         [[UIScreen mainScreen] applicationFrame].size

#define SELF_CON_FRAME      self.view.frame
#define SELF_CON_SIZE       self.view.frame.size
#define SELF_VIEW_FRAME     self.frame
#define SELF_VIEW_SIZE      self.frame.size

#define UIColorFromRGB(rgbValue, alpha1) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha1]


#define RGBCOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define PNGIMAGE(NAME)           [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)           [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpeg"]]

#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
#define CELLVALUE(_OBJET, INDEXROW, INDEXSECTION)                (_OBJET *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:INDEXROW inSection:INDEXSECTION]]
#define CompareStirng(string1, string2)                          (string1 && ![string1 isEqualToString:@""])?string1:string2

/*
 手机info
 */
#define System_Version [[UIDevice currentDevice] systemVersion]                                             //用户手机系统版本
#define System_Model   [[UIDevice currentDevice] model]                                                     //用户手机型号
#define App_Version    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]  //app的版本号


/**
 *	@brief	用户信息
 */
#define DEFAULTS_INFO(_OBJECT, _NAME) [[NSUserDefaults standardUserDefaults] setObject:_OBJECT forKey:_NAME]
#define USER(_OBJECT)                      [[NSUserDefaults standardUserDefaults] objectForKey:_OBJECT]                    //轮胎一

#define DEFAULTS_SYNCHRONIZE          [[NSUserDefaults standardUserDefaults] synchronize]
#define TIRECODE1                       [[NSUserDefaults standardUserDefaults] objectForKey:@"TireCode1"]                    //轮胎一
#define TIRECODE2                       [[NSUserDefaults standardUserDefaults] objectForKey:@"TireCode2"]                    //轮胎二
#define TIRECODE3                       [[NSUserDefaults standardUserDefaults] objectForKey:@"TireCode3"]                    //轮胎三
#define TIRECODE4                       [[NSUserDefaults standardUserDefaults] objectForKey:@"TireCode4"]                    //轮胎四
#define TIRE1TEMP                       [[NSUserDefaults standardUserDefaults] objectForKey:@"Tire1Temp"]                    //轮胎一胎温
#define TIRE2TEMP                       [[NSUserDefaults standardUserDefaults] objectForKey:@"Tire2Temp"]                    //轮胎二胎温
#define TIRE3TEMP                       [[NSUserDefaults standardUserDefaults] objectForKey:@"Tire3Temp"]                    //轮胎三胎温
#define TIRE4TEMP                       [[NSUserDefaults standardUserDefaults] objectForKey:@"Tire4Temp"]                    //轮胎四胎温
#define TIRE1PRESS                      [[NSUserDefaults standardUserDefaults] objectForKey:@"Tire1Press"]                    //轮胎一胎压
#define TIRE2PRESS                      [[NSUserDefaults standardUserDefaults] objectForKey:@"Tire2Press"]                    //轮胎二胎压
#define TIRE3PRESS                      [[NSUserDefaults standardUserDefaults] objectForKey:@"Tire3Press"]                    //轮胎三胎压
#define TIRE4PRESS                      [[NSUserDefaults standardUserDefaults] objectForKey:@"Tire4Press"]                    //轮胎四胎压
#define TIRE1                       [[NSUserDefaults standardUserDefaults] objectForKey:@"Tire1"]                    //轮胎一
#define TIRE2                       [[NSUserDefaults standardUserDefaults] objectForKey:@"Tire2"]                    //轮胎二
#define TIRE3                       [[NSUserDefaults standardUserDefaults] objectForKey:@"Tire3"]                    //轮胎三
#define TIRE4                       [[NSUserDefaults standardUserDefaults] objectForKey:@"Tire4"]                    //轮胎四
#define BINDING                       [[NSUserDefaults standardUserDefaults] objectForKey:@"IsBinded"]                    //绑定开关
#define LOGINFLAG                     [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginFlag"]                    //登录开关
#define CarInfoClose                  [[NSUserDefaults standardUserDefaults] objectForKey:@"CarInfoClose"]                 //车辆信息开关
#define User_Info                     [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"]                     //用户信息
#define BugooId                       [[NSUserDefaults standardUserDefaults] objectForKey:@"bugooinfo"]                    //bugoo信息
#define Account_Arr                   [[NSUserDefaults standardUserDefaults] objectForKey:@"AccountArr"]                   //账号数组
#define Peripherals                   [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"Peripherals%@", User_Info[@"UserId"]]]                  //connect设备组
#define PeriArr                       [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"Per%@", User_Info[@"UserId"]]]   
#define Peripherals_Arr               [[NSUserDefaults standardUserDefaults] objectForKey:@"Per"]   //蓝牙设备组
#define currentD                 [[NSUserDefaults standardUserDefaults] objectForKey:@"Device"]   //当前使用的设备
#define Mac                           [[NSUserDefaults standardUserDefaults] objectForKey:@"MAC"]          //当前连接蓝牙mac
#define carInfoArr                       [[NSUserDefaults standardUserDefaults] objectForKey:@"carinfo"]      //车辆信息
#define onlyDevice                    [[NSUserDefaults standardUserDefaults] objectForKey:@"onlyOne"]     //当前连接设备型号

#define learnSuccess                  [[NSUserDefaults standardUserDefaults] objectForKey:@"success"]   //学习成功


#define isAdd                         [[NSUserDefaults standardUserDefaults] objectForKey:@"isAdd"]  //是否添加车辆
#define NEW                         [[NSUserDefaults standardUserDefaults] objectForKey:@"NEW"]  //是否添加新设备
//#define W1Value                     [[NSUserDefaults standardUserDefaults] objectForKey:@"w1Value"]   //w1胎压标准值

#define Location_Info                 [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationInfo"]                 //位置信息
#define Insurance_Phone               [[NSUserDefaults standardUserDefaults] objectForKey:@"InsurancePhone"]               //报案选中电话
#define Rescue_Phone                  [[NSUserDefaults standardUserDefaults] objectForKey:@"RescuePhone"]                  //救援选中电话
#define Service_Phone                 [[NSUserDefaults standardUserDefaults] objectForKey:@"ServicePhone"]                 //售后选中电话
#define Crisis_Phone                  [[NSUserDefaults standardUserDefaults] objectForKey:@"CrisisPhone"]                  //紧急选中电话
#define CityCode_Arr                  [[NSUserDefaults standardUserDefaults] objectForKey:@"CityCodeArr"]                  //城市代码


#define Temperature_Unit              [[NSUserDefaults standardUserDefaults] objectForKey:@"TemperatureUnit"]              //温度单位
#define PressureUnit                  [[NSUserDefaults standardUserDefaults] objectForKey:@"PressureUnit"]                 //压力单位
#define AlertSound                    [[NSUserDefaults standardUserDefaults] objectForKey:@"AlertSound"]                   //声音警报
#define CarType                       [[NSUserDefaults standardUserDefaults] objectForKey:@"CarType"]                      //车型选择
#define PressureValueF                [[NSUserDefaults standardUserDefaults] objectForKey:@"PressureValueF"]               //前轮压力值
#define PressureIndexF                [[NSUserDefaults standardUserDefaults] objectForKey:@"PressureIndexF"]               //前轮压力下标
#define PressureValueB                [[NSUserDefaults standardUserDefaults] objectForKey:@"PressureValueB"]               //后轮压力值
#define PressureIndexB                [[NSUserDefaults standardUserDefaults] objectForKey:@"PressureIndexB"]               //后轮压力下标
#define learnArry                   [[NSUserDefaults standardUserDefaults] objectForKey:@"LearnArray"]
#define voiceOrSound                [[NSUserDefaults standardUserDefaults] objectForKey:@"voiceOrSound"]
#define Language                    [[NSUserDefaults standardUserDefaults] objectForKey:@"language"]                //语言版本
/**
 *	@brief	本地设置
 */
#define NewNoticeFlag                 [[NSUserDefaults standardUserDefaults] objectForKey:@"NewNoticeFlag"]                //消息通知开关
#define SoundFlag                     [[NSUserDefaults standardUserDefaults] objectForKey:@"SoundFlag"]                    //声音开关
#define VibrationFlag                 [[NSUserDefaults standardUserDefaults] objectForKey:@"VibrationFlag"]                //震动开关
#define Version                       @"V 1.0"                      //版本号
#define Time                          [[NSUserDefaults standardUserDefaults] objectForKey:@"time"]

//#define isLogin                       [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"]                     //是否自动登录
/**
 *	@brief	通知
 */
#define KChooseCityeNotification           @"kChooseCityeNotification"                        //选择城市
#define kTireValueChangeNotification       @"kTireValueChangeNotification"                    //胎值改变
#define kDisconnectNotification            @"kDisconnectNOtification"                         //断开连接
#define kDidconnectNotification            @"kDidconnectNotification"                         //蓝牙连接
/**
 *	@brief	表名
 */


//#define C530Table                  [[NSUserDefaults standardUserDefaults] objectForKey:@"C530"] 
#define kTireValue                         @"kTireValue"                                      //胎值表
/**
 *	@brief	加载提示
 */
#define kPlaceholder  @"请稍等..."
#define welcomeKey    @"newLaunched 1.6.0"
#define psi2bar(psi) psi / 14.5
#define psi2kpa(psi) psi / 14.5 * 100
#define kpa2psi(kpa) kpa / 100 * 14.5
#define kpa2bar(kpa) kpa / 100.0
#define bar2psi(bar) bar*14.5
#define bar2kpa(bar) bar*100.0
#define cen2fah(cen) cen*1.8+32
#define fah2cen(fah) (fah-32)*10/18

#define HXString(key) [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Localizable"]

#define alertColor  [Utility colorWithHexString:@"ff3333"]
#define normalColor  [Utility colorWithHexString:@"ffffff"]


/**
 *	@brief	UI规范
 */

// qq : 842587729 wangjing19901106 http://op.open.qq.com/index.php?mod=appinfo&act=main&appid=101229029 101229029 8cc05eb49259aa03862415c733a33ce1
// sina : 842587729@qq.com wangjing1106 http://open.weibo.com/apps 532208127 33f4d34e3f4099e4dfa9fe85d96dba4f
// wechat : jenna.wang@bugootech.com bugoo1313 wx4e62381a0a850a37 d4624c36b6795d1d99dcf0547af5443d
