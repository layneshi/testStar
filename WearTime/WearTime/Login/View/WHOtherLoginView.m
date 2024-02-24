//
//  WHOtherLoginView.m
//  WearTime
//
//  Created by layne on 2023/7/5.
//

#import "WHOtherLoginView.h"

@interface WHOtherLoginView ()

@property(nonatomic, strong) QMUILabel *mLabel;
@property(nonatomic, strong) QMUIButton *wechatBtn;
@property(nonatomic, strong) QMUIButton *appleBtn;


@end

@implementation WHOtherLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    UIView *line1 = [UIView new];
    line1.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    UIView *line2 = [UIView new];
    line2.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    
    [self addSubview:self.mLabel];
    [self addSubview:self.wechatBtn];
    [self addSubview:self.appleBtn];
    [self addSubview:line1];
    [self addSubview:line2];
    
    [self.mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(5.f);
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mLabel.mas_left).offset(-10.f);
        make.width.mas_equalTo(90.f);
        make.height.mas_equalTo(0.5f);
        make.centerY.equalTo(self.mLabel.mas_centerY);
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mLabel.mas_right).offset(10.f);
        make.width.mas_equalTo(90.f);
        make.height.mas_equalTo(0.5f);
        make.centerY.equalTo(self.mLabel.mas_centerY);
    }];
    
    [self.wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line1.mas_right);
        make.width.height.mas_equalTo(40.f);
        make.top.equalTo(self.mLabel.mas_bottom).offset(32.f);
    }];
    
    [self.appleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2.mas_left);
        make.width.height.mas_equalTo(40.f);
        make.top.equalTo(self.mLabel.mas_bottom).offset(32.f);
    }];
}

#pragma mark -- Action
- (void)selectWechat{
    if (self.otherLoginAction) {
        self.otherLoginAction(OtherLogin_Wechat);
    }
}

- (void)selectApple{
    if (self.otherLoginAction) {
        self.otherLoginAction(OtherLogin_Apple);
    }
}


#pragma mark -- lazy
- (QMUILabel *)mLabel{
    if (!_mLabel) {
        _mLabel = [QMUILabel new];
        _mLabel.font = [UIFont systemFontOfSize:13];
        _mLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _mLabel.text = @"其他方式登录";
    }
    return _mLabel;
}

- (QMUIButton *)wechatBtn{
    if (!_wechatBtn) {
        _wechatBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        // 微信
        [_wechatBtn setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
        [_wechatBtn addTarget:self action:@selector(selectWechat) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatBtn;
}

- (QMUIButton *)appleBtn{
    if (!_appleBtn) {
        _appleBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_appleBtn setImage:[UIImage imageNamed:@"苹果ID"] forState:UIControlStateNormal];
        [_appleBtn addTarget:self action:@selector(selectApple) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appleBtn;
}

@end
