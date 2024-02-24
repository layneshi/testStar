//
//  WHCodeLoginViewController.m
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#import "WHCodeLoginViewController.h"
#import "WHRegisterViewController.h"
#import "WHForgetPwdViewController.h"
#import "WHAgreementView.h"
#import "WHPersonalViewController.h"
#import "WHAccountLoginViewController.h"
#import "WHRegisterMainView.h"


@interface WHCodeLoginViewController ()

@property(nonatomic, strong) QMUILabel *titleLabel;

@property(nonatomic, strong) QMUIButton *loginBtn;
@property(nonatomic, strong) QMUIButton *codeBtn;
@property(nonatomic, strong) WHAgreementView *agreementView;


@property(nonatomic, strong) WHRegisterMainView *phoneField;  // 请输入手机号
@property(nonatomic, strong) WHRegisterCodeField *codeField;  // 请输入验证码

@end

@implementation WHCodeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.codeField];
    
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.codeBtn];
    [self.view addSubview:self.agreementView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.top.mas_equalTo(kNavBarHeight + 30.f);
    }];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.phoneField.mas_bottom).offset(20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.equalTo(self.codeField.mas_bottom).offset(20.f);
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
- (void)loginAction{
    
    WHLoginModel *model = [WHLoginModel new];
    model.phone = self.phoneField.textField.text;
    model.password = self.codeField.textField.text;
    model.loginType = [NSString stringWithFormat:@"%lu",(unsigned long)WHLoginType_Account];
    @weakify(self)
    [WHWearTimeApi loginWithModel:model onSuccess:^(NSString * _Nonnull token) {
        @strongify(self)
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:WHUserToken];
        [self.navigationController pushViewController:[WHPersonalViewController new] animated:YES];
    } onFailure:^(NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
    }];
}

// 账号登录
- (void)accountLoginAction{
    [self.navigationController pushViewController:[WHAccountLoginViewController new] animated:YES];
}

- (void)sendCode{
    if (self.phoneField.textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    [WHWearTimeApi sendPhoneCodeWithPhone:self.phoneField.textField.text type:[NSString stringWithFormat:@"%lu",(unsigned long)WHSendMsmType_Login] onSuccess:^{
        
    } onFailure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -- lazy
- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QMUILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:21.f];
        _titleLabel.textColor = ColorHex(@"#222222");
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"账号登录" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 21],NSForegroundColorAttributeName: ColorHex(@"#222222")}];
        _titleLabel.text = @"验证码登录";
    }
    return _titleLabel;
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
        [_codeBtn setTitle:@"账号登录" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        [_codeBtn setBackgroundColor:[UIColor whiteColor]];
        _codeBtn.layer.cornerRadius = 15.f;
        _codeBtn.layer.masksToBounds = YES;
        _codeBtn.layer.borderColor = WHBaseTextColor.CGColor;
        _codeBtn.layer.borderWidth = 1.f;
        [_codeBtn addTarget:self action:@selector(accountLoginAction) forControlEvents:UIControlEventTouchUpInside];
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
