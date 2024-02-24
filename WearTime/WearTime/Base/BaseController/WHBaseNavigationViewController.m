//
//  WHBaseNavigationViewController.m
//  WearTime
//
//  Created by layne on 2023/7/5.
//

#import "WHBaseNavigationViewController.h"

@interface WHBaseNavigationViewController ()

@end

@implementation WHBaseNavigationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

#pragma mark - UINavigationBarDelegate
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
//    if (UIEventSubtypeMotionShake ==motion) {
//        if (!isRelease) {
//            [self handelShake];
//        }
//    }
}

static BOOL isShowConsole = NO;
- (void)handelShake {
    QMUIAlertController *alerController = [QMUIAlertController alertControllerWithTitle:@"调试器" message:@"开发调试工具" preferredStyle:QMUIAlertControllerStyleAlert];
    
    [alerController addAction:[QMUIAlertAction actionWithTitle:@"导出当前UI" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_Export" object:nil];
    }]];
    
    [alerController addAction:[QMUIAlertAction actionWithTitle:@"查看2D模式" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_2D" object:nil];
    }]];
    
    [alerController addAction:[QMUIAlertAction actionWithTitle:@"查看3D模式" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_3D" object:nil];
    }]];
    
    [alerController addAction:[QMUIAlertAction actionWithTitle:isShowConsole ? @"关闭控制台" : @"显示控制器" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        isShowConsole = !isShowConsole;
        if (isShowConsole) {
            [QMUIConsole show];
//            [[FLEXManager sharedManager] showExplorer];
        }else {
            [QMUIConsole hide];
//            [[FLEXManager sharedManager] hideExplorer];
        }
    }]];
    
    [alerController addAction:[QMUIAlertAction actionWithTitle:@"生成日志" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        
//        [SVProgressHUD show];
//        [MeetSdkDailyRecord makeDailyWithCompletion:^(NSString * json, NSURL *fileUrl) {
//
//            [SVProgressHUD dismiss];
//
//            if (fileUrl) {
//                [self shareLog:fileUrl];
//            }else {
//                [SVProgressHUD showErrorWithStatus:@"生成日志失败"];
//            }
//        }];
        
    }]];
    

    
    
    [alerController addAction:[QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:nil]];
    [alerController showWithAnimated:YES];
    
}

-(void)shareLog:(NSURL *)fileURL{

    //在iOS 11不显示分享选项了
//定义URL数组
    NSArray *urls=@[fileURL];
//创建分享的类型,注意这里没有常见的微信,朋友圈以QQ等,但是罗列完后,实际运行是相应按钮的,所以可以运行.

    UIActivityViewController *activituVC=[[UIActivityViewController alloc]initWithActivityItems:urls applicationActivities:nil];
    
    NSMutableArray *cludeActivitys = [@[UIActivityTypePostToFacebook,
    UIActivityTypePostToTwitter,
    UIActivityTypePostToWeibo,
    UIActivityTypePostToVimeo,
    UIActivityTypeMessage,
    UIActivityTypeMail,
    UIActivityTypeCopyToPasteboard,
    UIActivityTypePrint,
    UIActivityTypeAssignToContact,
    UIActivityTypeSaveToCameraRoll,
    UIActivityTypeAddToReadingList,
    UIActivityTypePostToFlickr,
                                        UIActivityTypePostToTencentWeibo] mutableCopy];
    
    
    if (@available(iOS 11.0, *)) {
        [cludeActivitys addObject:UIActivityTypeMarkupAsPDF];
    } else {
        // Fallback on earlier versions
    }
    
    activituVC.excludedActivityTypes=cludeActivitys;
    
//显示分享窗口
    [[QMUIHelper visibleViewController] presentViewController:activituVC animated:YES completion:nil];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [SVProgressHUD dismiss];
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    [SVProgressHUD dismiss];
    return [super popViewControllerAnimated:animated];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

@end
