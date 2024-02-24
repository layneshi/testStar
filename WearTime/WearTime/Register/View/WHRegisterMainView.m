//
//  WHRegisterMainView.m
//  WearTime
//
//  Created by layne on 2023/7/6.
//

#import "WHRegisterMainView.h"

@interface WHRegisterMainView ()

@end

@implementation WHRegisterMainView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorHex(@"#F7F8FA");
        [self addSubview:self.codeButton];
        [self addSubview:self.lineView];
        [self addSubview:self.textField];
        
        [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.mas_equalTo(16.5f);
            make.width.mas_equalTo(50.f);
            make.height.mas_equalTo(20.f);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.codeButton.mas_right).offset(5.f);
            make.width.mas_equalTo(0.5f);
            make.height.mas_equalTo(23.f);
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.lineView.mas_right).offset(5.f);
            make.right.mas_equalTo(-15.f);
            make.top.bottom.equalTo(self);
        }];
    }
    return self;
}

#pragma mark --lazy
- (QMUIButton *)codeButton{
    if (!_codeButton) {
        _codeButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_codeButton setTitle:@"+86" forState:UIControlStateNormal];
        [_codeButton setImage:[UIImage imageNamed:@"register_arrow"] forState:UIControlStateNormal];
        [_codeButton setTitleColor:ColorHex(@"#222222") forState:UIControlStateNormal];
        _codeButton.imagePosition = QMUIButtonImagePositionRight;
    }
    return _codeButton;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = ColorHex(@"#E7E7E7");
    }
    return _lineView;
}

- (QMUITextField *)textField{
    if (!_textField) {
        _textField = [QMUITextField new];
        _textField.placeholder = @"请输入手机号（必填）";
        _textField.placeholderColor = ColorHex(@"#999999");
        _textField.font = Font(15.f);
        _textField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _textField;
}

@end


@interface WHRegisterCodeField ()

@end

@implementation WHRegisterCodeField

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorHex(@"#F7F8FA");
        [self addSubview:self.sendCodeBtn];
        [self addSubview:self.textField];
        
        [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.mas_equalTo(-16.5f);
            make.width.mas_equalTo(70.f);
            make.height.mas_equalTo(15.f);
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.sendCodeBtn.mas_left).offset(-5.f);
            make.left.mas_equalTo(16.5f);
            make.top.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)sendCode:(UIButton *)btn{
    if (self.getPhoneCodeAction) {
        self.getPhoneCodeAction();
    }
}

#pragma mark --lazy
- (QMUIButton *)sendCodeBtn{
    if (!_sendCodeBtn) {
        _sendCodeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//        [_sendCodeBtn setImage:[UIImage imageNamed:@"register_arrow"] forState:UIControlStateNormal];
        [_sendCodeBtn setTitleColor:ColorHex(@"#3478F3") forState:UIControlStateNormal];
        _sendCodeBtn.titleLabel.font = Font(13.f);
        [_sendCodeBtn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendCodeBtn;
}

- (QMUITextField *)textField{
    if (!_textField) {
        _textField = [QMUITextField new];
        _textField.placeholder = @"请输入验证码（必填）";
        _textField.placeholderColor = ColorHex(@"#999999");
        _textField.font = Font(15.f);
        _textField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _textField;
}

@end
