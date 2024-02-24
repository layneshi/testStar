//
//  AppDelegate+JPush.m
//  WearTime
//
//  Created by layne on 2023/7/14.
//

#import "AppDelegate+JPush.h"
// 引入 JVERIFICATIONService.h 头文件
#import "JVERIFICATIONService.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>

@implementation AppDelegate (JPush)


/// 初始化极光推送 包括推送  安全认证
- (void)initJPushWithOptions:(NSDictionary *)launchOptions{
    //【注册通知】通知回调代理（可选）
      JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
      entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
      [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //【初始化sdk】
      [JPUSHService setupWithOption:launchOptions
                             appKey:WHJPushAppKey
                            channel:nil
                   apsForProduction:YES
              advertisingIdentifier:nil];
    
    
    
    // 角标清零
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [self setJPushAutnwith:launchOptions];
    
    [JPUSHService setLogOFF];
}

- (void)setJPushAutnwith:(NSDictionary *)launchOptions{
    //如需使用 IDFA 功能请添加此代码并在初始化配置类中设置 advertisingId
//    NSString *idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    JVAuthConfig *config = [[JVAuthConfig alloc] init];
    config.appKey = WHJPushAppKey;
//    config.advertisingId = nil;
    config.authBlock = ^(NSDictionary *result) {
        NSLog(@"");
    };
    [JVERIFICATIONService setupWithConfig:config];
    
    [JVERIFICATIONService setDebug:NO];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //sdk注册DeviceToken
        [JPUSHService registerDeviceToken:deviceToken];

}

@end
