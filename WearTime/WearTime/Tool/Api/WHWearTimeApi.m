//
//  WHWearTimeApi.m
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#import "WHWearTimeApi.h"
#import "SLRequestNetWorking.h"
#import "NSObject+SLModel.h"
#import "WHApiLists.h"
#import "WHResponseModel.h"
#import "WHPhoneModel.h"

#define XXIMDOMAIN @"XXIMDOMAIN"

@implementation WHWearTimeApi

#pragma mark - 个人资料
/*!
 *  添加/修改个人资料
 *  @param model 用户信息
 *  @param onSuccess peopleModel 用户信息
 */
+ (void)addOrChangeInfoWithUserInfo:(WHPeopleModel *)model
                          onSuccess:(void (^)(WHPeopleModel *peopleModel))onSuccess
                          onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHAddInfoApi parameter:[model sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(NSDictionary *dic) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess(model);
                }
            })
        } onFailure:onFailure];
        
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

+ (void)getMedicalCasesOnSuccess:(void (^)(NSArray *cases))onSuccess
                       onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLGetMethod urlString:WHCaseListsApi parameter:nil token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            NSMutableArray *arr = [NSMutableArray array];
            if ([responseData isKindOfClass:[NSDictionary class]]) {
                NSArray *keysArr = [responseData allKeys];
                for (NSString *key in keysArr) {
                    [arr addObject:responseData[key]];
                }
                
                RunInMainQueue(^{
                    if (onSuccess) {
                        onSuccess(arr);
                    }
                })
            } else {
                [self dataIsNotCurrentOnFailure:onFailure];
            }
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *  获取个人资料信息
 *  @param onSuccess 成功回调
 */
+ (void)queryUserInfoWithUserModel:(WHPeopleModel *)loginModel
                     onSuccess:(void (^)(WHPeopleModel *peopleModel))onSuccess
                        onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHQueryInfoApi parameter:[loginModel sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            if ([responseData isKindOfClass:[NSDictionary class]]) {
                WHPeopleModel *peopleMddel = [WHPeopleModel sl_modelWithDictionary:responseData];
                RunInMainQueue(^{
                    if (onSuccess) {
                        onSuccess(peopleMddel);
                    }
                })
            } else {
                [self dataIsNotCurrentOnFailure:onFailure];
            }
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

#pragma mark -- 体检报告
/*!
 *  添加体检报告
 *  @param onSuccess 成功回调
 */
+ (void)addMedicalReportWithModel:(WHReportModel *)model
                        onSuccess:(void (^)(void))onSuccess
                        onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHAddMedicalReportApi parameter:[model sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess();
                }
            })
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *  体检报告发送对象信息添加
 *  @param onSuccess 成功回调
 */
+ (void)addSendToWithUseArray:(NSArray <WHSendToModel *>*)lists
                    onSuccess:(void (^)(void))onSuccess
                    onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHAddSendToApi parameter:[lists sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess();
                }
            })

        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *  体检报告发送微信信息添加
 *  @param onSuccess 成功回调
 */
+ (void)addSendWxWithUseArray:(NSArray <WHSendWxModel *>*)lists
                    onSuccess:(void (^)(void))onSuccess
                    onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHAddSendWxApi parameter:[lists sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess();
                }
            })

        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *   删除发送对象
 *  @param onSuccess 成功回调
 */
+ (void)deleteSendToWithUserId:(NSString *)userId
                      nSuccess:(void (^)(void))onSuccess
                     onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLGetMethod urlString:[WHDeleteSendToApi stringByAppendingString:userId] parameter:nil token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        RunInMainQueue(^{
            if (onSuccess) {
                onSuccess();
            }
        })
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *   删除发送微信对象
 *  @param onSuccess 成功回调
 */
+ (void)deleteSendWxWithUserId:(NSString *)userId
                      nSuccess:(void (^)(void))onSuccess
                     onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLGetMethod urlString:[WHDeleteSendWxApi stringByAppendingString:userId] parameter:nil token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        RunInMainQueue(^{
            if (onSuccess) {
                onSuccess();
            }
        })
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *  查询体检报告
 *  @param onSuccess 成功回调
 */
+ (void)queryReportWithId:(NSString *)reportId
                onSuccess:(void (^)(WHReportModel *model))onSuccess
                onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLGetMethod urlString:[NSString stringWithFormat:@"%@/%@",WHQueryReportApi,reportId] parameter:nil token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess([WHReportModel new]);
                }
            })
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *  查询选择的模板
 *  @param onSuccess 成功回调
 */
+ (void)queryMoudleWithId:(NSString *)reportId
                onSuccess:(void (^)(WHModuleModel *model))onSuccess
                onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHQueryModelApi parameter:nil token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess([WHModuleModel new]);
                }
            })
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *  体检报告添加修改模板
 *  @param onSuccess 成功回调
 */
