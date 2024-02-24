//
//  WHTools.m
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import "WHTools.h"
#import "JVERIFICATIONService.h"
#import "WXApi.h"

@implementation WHTools


/*!
 *  每一次进入app如果是有token的情况，通过token去拿一次用户信息
 */
+ (void)getUseLoginInWithToken{
    [WHWearTimeApi getUserInfoWithTokenOnSuccess:^(WHUserModel * _Nonnull userModel) {
        [[WHUserInfo sharedInfo] saveUserInfoWithModel:userModel];
    } onFailure:^(NSError * _Nonnull error) {
//        [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
    }];
}


// 生成个人资料随机数
+ (int)getUuid{
    return (int)(100 + (arc4random() % 999900));
}

+ (void)hasSupportComplete:(void(^)(BOOL support, NSString *token))compltion{
    if (![JVERIFICATIONService checkVerifyEnable]) {
        RunInMainQueue(^{
            if (compltion){
                compltion(NO,nil);
            }
            return;
        })

    }
    
    
    [JVERIFICATIONService getToken:^(NSDictionary *result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSInteger code = [result[@"code"] integerValue];
            if (code == 2000) {
                RunInMainQueue(^{
                    if (compltion){
                        compltion(YES,result[@"token"]);
                    }
                })
                

            } else {
                RunInMainQueue(^{
                    if (compltion){
                        compltion(NO,nil);
                    }
                })
                

            }
            
        } else {
            
            RunInMainQueue(^{
                if (compltion){
                    compltion(NO,nil);
                }
            })
        }
        
        
        
    }];
}

/// NSDate转时间字符串
+ (NSString *)dateToStringWithDate:(NSDate *)date{
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    //输出currentDateString
    NSLog(@"%@",currentDateString);
    return currentDateString;
}

/*!
 *  判断微信是否安装
 */
+ (BOOL)isWechatInstalled{
    return [WXApi isWXAppInstalled];
}



@end
