//
//  WHLoginViewController.m
//  WearTime
//
//  Created by layne on 2023/7/5.
//

#import "WHLoginViewController.h"
#import "WHAgreementView.h"
#import "WHOtherLoginView.h"
#import "WHRegisterViewController.h"
#import "WHAccountLoginViewController.h"
#import "WHTipsView.h"
#import "WHPersonalViewController.h"
#import "WHWearTimeApi.h"

#import "WXApi.h"
#import <AuthenticationServices/AuthenticationServices.h>

// 引入 JVERIFICATIONService.h 头文件
#import "JVERIFICATIONService.h"

@interface WHLoginViewController () <ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

@property(nonatomic, strong) QMUIButton *registBtn;   // 新用户注册
@property(nonatomic, strong) QMUIButton *fastLoginBtn;  // 本机号码一键登录
@property(nonatomic, strong) QMUIButton *accountLoginBtn;  // 账号登录
@property(nonatomic, strong) UIImageView *logoImageView;
@property(nonatomic, strong) QMUILabel *phoneLabel;   // 手机号码
@property(nonatomic, strong) WHAgreementView *agreementView;
@property(nonatomic, strong) WHOtherLoginView *otherLoginView;
@property(nonatomic, strong) WHTipsView *loginTipsView;

@property(nonatomic, strong) NSArray <WHAgreementTitleModel *> *titleModelArr;

@end

@implementation WHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.registBtn];
    [self.view addSubview:self.fastLoginBtn];
    [self.view addSubview:self.accountLoginBtn];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.agreementView];
    [self.view addSubview:self.otherLoginView];
    
    [self.fastLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(50.f);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
    }];
    
    [self.accountLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fastLoginBtn.mas_bottom).offset(10.f);
        make.height.mas_equalTo(50.f);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.fastLoginBtn.mas_top).offset(-10.f);
        make.height.mas_equalTo(50.f);
        make.centerX.equalTo(self.view);
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.phoneLabel.mas_top).offset(-10.f);
        make.height.mas_equalTo(119.f);
        make.width.mas_equalTo(90.f);
        make.centerX.equalTo(self.view);
    }];
    
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarHeight + 20.f);
        make.right.mas_equalTo(-20.f);
    }];
    
    [self.agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountLoginBtn.mas_bottom).offset(15.f);
        make.centerX.equalTo(self.view);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(50.f);
    }];
    
    [self.otherLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(160.f);
    }];
    
    [self getAgreementTitles];
    
//    @weakify(self)
//    [WHTools hasSupportComplete:^(BOOL support, NSString * _Nonnull token) {
//        @strongify(self)
//        if (support && token.length > 0) {
//            NSLog(@"支持一键登录");
//            self.fastLoginBtn.hidden = NO;
//        } else {
//            NSLog(@"不支持一键登录");
//            self.fastLoginBtn.hidden = YES;
//        }
//    }];
    
    

}

#pragma mark -- Api
/// 获取协议标题
- (void)getAgreementTitles{
    @weakify(self)
    [WHWearTimeApi getAgreementTitlesOnSuccess:^(NSArray<WHAgreementTitleModel *> * _Nonnull titleModel) {
        @strongify(self)
        self.titleModelArr = titleModel;
    } onFailure:^(NSError * _Nonnull error) {
//        [SVProgressHUD showErrorWithStatus:error.description];
    }];
    
//    [WHWearTimeApi getAgreementTitlesWithId:1 onSuccess:^(WHAgreementTitleModel * _Nonnull titleModel) {
//        
//    } onFailure:^(NSError * _Nonnull error) {
//        
//    }];
}

#pragma mark - qmuiNavgationControllerDelegate
- (BOOL)preferredNavigationBarHidden {
    return YES;
}