+ (void)reportModuleWithModels:(NSArray <WHModuleModel *>*)modules
                onSuccess:(void (^)(void))onSuccess
                     onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHReportModelApi parameter:[modules sl_modelToJSONData] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess();
                }
            })

        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *  定时发送设置
 *  @param onSuccess 成功回调
 */
+ (void)scheduledReportWithModel:(WHSendTimeModel *)model
                       onSuccess:(void (^)(void))onSuccess
                       onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHScheduledSendReportApi parameter:[model sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess();
                }
            })
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *  手动发送报告
 *  @param onSuccess 成功回调
 */
+ (void)sendReportOnSuccess:(void (^)(void))onSuccess
                  onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLGetMethod urlString:WHSendReportApi parameter:nil token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            if (onSuccess) {
                onSuccess();
            }
        } onFailure:onFailure ];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *  修改体检报告
 *  @param onSuccess 成功回调
 */
+ (void)updateReportWithReportModel:(WHReportModel *)model
                          onSuccess:(void (^)(void))onSuccess
                          onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHUpdateReportApi parameter:[model sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess();
                }
            })
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *  查询已选择的体检报告清单
 *  @param onSuccess 成功回调
 */
+ (void)queryChooseWithId:(NSString *)userId
                       onSuccess:(void (^)(WHReportListModel *model))onSuccess
                onFailure:(void (^)(NSError *error))onFailure{
    NSDictionary *dic = @{@"userId" : userId};
    
    if (userId == nil) {
        [self dataIsNotCurrentOnFailure:onFailure];
        return;
    }
    
    [SLRequestNetWorking postPath:WHQueryChooseApi parameters:dic token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            if ([responseData isKindOfClass:[NSDictionary class]]) {
                WHReportListModel *model = [WHReportListModel sl_modelWithDictionary:data];
                RunInMainQueue(^{
                    if (onSuccess) {
                        onSuccess(model);
                    }
                })
            } else {
                [self dataIsNotCurrentOnFailure:onFailure];
            }

        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *  添加/修改体检报告清单
 *  @param onSuccess 成功回调
 */
+ (void)saveChooseWithId:(NSString *)userId
               listModel:(WHReportListModel *)model
               onSuccess:(void (^)(void))onSuccess
               onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHSaveChooseApi parameter:[model sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess();
                }
            })
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

#pragma mark - 用户协议接口
/*!
 *  获取协议内容
 *  @param titleId  id
 *  @param onSuccess peopleModel 用户信息
 */
+ (void)getAgreementTitlesWithId:(NSInteger)titleId
                       onSuccess:(void (^)(WHAgreementTitleModel *titleModel))onSuccess
                       onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLGetMethod urlString:[WHGetAgreementApi stringByAppendingString:[NSString stringWithFormat:@"%@",@(titleId)]] parameter:nil token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            if ([responseData isKindOfClass:[NSDictionary class]]) {
                WHAgreementTitleModel *model = [WHAgreementTitleModel sl_modelWithDictionary:responseData];
                RunInMainQueue(^{
                    if (onSuccess) {
                        onSuccess(model);
                    }
                })
            } else {
                [self dataIsNotCurrentOnFailure:onFailure];
            }
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}


/*!
 *  获取标题列表
 *  @param onSuccess peopleModel 用户信息
 */
+ (void)getAgreementTitlesOnSuccess:(void (^)(NSArray <WHAgreementTitleModel *>*titleModel))onSuccess
                          onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLGetMethod urlString:WHGetAgreementTitleApi parameter:nil token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            if ([responseData isKindOfClass:[NSArray class]]) {
                NSArray <WHAgreementTitleModel *> *titleArr = [NSArray array];
//                for (WHAgreementTitleModel *titleModel in responseData) {
//                    [titleArr addObject:titleModel];
//                };
                titleArr = [NSArray sl_modelArrayWithClass:[WHAgreementTitleModel class] json:responseData];
                RunInMainQueue(^{
                    if (onSuccess) {
                        onSuccess(titleArr);
                    }
                })
            } else {
                [self dataIsNotCurrentOnFailure:onFailure];
            }
    
        } onFailure:onFailure];
        
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}


#pragma mark - 登录接口
/*!
 *  用户注册
 *  @param onSuccess 成功回调
 */
+ (void)userRegisterWithModel:(WHLoginModel *)loginModel
                    onSuccess:(void (^)(void))onSuccess
                    onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHRegisterApi parameter:[loginModel sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess();
                }
            })
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *  发送验证码
 *  @param onSuccess 成功回调
 */
