//
//  AppDelegate+Healthy.h
//  WearTime
//
//  Created by layne on 2023/7/14.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Healthy)

/// 每次启动app的时候去获取数据并发送给服务端
- (void)getHealthyData;


/// 上传健康数据到服务器
- (void)uploadHealthyData;

@end

NS_ASSUME_NONNULL_END
