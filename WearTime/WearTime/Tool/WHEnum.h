//
//  WHEnum.h
//  WearTime
//
//  Created by layne on 2023/7/10.
//

#ifndef WHEnum_h
#define WHEnum_h


#define RunInMainQueue(block) \
if ([[NSThread currentThread] isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}\





typedef enum : NSUInteger {
    WHPickViewType_Everyday        = 0, // 每天
    WHPickViewType_OtherDay     = 1, // 每间隔几天
    WHPickViewType_EveryWeek  = 2 // 每周
} WHPickViewType;


/// 发送短信类型
typedef enum : NSUInteger {
    WHSendMsmType_Register       = 0, //  注册
    WHSendMsmType_Login     = 1, // 登录
    WHSendMsmType_forgetPwd  = 2 // 忘记密码
} WHSendMsmType;

/// 登录类型
typedef enum : NSUInteger {
    WHLoginType_Phone       = 0, //  手机号
    WHLoginType_Account     = 1, // 账号密码
    WHLoginType_Fast  = 2 // 一键登录
} WHLoginType;

typedef enum : NSUInteger {
    WHSelectMedicType_His        = 0, // 过去病史
    WHSelectMedicType_Family     = 1, // 家庭病史
} WHSelectMedicType;

#endif /* WHEnum_h */
