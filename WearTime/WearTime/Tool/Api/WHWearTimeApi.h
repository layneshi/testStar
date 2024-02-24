//
//  WHWearTimeApi.h
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#import <Foundation/Foundation.h>
#import "WHPeopleModel.h"
#import "WHAgreementTitleModel.h"
#import "WHLoginModel.h"
#import "WHUserModel.h"
#import "WHReportModel.h"
#import "WHSendTimeModel.h"
#import "WHModuleModel.h"
#import "WHSendToModel.h"
#import "WHSendWxModel.h"
#import "WHReportListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WHWearTimeApi : NSObject

#pragma mark - 个人资料
/*!
 *  添加/修改个人资料
 *  @param model 用户信息
 *  @param onSuccess peopleModel 用户信息
 */
+ (void)addOrChangeInfoWithUserInfo:(WHPeopleModel *)model
                          onSuccess:(void (^)(WHPeopleModel *peopleModel))onSuccess
                          onFailure:(void (^)(NSError *error))onFailure;

/*!
 *  获取病例选择列表
 *  @param onSuccess 成功回调
 */
+ (void)getMedicalCasesOnSuccess:(void (^)(NSArray *cases))onSuccess
                       onFailure:(void (^)(NSError *error))onFailure;

/*!
 *  获取个人资料信息
 *  @param onSuccess 成功回调
 */
+ (void)queryUserInfoWithUserModel:(WHPeopleModel *)loginModel
                     onSuccess:(void (^)(WHPeopleModel *queryUserInfoWithUserModel))onSuccess
                        onFailure:(void (^)(NSError *error))onFailure;

#pragma mark -- 体检报告
/*!
 *  添加体检报告
 *  @param onSuccess 成功回调
 */
+ (void)addMedicalReportWithModel:(WHReportModel *)model
                        onSuccess:(void (^)(void))onSuccess
                           onFailure:(void (^)(NSError *error))onFailure;
/*!
 *  体检报告发送对象信息添加
 *  @param onSuccess 成功回调
 */
+ (void)addSendToWithUseArray:(NSArray <WHSendToModel *>*)lists
                    onSuccess:(void (^)(void))onSuccess
                       onFailure:(void (^)(NSError *error))onFailure;

/*!
 *  体检报告发送微信信息添加
 *  @param onSuccess 成功回调
 */
+ (void)addSendWxWithUseArray:(NSArray <WHSendWxModel *>*)lists
                    onSuccess:(void (^)(void))onSuccess
                       onFailure:(void (^)(NSError *error))onFailure;

/*!
 *   删除发送对象
 *  @param onSuccess 成功回调
 */
+ (void)deleteSendToWithUserId:(NSString *)userId
                      nSuccess:(void (^)(void))onSuccess
                         onFailure:(void (^)(NSError *error))onFailure;

/*!
 *   删除发送微信对象
 *  @param onSuccess 成功回调
 */
+ (void)deleteSendWxWithUserId:(NSString *)userId
                      nSuccess:(void (^)(void))onSuccess
                         onFailure:(void (^)(NSError *error))onFailure;


/*!
 *  查询体检报告
 *  @param  reportId 通过用户个人资料的id去查询
 *  @param onSuccess 成功回调
 */
+ (void)queryReportWithId:(NSString *)reportId
                onSuccess:(void (^)(WHReportModel *model))onSuccess
                   onFailure:(void (^)(NSError *error))onFailure;


/*!
 *  查询选择的模板
 *  @param reportId 通过体检报告的id去查询
 *  @param onSuccess 成功回调
 */
+ (void)queryMoudleWithId:(NSString *)reportId
                onSuccess:(void (^)(WHModuleModel *model))onSuccess
                   onFailure:(void (^)(NSError *error))onFailure;


/*!
 *  体检报告添加修改模板 #import "WHModuleModel.h"
 *  @param onSuccess 成功回调
 */
