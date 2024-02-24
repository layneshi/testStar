//
//  WHTipsView.m
//  WearTime
//
//  Created by layne on 2023/7/6.
//

#import "WHTipsView.h"


@interface WHTipsView ()

@property(nonatomic, strong) QMUILabel *titleLabel;
@property(nonatomic, strong) QMUIButton *closeBtn;
@property(nonatomic, strong) QMUILabel *detailLabel;

@property(nonatomic, strong) QMUIButton *agreementBtn;
@property(nonatomic, strong) QMUIButton *policyBtn;
@property(nonatomic, strong) QMUIButton *termBtn;
@property(nonatomic, strong) QMUIButton *agreeBtn;


@end

@implementation WHTipsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.closeBtn];
        [self addSubview:self.detailLabel];
        [self addSubview:self.agreementBtn];
        [self addSubview:self.policyBtn];
        [self addSubview:self.termBtn];
        [self addSubview:self.agreeBtn];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_equalTo(24.5f);
//            make.width.mas_equalTo(100.f);
//            make.height.mas_equalTo(40.f);
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-17.f);
            make.width.height.mas_equalTo(20.5);
            make.centerY.equalTo(self.titleLabel);
        }];
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18.f);
            make.right.mas_equalTo(-20.5f);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(20.f);
        }];
        
        [self.agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18.f);
            make.right.mas_equalTo(-20.5f);
            make.top.equalTo(self.detailLabel.mas_bottom).offset(24.5f);
            make.height.mas_equalTo(15.f);
        }];
        
        [self.policyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18.f);
            make.right.mas_equalTo(-20.5f);
            make.top.equalTo(self.agreementBtn.mas_bottom).offset(17.f);
            make.height.mas_equalTo(15.f);
        }];
        
        [self.termBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18.f);
            make.right.mas_equalTo(-20.5f);
            make.top.equalTo(self.policyBtn.mas_bottom).offset(17.f);
            make.height.mas_equalTo(15.f);
        }];
        
        [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(17.5f);
            make.right.mas_equalTo(-17.5f);
            make.top.equalTo(self.termBtn.mas_bottom).offset(23.5f);
            make.height.mas_equalTo(41.f);
        }];
        
        
    }
    return self;
}

#pragma mark -- Action
- (void)agreeAction{
    if (self.clickAgreeAction) {
        self.clickAgreeAction();
    }
}

- (void)policeAction:(QMUIButton *)btn{
    
    if (self.clickTypeAction) {
        self.clickTypeAction(btn.tag);
    }
}

- (void)closeAction{
    if (self.clickCloseAction) {
        self.clickCloseAction();
    }
}

#pragma mark -- lazy
- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QMUILabel new];
        _titleLabel.font = Font(18.f);
        _titleLabel.textColor = ColorHex(@"#222222");
        _titleLabel.text = @"提示";
    }
    return _titleLabel;
}

- (QMUIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"tip_close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (QMUILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [QMUILabel new];
        _detailLabel.font = Font(15.f);
        _detailLabel.textColor = ColorHex(@"#222222");
        _detailLabel.numberOfLines = 0;
        _detailLabel.text = @"在您成为我们会员前，您需要先同意我们的服务协议和隐私条款；请仔细阅读协议，充分理解协议内容后单击“同意并继续”";
    }
    return _detailLabel;
}

- (QMUIButton *)agreementBtn{
    if (!_agreementBtn) {
        _agreementBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_agreementBtn setTitle:@"《时刻体检用户协议》" forState:UIControlStateNormal];
        [_agreementBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        _agreementBtn.titleLabel.font = Font(15.f);
        _agreementBtn.tag = WHLoginTi_Agreement;
        [_agreementBtn addTarget:self action:@selector(policeAction:) forControlEvents:UIControlEventTouchUpInside];
        _agreementBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _agreementBtn;
}

- (QMUIButton *)policyBtn{
    if (!_policyBtn) {
        _policyBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_policyBtn setTitle:@"《时刻体检隐私政策》" forState:UIControlStateNormal];
        [_policyBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        _policyBtn.titleLabel.font = Font(15.f);
        _policyBtn.tag = WHLoginTi_Polic;
        [_policyBtn addTarget:self action:@selector(policeAction:) forControlEvents:UIControlEventTouchUpInside];
        _policyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _policyBtn;
}

- (QMUIButton *)termBtn{
    if (!_termBtn) {
        _termBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_termBtn setTitle:@"《中国移动认证服务条款》》" forState:UIControlStateNormal];
        [_termBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        _termBtn.titleLabel.font = Font(15.f);
        _termBtn.tag = WHLoginTi_Term;
        [_termBtn addTarget:self action:@selector(policeAction:) forControlEvents:UIControlEventTouchUpInside];
        _termBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _termBtn;
}

- (QMUIButton *)agreeBtn{
    if (!_agreeBtn) {
        _agreeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_agreeBtn setTitle:@"同意并继续" forState:UIControlStateNormal];
        [_agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_agreeBtn setBackgroundColor:WHBaseTextColor];
        _agreeBtn.layer.cornerRadius = 10.f;
        _agreeBtn.layer.masksToBounds = YES;
        [_agreeBtn addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeBtn;
}

@end
