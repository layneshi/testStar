//
//  AppDelegate+WeChat.h
//  WearTime
//
//  Created by layne on 2023/7/14.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (WeChat)

//初始化微信
//*/
- (void)setUpWechat;

// 设置微信代理 old method
- (void)setWechatDelegateWithUrl:(NSURL *)url;

// 设置微信代理 new method
- (void)setWechatDelegateWithUserActivity:(NSUserActivity *)userActivity;



// 分享到wechat
// @param shareInfo 对象
//- (void)shareWechatMeetInfo:(MeetSdkCommonInfo *)shareInfo withController:(UIViewController *)nav;

/// 分享二维码到wechat
//- (void)shareWechatQRCodeImage:(UIImage *)image withController:(UIViewController *)nav;

@end

NS_ASSUME_NONNULL_END
