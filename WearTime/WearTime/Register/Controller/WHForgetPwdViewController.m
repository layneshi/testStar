//
//  WHForgetPwdViewController.m
//  WearTime
//
//  Created by layne on 2023/7/6.
//

#import "WHForgetPwdViewController.h"
#import "WHRegisterBtn.h"
#import "WHRegisterMainView.h"
#import "WHAgreementView.h"

@interface WHForgetPwdViewController ()

@property(nonatomic, strong) WHRegisterMainView *phoneField;  // 请输入手机号
@property(nonatomic, strong) WHRegisterCodeField *codeField;  // 请输入验证码
@property(nonatomic, strong) QMUITextField *pwdField;  // 请输入密码
@property(nonatomic, strong) QMUITextField *vPwdField;  // 请验证密码
@property(nonatomic, strong) QMUIButton *applyBtn;   //  提交

@end

@implementation WHForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"忘记密码";
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.codeField];
    [self.view addSubview:self.pwdField];
    [self.view addSubview:self.vPwdField];
    [self.view addSubview:self.applyBtn];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.mas_equalTo(kNavBarHeight + 40.f);
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
}

#pragma mark -- Action
- (void)applyAction{
    if (self.phoneField.textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.codeField.textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (self.pwdField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if (![self.vPwdField.text isEqualToString:self.pwdField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
        return;
    }
    
    WHLoginModel *model = [WHLoginModel new];
    model.phone = self.phoneField.textField.text;
    model.code = self.codeField.textField.text;
    model.password = self.codeField.textField.text;
    
    [WHWearTimeApi forgetPasswordWithModel:model onSuccess:^{
        [SVProgressHUD showSuccessWithStatus:@"设置成功"];
    } onFailure:^(NSError * _Nonnull error) {
        [SVProgressHUD showSuccessWithStatus:@"设置失败"];
    }];
}

#pragma mark -- lazy
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
    }
    return _codeField;
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

@end
