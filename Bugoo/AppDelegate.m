//
//  AppDelegate.m
//  Bugoo
//
//  Created by bugoo on 11/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "LeftViewController.h"
#import "MainViewController.h"
@interface AppDelegate ()
@property(nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIViewController *left = [[LeftViewController alloc]init];
    UIViewController *main = [[MainViewController alloc]init];
    
    
    //    UINavigationController *leftNav = [[UINavigationController alloc]initWithRootViewController:left];
    UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:main];
   
    
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:mainNav     leftDrawerViewController:left];
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    self.drawerController.maximumLeftDrawerWidth = Adapt_IPHONE6_scaleL(208.6);
    
    //6、初始化窗口、设置根控制器、显示窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:self.drawerController];
    [self.window makeKeyAndVisible];
    
    
    
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"]) {
        
        NSArray *languages = [NSLocale preferredLanguages];
        
        NSString *language = [languages objectAtIndex:0];
        
        if ([language hasPrefix:@"zh-Hans"]) {//开头匹配
            
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
            DEFAULTS_INFO(@"0", @"language");
            DEFAULTS_SYNCHRONIZE;
        }else if([language hasPrefix:@"ja"]){
            
            [[NSUserDefaults standardUserDefaults] setObject:@"ja" forKey:@"appLanguage"];
            DEFAULTS_INFO(@"1", @"language");
            DEFAULTS_SYNCHRONIZE;
        }else if([language hasPrefix:@"zh-Hant"]){
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:@"appLanguage"];
            DEFAULTS_INFO(@"3", @"language");
            DEFAULTS_SYNCHRONIZE;
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
            DEFAULTS_INFO(@"2", @"language");
            DEFAULTS_SYNCHRONIZE;
        }
        
        
    // Override point for customization after application launch.
    }
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert  categories:nil];
    
    //        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound  categories:nil];
    /**
     *  然后注册通知
     */
    [application registerUserNotificationSettings:settings];
    
    
    UIApplication *app = [UIApplication sharedApplication];
    // 应用程序右上角数字
    app.applicationIconBadgeNumber = 0;
    

/**
 *  如果程序正常启动(冷启动),launchOptions的参数为null
 *  如果程序非正常启动(热启动),launchOptions的参数时有值的
 */
if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
    NSLog(@"%@",launchOptions);
    
    [self jumpToSession];
}
    
    

    return YES;
}

- (void)jumpToSession
{
    
    
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"收到本地通知");
    [application setApplicationIconBadgeNumber:0];
    
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"收到");
        return;
    }else if (application.applicationState == UIApplicationStateInactive)
    {
        [self jumpToSession];
    }else if(application.applicationState == UIApplicationStateBackground){
        
        NSLog(@"在后台");
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
