//
//  WHAccountLoginViewController.m
//  WearTime
//
//  Created by layne on 2023/7/6.
//

#import "WHAccountLoginViewController.h"
#import "WHRegisterViewController.h"
#import "WHForgetPwdViewController.h"
#import "WHAgreementView.h"
#import "WHPersonalViewController.h"
#import "WHCodeLoginViewController.h"

@interface WHAccountLoginViewController ()

@property(nonatomic, strong) QMUILabel *titleLabel;
@property(nonatomic, strong) QMUITextField *accountField;
@property(nonatomic, strong) QMUITextField *pwdField;
@property(nonatomic, strong) QMUIButton *registerBtn;
@property(nonatomic, strong) QMUIButton *forgetPwdBtn;

@property(nonatomic, strong) QMUIButton *loginBtn;
@property(nonatomic, strong) QMUIButton *codeBtn;
@property(nonatomic, strong) WHAgreementView *agreementView;

@end

@implementation WHAccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.pwdField];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.forgetPwdBtn];
    
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.codeBtn];
    [self.view addSubview:self.agreementView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.top.mas_equalTo(kNavBarHeight + 30.f);
    }];
    
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.accountField.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.top.equalTo(self.pwdField.mas_bottom).offset(15.f);
        make.width.mas_equalTo(40.f);
        make.height.mas_equalTo(13.f);
    }];
    
    [self.forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.pwdField.mas_bottom).offset(15.f);
        make.width.mas_equalTo(60.f);
        make.height.mas_equalTo(13.f);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.forgetPwdBtn.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeBtn.mas_bottom).offset(15.f);
        make.centerX.equalTo(self.view);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(50.f);
    }];
    
}

#pragma mark -- Action
- (void)newUserRegister{
    [self.navigationController pushViewController:[WHRegisterViewController new] animated:YES];
}

- (void)forgetPwdAction{
    [self.navigationController pushViewController:[WHForgetPwdViewController new] animated:YES];
}

- (void)loginAction{
    
    [self.navigationController pushViewController:[WHPersonalViewController new] animated:YES];
    
    
    
//    WHLoginModel *model = [WHLoginModel new];
//    model.username = self.accountField.text;
//    model.password = self.pwdField.text;
//    model.loginType = [NSString stringWithFormat:@"%lu",(unsigned long)WHLoginType_Account];
//    @weakify(self)
//    [WHWearTimeApi loginWithModel:model onSuccess:^(NSString * _Nonnull token) {
//        @strongify(self)
//        [[NSUserDefaults standardUserDefaults] setObject:token forKey:WHUserToken];
//        [self.navigationController pushViewController:[WHPersonalViewController new] animated:YES];
//        [self getUseInfo];
//
//    } onFailure:^(NSError * _Nonnull error) {
//        [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
//    }];
}

// 验证码登录
- (void)coceLoginAction{
    [self.navigationController pushViewController:[WHCodeLoginViewController new] animated:YES];
}

- (void)getUseInfo{
    [WHWearTimeApi getUserInfoWithTokenOnSuccess:^(WHUserModel * _Nonnull userModel) {
        [[WHUserInfo sharedInfo] saveUserInfoWithModel:userModel];
    } onFailure:^(NSError * _Nonnull error) {
//        [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
    }];
}

#pragma mark -- lazy
- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QMUILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:21.f];
        _titleLabel.textColor = ColorHex(@"#222222");
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"账号登录" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 21],NSForegroundColorAttributeName: ColorHex(@"#222222")}];
        _titleLabel.text = @"账号登录";
    }
    return _titleLabel;
}

- (QMUITextField *)accountField{
    if (!_accountField) {
        _accountField = [QMUITextField new];
        _accountField.layer.cornerRadius = 10.f;
        _accountField.placeholder = @"请输入账号（必填）";
        _accountField.backgroundColor = ColorHex(@"#F7F8FA");
        _accountField.placeholderColor = ColorHex(@"#999999");
        _accountField.textInsets = UIEdgeInsetsMake(0.f, 16.5f, 0.f, 0.f);
        _accountField.font = Font(15.f);
        _accountField.text = @"iostest";
    }
    return _accountField;
}

- (QMUITextField *)pwdField{
    if (!_pwdField) {
        _pwdField = [QMUITextField new];
        _pwdField.layer.cornerRadius = 10.f;
        _pwdField.placeholder = @"请输入密码";
        _pwdField.backgroundColor = ColorHex(@"#F7F8FA");
        _pwdField.placeholderColor = ColorHex(@"#999999");
        _pwdField.textInsets = UIEdgeInsetsMake(0.f, 16.5f, 0.f, 0.f);
        _pwdField.font = Font(15.f);
        _pwdField.secureTextEntry = YES;
        _pwdField.text = @"123456";
    }
    return _pwdField;
}

- (QMUIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"去注册" forState:UIControlStateNormal];
        [_registerBtn setTintColor:WHBaseTextColor];
        [_registerBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(newUserRegister) forControlEvents:UIControlEventTouchUpInside];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    }
    return _registerBtn;
}

- (QMUIButton *)forgetPwdBtn{
    if (!_forgetPwdBtn) {
        _forgetPwdBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPwdBtn setTintColor:WHBaseTextColor];
        [_forgetPwdBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        [_forgetPwdBtn addTarget:self action:@selector(forgetPwdAction) forControlEvents:UIControlEventTouchUpInside];
        _forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    }
    return _forgetPwdBtn;
}

- (QMUIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:WHBaseTextColor];
        _loginBtn.layer.cornerRadius = 10.f;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (QMUIButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_codeBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        [_codeBtn setBackgroundColor:[UIColor whiteColor]];
        _codeBtn.layer.cornerRadius = 15.f;
        _codeBtn.layer.masksToBounds = YES;
        _codeBtn.layer.borderColor = WHBaseTextColor.CGColor;
        _codeBtn.layer.borderWidth = 1.f;
        [_codeBtn addTarget:self action:@selector(coceLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}

- (WHAgreementView *)agreementView {
    if (nil == _agreementView) {
        _agreementView = [WHAgreementView new];
//        _agreementView.hidden = [[MeetUserInfo sharedInfo] isReadAgreement];
        [_agreementView setDefaultOnStatus:NO];
    }
    return _agreementView;
}

@end