+ (void)sendPhoneCodeWithPhone:(NSString *)phone
                          type:(NSString *)type
                     onSuccess:(void (^)(void))onSuccess
                     onFailure:(void (^)(NSError *error))onFailure{
    WHPhoneModel *phoneModel = [WHPhoneModel new];
    phoneModel.phone = phone;
    phoneModel.type = type;
    [SLRequestNetWorking postPath:WHSendPhoneCodeApi parameters:[phoneModel sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess();
                }
            })
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })

    }];
}

/*!
 *  登录
 *  @param onSuccess 成功回调
 */
+ (void)loginWithModel:(WHLoginModel *)loginModel
                      onSuccess:(void (^)(NSString *token))onSuccess
             onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHLoginApi parameter:[loginModel sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            /// 获取登录以后的token
            if ([responseData isKindOfClass:[NSString class]]) {
                NSString *tokenStr = responseData;
                if (tokenStr.length > 20) {
                    RunInMainQueue(^{
                        if (onSuccess) {
                            onSuccess(responseData);
                        }
                    })
                } else {
                    RunInMainQueue(^{
                        if (onFailure) {
                            onFailure([self XX_makeErrorWithCode:500 description:tokenStr]);
                        }
                    })
                }

            } else {
                [self dataIsNotCurrentOnFailure:onFailure];
            }
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *   通过token返回用户信息
 *  @param onSuccess 成功回调
 */
+ (void)getUserInfoWithTokenOnSuccess:(void (^)(WHUserModel *userModel))onSuccess
                            onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHGetUserInfoByTokenApi parameter:nil token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            if ([responseData isKindOfClass:[NSDictionary class]]) {
                WHUserModel *useModel = [WHUserModel sl_modelWithDictionary:responseData];
                RunInMainQueue(^{
                    if (onSuccess) {
                        onSuccess(useModel);
                    }
                })
            } else {
                [self dataIsNotCurrentOnFailure:onFailure];
            }
            
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
    }];
}

/*!
 *   忘记密码
 *  @param onSuccess 成功回调
 */
+ (void)forgetPasswordWithModel:(WHLoginModel *)model
                      onSuccess:(void (^)(void))onSuccess
                      onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHSetPwdApi parameter:[model sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [SLRequestNetWorking postPath:WHSendPhoneCodeApi parameters:[model sl_modelToJSONObject] token:GET_KTToken onSuccess:^(id  _Nonnull data) {
            [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
                RunInMainQueue(^{
                    if (onSuccess) {
                        onSuccess();
                    }
                })
            } onFailure:onFailure];
        } onFailure:^(NSError * _Nonnull error) {
            RunInMainQueue(^{
                if (onFailure) {
                    onFailure(error);
                }
            })

        }];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })

    }];
}

/*!
 *   退出登录
 *  @param onSuccess 成功回调
 */
+ (void)logOutOnSuccess:(void (^)(void))onSuccess
              onFailure:(void (^)(NSError *error))onFailure{
    [SLRequestNetWorking requestWithMethod:SLPostMethod urlString:WHLogOutApi parameter:nil token:GET_KTToken onSuccess:^(id  _Nonnull data) {
        [self verifyResponseDataWithData:data onSuccess:^(id responseData) {
            RunInMainQueue(^{
                if (onSuccess) {
                    onSuccess();
                }
            })
        } onFailure:onFailure];
    } onFailure:^(NSError * _Nonnull error) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure(error);
            }
        })
        
    }];
}

#pragma mark --- 判断回执
+ (void)verifyResponseDataWithData:(id)data
                         onSuccess:(void (^)(id responseData))onSuccess
                         onFailure:(void (^)(NSError *error))onFailure{
    if (data == nil) {
        RunInMainQueue(^{
            if (onFailure) {
                onFailure([self XX_makeErrorWithCode:100 description:@"data is nil"]);
            }
        })
        return;
    }
    
    if (![data isKindOfClass:[NSDictionary class]]) {
        [self dataIsNotCurrentOnFailure:onFailure];
        return;
    }
    
    WHResponseModel *model = [WHResponseModel sl_modelWithDictionary:data];
    if (model.status == 200) {
        if (onSuccess) {
            onSuccess(model.data);
        }
    } else {
        if (onFailure) {
            onFailure([self XX_makeErrorWithCode:model.status description:model.errorMsg]);
        }
    }
    
}


+ (void)dataIsNotCurrentOnFailure:(void (^)(NSError *error))onFailure{
    RunInMainQueue(^{
        if (onFailure) {
            onFailure([self XX_makeErrorWithCode:101 description:@"data is not correct"]);
        }
    })
}


#pragma mark - error
+ (NSError *)XX_makeErrorWithCode:(NSInteger)code description:(NSString *)description {
    NSError *error = [NSError errorWithDomain:XXIMDOMAIN code:code userInfo:@{NSLocalizedDescriptionKey:description ? description : @"unknow error"}];
    return error;
}

@end
