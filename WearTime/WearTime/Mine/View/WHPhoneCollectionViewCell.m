//
//  WHPhoneCollectionViewCell.m
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import "WHPhoneCollectionViewCell.h"

@implementation WHPhoneCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        [self addSubview:self.mBtn1];
        [self.mBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(80.f);
            make.height.mas_equalTo(40.f);
        }];
    }
    return self;
}

- (void)clickBtnAction{
    if (self.pressNumBtn) {
        self.pressNumBtn();
    }
}


#pragma mark --lazy
- (QMUIButton *)mBtn1{
    if (!_mBtn1) {
        _mBtn1 = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_mBtn1 setBackgroundColor:ColorHex(@"#e9e9eb")];
        [_mBtn1 setTitle:@"1" forState:UIControlStateNormal];
        [_mBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _mBtn1.titleLabel.font = Font(14.f);
        _mBtn1.layer.cornerRadius = 5;
        _mBtn1.userInteractionEnabled = YES;
        [_mBtn1 addTarget:self action:@selector(clickBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mBtn1;
}

@end