+ (void)reportModuleWithModels:(NSArray <WHModuleModel *>*)modules
                onSuccess:(void (^)(void))onSuccess
                   onFailure:(void (^)(NSError *error))onFailure;

/*!
 *  定时发送设置
 *  @param onSuccess 成功回调
 */
+ (void)scheduledReportWithModel:(WHSendTimeModel *)model
                       onSuccess:(void (^)(void))onSuccess
                          onFailure:(void (^)(NSError *error))onFailure;

/*!
 *  收到发送报告
 *  @param onSuccess 成功回调
 */
+ (void)sendReportOnSuccess:(void (^)(void))onSuccess
                  onFailure:(void (^)(NSError *error))onFailure;


/*!
 *  修改体检报告
 *  @param onSuccess 成功回调
 */
+ (void)updateReportWithReportModel:(WHReportModel *)model
                          onSuccess:(void (^)(void))onSuccess
                  onFailure:(void (^)(NSError *error))onFailure;

#pragma mark - 体检报告接口
/*!
 *  查询已选择的体检报告清单
 *  @param onSuccess 成功回调
 */
+ (void)queryChooseWithId:(NSString *)userId
                       onSuccess:(void (^)(WHReportListModel *model))onSuccess
                          onFailure:(void (^)(NSError *error))onFailure;

/*!
 *  添加/修改体检报告清单
 *  @param onSuccess 成功回调
 */
+ (void)saveChooseWithId:(NSString *)userId
               listModel:(WHReportListModel *)model
               onSuccess:(void (^)(void))onSuccess
               onFailure:(void (^)(NSError *error))onFailure;

#pragma mark - 用户协议接口
/*!
 *  获取协议内容
 *  @param titleId  id
 *  @param onSuccess 成功回调
 */
+ (void)getAgreementTitlesWithId:(NSInteger)titleId
                       onSuccess:(void (^)(WHAgreementTitleModel *titleModel))onSuccess
                          onFailure:(void (^)(NSError *error))onFailure;


/*!
 *  获取标题列表
 *  @param onSuccess peopleModel 用户信息
 */
+ (void)getAgreementTitlesOnSuccess:(void (^)(NSArray <WHAgreementTitleModel *>*titleModel))onSuccess
                          onFailure:(void (^)(NSError *error))onFailure;


#pragma mark - 登录接口
/*!
 *  用户注册
 *  @param onSuccess 成功回调
 */
+ (void)userRegisterWithModel:(WHLoginModel *)loginModel
                    onSuccess:(void (^)(void))onSuccess
                       onFailure:(void (^)(NSError *error))onFailure;

/*!
 *  发送验证码
 *  @param onSuccess 成功回调
 */
+ (void)sendPhoneCodeWithPhone:(NSString *)phone
                          type:(NSString *)type
                     onSuccess:(void (^)(void))onSuccess
                        onFailure:(void (^)(NSError *error))onFailure;

/*!
 *  登录
 *  @param onSuccess 成功回调
 */
+ (void)loginWithModel:(WHLoginModel *)loginModel
                      onSuccess:(void (^)(NSString *token))onSuccess
                         onFailure:(void (^)(NSError *error))onFailure;

/*!
 *   通过token返回用户信息
 *  @param onSuccess 成功回调
 */
+ (void)getUserInfoWithTokenOnSuccess:(void (^)(WHUserModel *userModel))onSuccess
                            onFailure:(void (^)(NSError *error))onFailure;

/*!
 *   忘记密码
 *  @param onSuccess 成功回调
 */
+ (void)forgetPasswordWithModel:(WHLoginModel *)model
                      onSuccess:(void (^)(void))onSuccess
                         onFailure:(void (^)(NSError *error))onFailure;

/*!
 *   退出登录
 *  @param onSuccess 成功回调
 */
+ (void)logOutOnSuccess:(void (^)(void))onSuccess
              onFailure:(void (^)(NSError *error))onFailure;

@end

NS_ASSUME_NONNULL_END
