//
//  WHRegisterViewController.m
//  WearTime
//
//  Created by layne on 2023/7/6.
//

#import "WHRegisterViewController.h"
#import "WHRegisterBtn.h"
#import "WHRegisterMainView.h"
#import "WHAgreementView.h"
#import "WHLoginViewController.h"

@interface WHRegisterViewController ()

@property(nonatomic, strong) WHRegisterBtn *phoneBtn;
@property(nonatomic, strong) WHRegisterBtn *accountBtn;

@property(nonatomic, strong) WHRegisterMainView *phoneField;  // 请输入手机号
@property(nonatomic, strong) WHRegisterCodeField *codeField;  // 请输入验证码
@property(nonatomic, strong) QMUITextField *accountField;  // 请输入账号
@property(nonatomic, strong) QMUITextField *pwdField;  // 请输入密码
@property(nonatomic, strong) QMUITextField *vPwdField;  // 请验证密码

@property(nonatomic, strong) QMUIButton *applyBtn;   //  提交
@property(nonatomic, strong) WHAgreementView *agreementView;

@property(nonatomic, assign) BOOL isPhoneRegister;   // 是否手机注册


@end

@implementation WHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.phoneBtn];
    [self.view addSubview:self.accountBtn];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.codeField];
    [self.view addSubview:self.pwdField];
    [self.view addSubview:self.vPwdField];
    [self.view addSubview:self.applyBtn];
    [self.view addSubview:self.agreementView];
    [self.view addSubview:self.accountField];
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.width.mas_equalTo(100.f);
        make.top.mas_equalTo(kNavBarHeight + 30.f);
    }];
    
    [self.accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneBtn.mas_right).offset(40.f);
        make.width.mas_equalTo(100.f);
        make.top.mas_equalTo(kNavBarHeight + 30.f);
    }];
    
    [self setPhoneRegister];
    
}

#pragma mark -- Action
- (void)applyAction{
    
    self.accountField.text = @"iostest";
    self.pwdField.text = @"123456";
    self.vPwdField.text = @"123456";
    
    
    if (self.pwdField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if (![self.vPwdField.text isEqualToString:self.pwdField.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致"];
        return;
    }

    WHLoginModel *loginModel = [WHLoginModel new];
    if (self.isPhoneRegister) {
        if (self.phoneField.textField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
            return;
        }
        
        if (self.codeField.textField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
            return;
        }
        
        loginModel.code = self.codeField.textField.text;
        loginModel.phone = self.phoneField.textField.text;
        
    } else {
        if (self.accountField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入账号"];
            return;
        }
    
        loginModel.username = self.accountField.text;
        loginModel.password = self.pwdField.text;
    }
    
    
    NSLog(@"注册数据 %@",[loginModel sl_modelToJSONString]);
    
    [WHWearTimeApi userRegisterWithModel:loginModel onSuccess:^{
        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        // 回到登录界面
        [self backLoginViewController];
    } onFailure:^(NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
    }];
}

- (void)sendCode{
    [WHWearTimeApi sendPhoneCodeWithPhone:self.phoneField.textField.text type:[NSString stringWithFormat:@"%lu",(unsigned long)WHSendMsmType_Register] onSuccess:^{
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
    } onFailure:^(NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    }];
}


- (void)backLoginViewController{
    UIViewController *rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootController isKindOfClass:[WHBaseNavigationViewController class]]) {
        WHBaseNavigationViewController *navController = (WHBaseNavigationViewController *)rootController;
        if ([navController.topViewController isKindOfClass:[WHLoginViewController class]]) {
            return;
        }
    }
    
    WHLoginViewController *viewController = [WHLoginViewController new];
//    viewController.isChangePwd = YES;
    WHBaseNavigationViewController *loginNavController = [[WHBaseNavigationViewController alloc] initWithRootViewController:viewController];
    [UIApplication sharedApplication].delegate.window.rootViewController = loginNavController;
        [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}

- (void)changeRegisterMode:(BOOL)isPhone{
    [self.view removeAllSubviews];
    self.isPhoneRegister = isPhone;
    if (isPhone) {
        [self.view addSubview:self.phoneBtn];
        [self.view addSubview:self.accountBtn];
        [self.view addSubview:self.phoneField];
        [self.view addSubview:self.codeField];
        [self.view addSubview:self.pwdField];
        [self.view addSubview:self.vPwdField];
        [self.view addSubview:self.applyBtn];
        [self.view addSubview:self.agreementView];
        [self setPhoneRegister];
    } else {
        [self.view addSubview:self.phoneBtn];
        [self.view addSubview:self.accountBtn];
//        [self.view addSubview:self.phoneField];
//        [self.view addSubview:self.codeField];
        [self.view addSubview:self.pwdField];
        [self.view addSubview:self.vPwdField];
        [self.view addSubview:self.applyBtn];
        [self.view addSubview:self.agreementView];
        [self.view addSubview:self.accountField];
        [self setAccountRegister];
    }
}


- (void)setPhoneRegister{
//    self.accountField.hidden = YES;
//    self.phoneField.hidden = NO;
//    self.codeField.hidden = NO;
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.width.mas_equalTo(100.f);
        make.top.mas_equalTo(kNavBarHeight + 30.f);
    }];
    
    [self.accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneBtn.mas_right).offset(40.f);
        make.width.mas_equalTo(100.f);
        make.top.mas_equalTo(kNavBarHeight + 30.f);
    }];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.phoneBtn.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.phoneField.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.codeField.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.vPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.pwdField.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.vPwdField.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.applyBtn.mas_bottom).offset(15.f);
        make.centerX.equalTo(self.view);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(50.f);
    }];
}

