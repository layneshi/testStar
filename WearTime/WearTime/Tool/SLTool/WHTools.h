//
//  WHTools.h
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHTools : NSObject


/*!
 *  每一次进入app如果是有token的情况，通过token去拿一次用户信息
 */
+ (void)getUseLoginInWithToken;



/*!
 *  获取UUID
 */
+ (int)getUuid;

/*!
 *  判断是否支持极光一键登录
 */
+ (void)hasSupportComplete:(void(^)(BOOL support, NSString *token))compltion;


/*!
 *  NSDate转时间字符串
 */
+ (NSString *)dateToStringWithDate:(NSDate *)date;


/*!
 *  判断微信是否安装
 */
+ (BOOL)isWechatInstalled;

@end

NS_ASSUME_NONNULL_END
