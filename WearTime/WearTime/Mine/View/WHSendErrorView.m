//
//  WHSendErrorView.m
//  WearTime
//
//  Created by layne on 2023/7/15.
//

#import "WHSendErrorView.h"

@interface WHSendErrorView ()

@property(nonatomic, strong) WHErrorTipsView *tipView;

@end

@implementation WHSendErrorView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ColorHex(@"#666666") colorWithAlphaComponent:0.5];
        
        [self addSubview:self.tipView];
        [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.left.mas_equalTo(25.f);
            make.right.mas_equalTo(-25.f);
            make.height.mas_equalTo(180.f);
        }];
    }
    return self;
}

- (WHErrorTipsView *)tipView{
    if (!_tipView) {
        _tipView = [WHErrorTipsView new];
        _tipView.layer.cornerRadius = 16.f;
        @weakify(self)
        _tipView.pressBtnAction = ^(NSInteger type) {
            @strongify(self)
            if (self.pressBtnAction) {
                self.pressBtnAction(type);
            }
        };
    }
    return _tipView;
}

@end




@interface WHErrorTipsView ()

@property(nonatomic, strong) QMUILabel *warningLabel;
@property(nonatomic, strong) QMUIButton *continueBtn;
@property(nonatomic, strong) QMUIButton *notUseBtn;

@end

@implementation WHErrorTipsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.warningLabel];
        [self addSubview:self.continueBtn];
        [self addSubview:self.notUseBtn];
        
        [self.warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_equalTo(45.f);
            make.left.mas_equalTo(22.5f);
            make.right.mas_equalTo(-23.f);
        }];
        
        [self.continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.warningLabel.mas_bottom).offset(20.f);
            make.right.equalTo(self.mas_centerX).offset(-5.f);
            make.width.mas_equalTo(140.f);
            make.height.mas_equalTo(40.f);
            make.bottom.mas_equalTo(-20.f);
        }];
        
        [self.notUseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.warningLabel.mas_bottom).offset(20.f);
            make.left.equalTo(self.mas_centerX).offset(5.f);
            make.width.mas_equalTo(140.f);
            make.height.mas_equalTo(40.f);
            make.bottom.mas_equalTo(-20.f);
        }];
        
    }
    return self;
}

#pragma mark -- Action
- (void)continueAction{
    if (self.pressBtnAction) {
        self.pressBtnAction(WHBtnPressType_Continue);
    }
}

- (void)notUseAction{
    if (self.pressBtnAction) {
        self.pressBtnAction(WHBtnPressType_NotYet);
    }
}


#pragma mark -- lazy
- (QMUILabel *)warningLabel{
    if (!_warningLabel){
        _warningLabel = [QMUILabel new];
        _warningLabel.text = @"接收人至少填写一位，如您未填写，“时刻体检”将无法正常使用!";
        _warningLabel.font = Font(15.f);
        _warningLabel.textColor = ColorHex(@"#222222");
        _warningLabel.numberOfLines = 0;
    }
    return _warningLabel;
}

- (QMUIButton *)continueBtn{
    if (!_continueBtn) {
        _continueBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_continueBtn setTitle:@"继续填写" forState:UIControlStateNormal];
        [_continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_continueBtn setBackgroundColor:WHBaseTextColor];
        _continueBtn.layer.cornerRadius = 10.f;
        _continueBtn.titleLabel.font = Font(13.f);
        _continueBtn.layer.masksToBounds = YES;
        [_continueBtn addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _continueBtn;
}


- (QMUIButton *)notUseBtn{
    if (!_notUseBtn) {
        _notUseBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_notUseBtn setTitle:@"暂时不用" forState:UIControlStateNormal];
        [_notUseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_notUseBtn setBackgroundColor:WHBaseTextColor];
        _notUseBtn.layer.cornerRadius = 10.f;
        _notUseBtn.titleLabel.font = Font(13.f);
        _notUseBtn.layer.masksToBounds = YES;
        [_notUseBtn addTarget:self action:@selector(notUseAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _notUseBtn;
}



@end