#pragma mark -- Action
/// 新用户注册
- (void)newUserRegister{
    WHRegisterViewController *vc = [WHRegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

/// 本机号码一键登录
- (void)fastLoginAction{
//    [self.navigationController pushViewController:[WHPersonalViewController new] animated:YES];
    
//    [JVERIFICATIONService getAuthorizationWithController:self hide:NO animated:YES timeout:5000 completion:^(NSDictionary *result) {
//        NSLog(@"一键登录result %@",result);
//    } actionBlock:^(NSInteger type, NSString *content) {
//        NSLog(@"一键登录 actionBlock :%ld %@", (long)type , content);
//    }];
    

    
    [JVERIFICATIONService getToken:^(NSDictionary *result) {
        NSInteger code = [result[@"code"] integerValue];
        if (code == 2000){
            NSLog(@"支持一键登录");
        }
    }];
    
    
    
    // 验证当前运营商网络是否可以进行一键登录操作，该方法会缓存取号信息，提高一键登录效率。建议发起一键登录前先调用此方法。
    [JVERIFICATIONService preLogin:10*1000 completion:^(NSDictionary *result) {
            NSLog(@"登录预取号 result:%@", result);
        NSInteger code = [[NSString stringWithFormat:@"%@", result[@"code"]] integerValue];
        
        if (code == 7000) {
            NSLog(@"预取号成功");
            
        } else if (code == 7001) {
            NSLog(@"预取号失败");
        } else if (code == 7001) {
            NSLog(@"取号中");
        } else if (code == 6006) {
            NSLog(@"预取号信息过期，请重新预取号");
            [JVERIFICATIONService clearPreLoginCache]; // 清除预取号缓存
        }
    }];

    
}

/// 账号登录
- (void)accountLoginAction{
    [self.navigationController pushViewController:[WHAccountLoginViewController new] animated:YES];
}

/// 微信登录
- (void)wechatLogin{
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"com.shike.tijian";
        [WXApi sendReq:req completion:^(BOOL success) {
            NSLog(@"点击微信登录授权成功 : %@",@(success));
        }];
    } else {
        [self setupAlertController];
    }
}

#pragma mark - 设置弹出提示语
- (void)setupAlertController {

 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
 UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
 [alert addAction:actionConfirm];
 [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark --  ASAuthorizationControllerDelegate
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) API_AVAILABLE(ios(13.0)){
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]){
        // 用户登录使用ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        
//        苹果用户唯一标识符，该值在同一个开发者账号下的所有 App 下是一样的，开发者可以用该唯一标识符与自己后台系统的账号体系绑定起来。
        NSString *userID = credential.user;
        
        NSPersonNameComponents *fullName = credential.fullName;
        NSString *email = credential.email;
        
        // 服务器验证需要的参数
        NSString *authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding];
        NSString *identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
        
        // 用于判断当前登录的苹果账户是否是一个真实用户 取值有unsupported unknown likelyReal
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        
        NSLog(@"userID: %@", userID);
                NSLog(@"fullName: %@", fullName);
                NSLog(@"email: %@", email);
                NSLog(@"authorizationCode: %@", authorizationCode);
                NSLog(@"identityToken: %@", identityToken);
                NSLog(@"realUserStatus: %@", @(realUserStatus));
                
                NSString * loging = [NSString stringWithFormat:@"参数1:%@参数2:%@参数3:%@",userID,email,identityToken];
                NSLog(@"Sign in with Apple++++++++++%@",loging);
        
        /// TODO: 用token授权登录
        
        
        
        
    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        // 用户登录使用现有的密码凭证
        ASPasswordCredential *psCredential = authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString *user = psCredential.user;
        NSString *psd = psCredential.password;
        NSLog(@"psdUser - %@ %@",psd, user);
    } else {
        NSLog(@"授权信息不符");
    }
}

/// 授权失败
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    NSLog(@"apple登录错误信息 %@",error);
    NSString *errMsg;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errMsg = @"用户取消了授权请求";
            break;
            
        case ASAuthorizationErrorFailed:
            errMsg = @"授权请求失败";
            break;
            
        case ASAuthorizationErrorInvalidResponse:
            errMsg = @"授权响应请求无效";
            break;
            
        case ASAuthorizationErrorNotHandled:
            errMsg = @"未能处理授权请求";
            break;
            
        case ASAuthorizationErrorUnknown:
            errMsg = @"授权请求失败未知原因";
            break;
            
        default:
            break;
    }
}

