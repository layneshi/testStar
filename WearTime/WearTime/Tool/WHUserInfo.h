//
//  WHUserInfo.h
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHUserInfo : NSObject


+ (instancetype)sharedInfo;

#pragma mark  --- 登录获取的参数

@property(nonatomic, strong) NSString *name;  // 姓名
@property(nonatomic, strong) NSString *phone;  // 手机号
@property(nonatomic, strong) NSString *userId;   // 用户id
//@property(nonatomic, strong) NSString *token;   // token鉴权
@property(nonatomic, strong) NSString *password;   // 密码


#pragma mark  --- 个人资料获取的
@property(nonatomic, strong) NSString *sex;  // 性别
@property(nonatomic, assign) NSInteger height;  // 身高
@property(nonatomic, assign) NSInteger weight;   // 体重
@property(nonatomic, strong) NSString *infoId;   // 个人资料id
@property(nonatomic, strong) NSString *birthday;   // 生日


#pragma mark --- 用户健康权限上传设置

- (void)saveUserInfoWithModel:(WHUserModel *)userModel;


- (void)saveUserPerInfoWith:(WHPeopleModel *)peopleModel;

@end

NS_ASSUME_NONNULL_END
