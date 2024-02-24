//
//  AppDelegate+WeChat.m
//  WearTime
//
//  Created by layne on 2023/7/14.
//

#import "AppDelegate+WeChat.h"
#import "WXApi.h"

@interface AppDelegate ()  <WXApiDelegate>

@end

@implementation AppDelegate (WeChat)


- (void)setUpWechat{
    [WXApi registerApp:WHWechatAppKey universalLink:@"https://meet.yxt.com/" ];
}


// 设置微信代理 old method
- (void)setWechatDelegateWithUrl:(NSURL *)url{
    [WXApi handleOpenURL:url delegate:self];
}

// 设置微信代理 new method
- (void)setWechatDelegateWithUserActivity:(NSUserActivity *)userActivity{
    [WXApi handleOpenUniversalLink:userActivity delegate:self];
}


//- (void)shareWechatMeetInfo:(MeetSdkCommonInfo *)shareInfo withController:(UIViewController *)nav{
//    NSString *shareTitle = [NSString stringWithFormat:@"%@：%@",MeetLocalized(@"会议邀请"),shareInfo.roomName];
//    BOOL isArrowDay = ![[shareInfo.orderMeetStartTime stringWithFormat:@"yyyy/MM/dd"] isEqualToString:[shareInfo.orderMeetEndTime stringWithFormat:@"yyyy/MM/dd"]];
//    NSString *meetEndTime = isArrowDay ? [shareInfo.orderMeetEndTime stringWithFormat:@"yyyy/MM/dd HH:mm"] : [shareInfo.orderMeetEndTime stringWithFormat:@"HH:mm"];
//    NSString *meetStartTime = [shareInfo.orderMeetStartTime stringWithFormat:@"yyyy/MM/dd HH:mm"];
//    NSString *personalTime = [shareInfo.currentMeet_createTime stringWithFormat:@"yyyy/MM/dd HH:mm"];
//    NSString *meetTime = [NSString stringWithFormat:@"%@: %@ - %@",MeetLocalized(@"会议时间"),shareInfo.personal ? personalTime : meetStartTime,shareInfo.personal ? @"" : meetEndTime];
//
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    WXWebpageObject *pageObject = [WXWebpageObject new];
//    pageObject.webpageUrl = shareInfo.url;
//
//    WXMediaMessage *wxMediaMessage = [WXMediaMessage message];
//    wxMediaMessage.title = shareTitle;
//    wxMediaMessage.mediaObject = pageObject;
//    [wxMediaMessage setThumbImage:[UIImage imageNamed:@"绚星logo"]];
//    wxMediaMessage.description = [NSString  stringWithFormat:@"%@\n%@：%@",meetTime,MeetLocalized(@"会议号"),shareInfo.meetKey];
//
//    req.message = wxMediaMessage;
//
//    [WXApi sendReq:req completion:^(BOOL success) {
//        NSLog(@"发送消息成功 %@",@(success));
//    }];
//}

/// 分享二维码到wechat
//- (void)shareWechatQRCodeImage:(UIImage *)image withController:(UIViewController *)nav{
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    WXMediaMessage *wxMediaMessage = [WXMediaMessage message];
//    [wxMediaMessage setThumbImage:image];
//    WXImageObject *imageObject = [WXImageObject object];
//    NSData *data = UIImagePNGRepresentation(image);
//    imageObject.imageData = data;
//    // 多媒体数据对象，可以为WXImageObject，WXMusicObject，WXVideoObject，WXWebpageObject等。
//    wxMediaMessage.mediaObject = imageObject;
//    req.message = wxMediaMessage;
//    [WXApi sendReq:req completion:^(BOOL success) {
//        NSLog(@"发送消息成功 %@",@(success));
//    }];
//}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [WXApi handleOpenURL:url delegate:self];;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

#pragma mark -- WXApiDelegate
- (void)onReq:(BaseReq *)req{
    NSLog(@"收到微信回调 onReq : %@",req);
}

- (void)onResp:(BaseResp *)resp{
    NSLog(@"收到微信回调 onResp : %@",resp);
}

@end
