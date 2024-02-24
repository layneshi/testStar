//
//  AppDelegate.m
//  WearTime
//
//  Created by layne on 2023/7/5.
//

#import "AppDelegate.h"
#import "WHLoginViewController.h"
#import "WHPersonalViewController.h"
#import "IQKeyboardManager.h"

#import "AppDelegate+JPush.h"
#import "AppDelegate+WeChat.h"
#import "AppDelegate+Healthy.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setRootController];
    
    [self initJPushWithOptions:launchOptions];
    [self setUpWechat];
    // 获取健康数据并进行上传
    [self getHealthyData];
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.shouldResignOnTouchOutside = YES;
    
    return YES;
}

- (void)setRootController {
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:WHUserToken]) {
        WHPersonalViewController *vc = [WHPersonalViewController new];
        WHBaseNavigationViewController *naVc = [[WHBaseNavigationViewController alloc] initWithRootViewController:vc];
        self.window.rootViewController = naVc;
        [WHTools getUseLoginInWithToken];
    } else {
        WHLoginViewController *viewController = [WHLoginViewController new];
        WHBaseNavigationViewController *naVc = [[WHBaseNavigationViewController alloc] initWithRootViewController:viewController];
        self.window.rootViewController = naVc;
        [self.window makeKeyAndVisible];
    }
    
}
@end
