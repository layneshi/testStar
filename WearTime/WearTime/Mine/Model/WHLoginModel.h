//
//  WHLoginModel.h
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHLoginModel : NSObject

@property(nonatomic, copy) NSString *appleSub;   // apple唯一标识
@property(nonatomic, copy) NSString *code;    // 手机验证码
//@property(nonatomic, assign) NSInteger ID;     // 主键id
@property(nonatomic, copy) NSString *loginType;    // 0：手机号  1:账号密码   2:一键登录
@property(nonatomic, copy) NSString *openid;   // 微信openid
@property(nonatomic, copy) NSString *password;    // 密码
@property(nonatomic, copy) NSString *phone;    // 手机号
@property(nonatomic, copy) NSString *username;    // 账号




@end

NS_ASSUME_NONNULL_END
