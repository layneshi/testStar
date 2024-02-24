//
//  WHRegisterBtn.m
//  WearTime
//
//  Created by layne on 2023/7/6.
//

#import "WHRegisterBtn.h"

@interface WHRegisterBtn ()

@property(nonatomic, strong) QMUILabel *mLabel;
@property(nonatomic, strong) UIView *lineView;


@end

@implementation WHRegisterBtn

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mLabel];
        [self addSubview:self.lineView];
        
        [self.mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.top.equalTo(self.mLabel.mas_bottom).offset(5.f);
            make.width.mas_equalTo(26.f);
            make.height.mas_equalTo(4.f);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setBtnTitle:(NSString *)title{
    self.mLabel.text = title;
}

- (void)changeBtnStatus:(BOOL)isSelect{
    self.mLabel.font = isSelect ? Font(20.f) : Font(16.f);
    self.mLabel.textColor = isSelect ? ColorHex(@"#3478F3") : ColorHex(@"#666666");
    self.lineView.hidden = !isSelect;
}

- (void)tapView:(UITapGestureRecognizer *)tap{
    if (self.clickBtn) {
        self.clickBtn();
    }
}

#pragma mark -- lazy
- (QMUILabel *)mLabel{
    if (!_mLabel) {
        _mLabel = [QMUILabel new];
        _mLabel.font = Font(16.f);
        _mLabel.textColor = ColorHex(@"#666666");
    }
    return _mLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = WHBaseTextColor;
    }
    return _lineView;
}

@end