#pragma mark -- lazy
- (QMUIButton *)registBtn{
    if (!_registBtn) {
        _registBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_registBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_registBtn setTintColor:WHBaseTextColor];
        [_registBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        [_registBtn addTarget:self action:@selector(newUserRegister) forControlEvents:UIControlEventTouchUpInside];
        _registBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _registBtn;
}

- (QMUIButton *)fastLoginBtn{
    if (!_fastLoginBtn) {
        _fastLoginBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_fastLoginBtn setTitle:@"本机号码一键登录" forState:UIControlStateNormal];
        [_fastLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fastLoginBtn setBackgroundColor:WHBaseTextColor];
        _fastLoginBtn.layer.cornerRadius = 10.f;
        _fastLoginBtn.layer.masksToBounds = YES;
        [_fastLoginBtn addTarget:self action:@selector(fastLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fastLoginBtn;
}

- (QMUIButton *)accountLoginBtn{
    if (!_accountLoginBtn) {
        _accountLoginBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_accountLoginBtn setTitle:@"账号登录" forState:UIControlStateNormal];
        [_accountLoginBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        [_accountLoginBtn setBackgroundColor:[UIColor whiteColor]];
        _accountLoginBtn.layer.cornerRadius = 15.f;
        _accountLoginBtn.layer.masksToBounds = YES;
        _accountLoginBtn.layer.borderColor = WHBaseTextColor.CGColor;
        _accountLoginBtn.layer.borderWidth = 1.f;
        [_accountLoginBtn addTarget:self action:@selector(accountLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accountLoginBtn;
}

- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
        [_logoImageView setImage:[UIImage imageNamed:@"wh_appIcon"]];
    }
    return _logoImageView;
}

- (QMUILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [QMUILabel new];
        _phoneLabel.text = @"1234567890";
        _phoneLabel.textColor = [UIColor blackColor];
        _phoneLabel.font = [UIFont boldSystemFontOfSize:24.f];
    }
    return _phoneLabel;
}

- (WHAgreementView *)agreementView {
    if (nil == _agreementView) {
        _agreementView = [WHAgreementView new];
//        _agreementView.hidden = [[MeetUserInfo sharedInfo] isReadAgreement];
        [_agreementView setDefaultOnStatus:NO];
    }
    return _agreementView;
}

- (WHOtherLoginView *)otherLoginView {
    if (nil == _otherLoginView) {
        _otherLoginView = [WHOtherLoginView new];
        @weakify(self)
        _otherLoginView.otherLoginAction = ^(OtherLoginType type) {
            @strongify(self)
            /// 苹果登录
            if (type == OtherLogin_Apple) {
                //基于用户的Apple ID授权用户，生成用户授权请求的一种机制
                
                if (@available(iOS 13.0, *)) {
                    ASAuthorizationAppleIDProvider *provider = [[ASAuthorizationAppleIDProvider alloc]init];
                        // 创建请求
                        ASAuthorizationAppleIDRequest *req = [provider createRequest];
                    // 设置请求的信息
                        req.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
                        // 创建管理授权请求的控制器
                        ASAuthorizationController *controller = [[ASAuthorizationController alloc]initWithAuthorizationRequests:@[req]];
                    // 设置代理
                        controller.delegate = self;
                        controller.presentationContextProvider = self;
                        // 发起请求
                        [controller performRequests];
                } else {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请升级手机系统到iOS13以上" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:actionConfirm];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                    
            } else if (type == OtherLogin_Wechat) {
                [self wechatLogin];
            }
        };
    }
    return _otherLoginView;
}

- (NSArray <WHAgreementTitleModel *> *)titleModelArr{
    if (!_titleModelArr) {
        _titleModelArr = [NSArray array];
    }
    return _titleModelArr;
}


@end
