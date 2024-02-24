//
//  WHApiLists.h
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#ifndef WHApiLists_h
#define WHApiLists_h


#define WHApiUrl     @"http://192.168.124.54:8080"
#define WHAppUrl(url)   [NSString stringWithFormat:@"%@%@",WHApiUrl,url]

#pragma mark - 个人资料


/// 添加修改个人信息  post
#define WHAddInfoApi     WHAppUrl(@"/userInfo/addInfo")

/// 获取病例选择列表  get
#define WHCaseListsApi  WHAppUrl(@"/userInfo/getCase")

/// 获取个人资料信息  post
#define WHQueryInfoApi     WHAppUrl(@"/userInfo/queryInfo")


#pragma mark - 体检报告接口
/// 添加体检报告接口  post
#define WHAddMedicalReportApi    WHAppUrl(@"/report/addMedicalReport")

/// 体检报告发送对象信息添加
#define WHAddSendToApi   WHAppUrl(@"/report/addSendTo")

/// 体检报告发送微信信息添加
#define WHAddSendWxApi   WHAppUrl(@"/report/addSendWx")

/// 删除发送对象 get
#define WHDeleteSendToApi   WHAppUrl(@"/report/deleteSendTo/")

/// 删除发送微信 get
#define WHDeleteSendWxApi   WHAppUrl(@"/report/deleteSendWx")

/// 查询体检报告  get
#define WHQueryReportApi      WHAppUrl(@"/report/queryByInfoId")

/// 查询选择的模板
#define WHQueryModelApi      WHAppUrl(@"/report/queryModel")

/// 体检报告模板添加修改
#define WHReportModelApi      WHAppUrl(@"/report/reportModel")

/// 定时发送时间设置  post
#define WHScheduledSendReportApi    WHAppUrl(@"/report/scheduled")

/// 手动发送报告  get
#define WHSendReportApi      WHAppUrl(@"/report/sendReport")

/// 修改体检报告清单 post
#define WHUpdateReportApi      WHAppUrl(@"/report/updateReport")


#pragma mark - 体检报告接口
/// 查询已选择的体检报告
#define WHQueryChooseApi  WHAppUrl(@"/choose/queryChoose")

/// 添加修改体检报告项目清单
#define WHSaveChooseApi  WHAppUrl(@"/choose/saveChoose")

#pragma mark - 用户协议接口
/// 获取内容  get
#define WHGetAgreementApi      WHAppUrl(@"/agreement/getContent/")

/// 获取标题列表  get
#define WHGetAgreementTitleApi    WHAppUrl(@"/agreement/getTitle")


#pragma mark - 登录接口
/// 苹果授权登录 post
#define WHAppleLoginApi      WHAppUrl(@"/login/AppleLogin")
//// identityToken

/// 微信回调 get
#define WHCalBackinApi      WHAppUrl(@"/login/callBack")

// 根据用户id查询用户信息 get
#define WHGetUserInfoByIdApi     WHAppUrl(@"/login/getById/{id}")

// 根据返回的token获取用户信息 
#define WHGetUserInfoByTokenApi      WHAppUrl(@"/login/getByToken")

/// 登录 post
#define WHLoginApi     WHAppUrl(@"/login/login")

/// 用户注册 post
#define WHRegisterApi     WHAppUrl(@"/login/register")

/// 发送验证码 
#define WHSendPhoneCodeApi     WHAppUrl(@"/login/sendSms")

/// 忘记密码 post
#define WHSetPwdApi     WHAppUrl(@"/login/setPassword")

/// wxlogin post
#define WHWXLoginApi     WHAppUrl(@"/login/wxlogin")

///  退出登录
#define WHLogOutApi  WHAppUrl(@"login/loginOut")




#endif /* WHApiLists_h */