- (void)setAccountRegister{
//    self.accountField.hidden = NO;
//    self.phoneField.hidden = YES;
//    self.codeField.hidden = YES;
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.width.mas_equalTo(100.f);
        make.top.mas_equalTo(kNavBarHeight + 30.f);
    }];
    
    [self.accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneBtn.mas_right).offset(40.f);
        make.width.mas_equalTo(100.f);
        make.top.mas_equalTo(kNavBarHeight + 30.f);
    }];
    
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.phoneBtn.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.accountField.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.vPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.pwdField.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.vPwdField.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.applyBtn.mas_bottom).offset(15.f);
        make.centerX.equalTo(self.view);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(50.f);
    }];
}

#pragma mark -- lazy
- (WHRegisterBtn *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [WHRegisterBtn new];
        [_phoneBtn setBtnTitle:@"手机号注册"];
        [_phoneBtn changeBtnStatus:YES];
        @weakify(self)
        _phoneBtn.clickBtn = ^{
            @strongify(self)
            [self.phoneBtn changeBtnStatus:YES];
            [self.accountBtn changeBtnStatus:NO];
            [self changeRegisterMode:YES];
        };
    }
    return _phoneBtn;
}
- (WHRegisterBtn *)accountBtn{
    if (!_accountBtn) {
        _accountBtn = [WHRegisterBtn new];
        [_accountBtn setBtnTitle:@"账号密码注册"];
        [_accountBtn changeBtnStatus:NO];
        @weakify(self)
        _accountBtn.clickBtn = ^{
            @strongify(self)
            [self.accountBtn changeBtnStatus:YES];
            [self.phoneBtn changeBtnStatus:NO];
            [self changeRegisterMode:NO];
        };
    }
    return _accountBtn;
}

- (WHRegisterMainView *)phoneField{
    if (!_phoneField) {
        _phoneField = [WHRegisterMainView new];
        _phoneField.layer.cornerRadius = 10.f;
    }
    return _phoneField;
}

- (WHRegisterCodeField *)codeField{
    if (!_codeField) {
        _codeField = [WHRegisterCodeField new];
        _codeField.layer.cornerRadius = 10.f;
        @weakify(self)
        _codeField.getPhoneCodeAction = ^{
            @strongify(self)
            [self sendCode];
        };
    }
    return _codeField;
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
    }
    return _pwdField;
}

- (QMUITextField *)vPwdField{
    if (!_vPwdField) {
        _vPwdField = [QMUITextField new];
        _vPwdField.layer.cornerRadius = 10.f;
        _vPwdField.placeholder = @"请再次输入密码";
        _vPwdField.backgroundColor = ColorHex(@"#F7F8FA");
        _vPwdField.placeholderColor = ColorHex(@"#999999");
        _vPwdField.textInsets = UIEdgeInsetsMake(0.f, 16.5f, 0.f, 0.f);
        _vPwdField.font = Font(15.f);
        _vPwdField.secureTextEntry = YES;
    }
    return _vPwdField;
}

- (QMUIButton *)applyBtn{
    if (!_applyBtn) {
        _applyBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_applyBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_applyBtn setBackgroundColor:WHBaseTextColor];
        _applyBtn.layer.cornerRadius = 10.f;
        _applyBtn.layer.masksToBounds = YES;
        [_applyBtn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyBtn;
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
