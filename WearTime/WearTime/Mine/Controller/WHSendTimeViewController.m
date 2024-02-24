//
//  WHSendTimeViewController.m
//  WearTime
//
//  Created by layne on 2023/7/9.
//

#import "WHSendTimeViewController.h"
#import "WHSelectSendTimeView.h"
#import "WHPersonalViewController.h"

@interface WHSendTimeViewController ()

@property(nonatomic, strong) WHSendHeadView *headView;
@property(nonatomic, strong) WHSendSelectView *seleceView;
@property(nonatomic, strong) QMUIButton *confirmBtn;

@property(nonatomic, strong) WHSelectSendTimeView *selectTimeView;
@property(nonatomic, strong) WHSendTimeModel *timeModel;
@property(nonatomic, strong) NSString *showStr;

@end

@implementation WHSendTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"体检报告发送时间";
    self.view.backgroundColor = ColorHex(@"#F2F1F6");
    [self.view addSubview:self.headView];
    [self.view addSubview:self.confirmBtn];
    [self.view addSubview:self.seleceView];
    [self.view addSubview:self.selectTimeView];

    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(50.f);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.bottom.mas_equalTo(-50);
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarHeight + 30.f);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.height.mas_equalTo(85.f);
    }];
    
    [self.seleceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).offset(17.5f);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.height.mas_equalTo(50.f);
    }];
    
    [self.selectTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seleceView.mas_bottom).offset(0.5f);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.height.mas_equalTo(270.f);
    }];
}

#pragma mark -- action
/// 完成
- (void)confirmAction{
    if (self.showStr.length == 0) return;
    
    [WHWearTimeApi scheduledReportWithModel:self.timeModel onSuccess:^{
        // 完成进入个人中心界面
        [self.navigationController pushViewController:[WHPersonalViewController new] animated:YES];
    } onFailure:^(NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"设置失败"];
    }];
}

// 选择时间控制器
- (void)clickTimeController{
    
}


- (void)updateWHSendSelectViewWithStr:(NSString *)title{
    [self.seleceView updateTitleWithStr:title];
}

#pragma mark -- Api


#pragma mark -- lazy
- (QMUIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:WHBaseTextColor];
        _confirmBtn.layer.cornerRadius = 10.f;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (WHSendHeadView *)headView{
    if (!_headView) {
        _headView = [WHSendHeadView new];
        _headView.layer.cornerRadius = 10.f;
    }
    return _headView;
}

- (WHSendSelectView *)seleceView{
    if (!_seleceView) {
        _seleceView = [WHSendSelectView new];
        _seleceView.layer.cornerRadius = 10.f;
        @weakify(self)
        _seleceView.selectTimeBlock = ^{
            @strongify(self)
            [self clickTimeController];
        };
    }
    return _seleceView;
}


- (WHSelectSendTimeView *)selectTimeView{
    if (!_selectTimeView) {
        _selectTimeView = [WHSelectSendTimeView new];
        _selectTimeView.layer.cornerRadius = 10.f;
        @weakify(self)
        _selectTimeView.blockPickView = ^(NSString * _Nonnull showString, WHSendTimeModel * _Nonnull timeModel) {
            @strongify(self)
            // 更新WHSendSelectView 的文字
            [self updateWHSendSelectViewWithStr:showString];
            self.timeModel = timeModel;
            self.showStr = showString;
        };
    }
    return _selectTimeView;
}


@end




@interface WHSendHeadView ()

@property(nonatomic, strong) QMUILabel *titleLabel;

@property(nonatomic, strong) QMUILabel *label1;

@property(nonatomic, strong) QMUIButton *mImageBtn;

@property(nonatomic, strong) QMUILabel *label2;

@end

@implementation WHSendHeadView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.label1];
        [self addSubview:self.label2];
        [self addSubview:self.mImageBtn];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18.f);
            make.top.mas_equalTo(17.f);
//            make.width.mas_lessThanOrEqualTo(200.f);
        }];
        
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(17.f);
            make.left.mas_equalTo(18.f);
        }];
        
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(17.f);
            make.right.mas_equalTo(-18.f);
        }];
        
        [self.mImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.label1.mas_right).offset(5.f);
            make.right.equalTo(self.label2.mas_left).offset(-5.f);
            make.width.height.mas_equalTo(80.f);
            make.centerY.equalTo(self.label1);
        }];
        
    }
    return self;
}



#pragma mark -- lazy
- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QMUILabel new];
        _titleLabel.font = Font(16.f);
        _titleLabel.text = @"手动发送方法:";
        _titleLabel.textColor = ColorHex(@"#111111");
    }
    return _titleLabel;
}

- (QMUILabel *)label1{
    if (!_label1) {
        _label1 = [QMUILabel new];
        _label1.font = Font(14.f);
        _label1.text = [NSString stringWithFormat:@"%@%@%@",@"打开",@"“时刻体检”",@"单击按钮"];
        _label1.textColor = ColorHex(@"#333333");
    }
    return _label1;
}

- (QMUIButton *)mImageBtn{
    if (!_mImageBtn) {
        _mImageBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_mImageBtn setTitle:@"手动发送报告" forState:UIControlStateNormal];
        [_mImageBtn setImage:[UIImage imageNamed:@"形状 858 拷贝"] forState:UIControlStateNormal];
        [_mImageBtn setTitleColor:ColorHex(@"#969698") forState:UIControlStateNormal];
        _mImageBtn.titleLabel.font = Font(10.f);
        _mImageBtn.imagePosition = QMUIButtonImagePositionTop;
        _mImageBtn.userInteractionEnabled = NO;
    }
    return _mImageBtn;
}


- (QMUILabel *)label2{
    if (!_label2) {
        _label2 = [QMUILabel new];
        _label2.font = Font(14.f);
        _label2.text = @"手动发送";
        _label2.textColor = ColorHex(@"#333333");
    }
    return _label2;
}

@end



@interface WHSendSelectView ()

@property(nonatomic, strong) QMUILabel *titleLabel;

@property(nonatomic, strong) QMUIButton *selectBtn;

@end

@implementation WHSendSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.selectBtn];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20.f);
            make.centerY.equalTo(self);
        }];
        
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.mas_equalTo(-20.f);
//            make.width.mas_equalTo(50.f);
            make.left.equalTo(self.titleLabel.mas_right).offset(10.f);
            make.height.mas_equalTo(15.f);
        }];
    }
    return self;
}

- (void)updateTitleWithStr:(NSString *)title{
    [_selectBtn setTitle:title forState:UIControlStateNormal];
}

#pragma mark -- Action
- (void)selectTime{
    if (self.selectTimeBlock) {
        self.selectTimeBlock();
    }
}


#pragma mark -- lazy
- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QMUILabel new];
        _titleLabel.text = @"自动发送时间";
        _titleLabel.textColor = ColorHex(@"#111111");
    }
    return _titleLabel;
}

- (QMUIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setTitle:@"请选择  " forState:UIControlStateNormal];
        [_selectBtn setTitleColor:ColorHex(@"#999999") forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = Font(14.f);
        [_selectBtn setImage:[UIImage imageNamed:@"rightImage"] forState:UIControlStateNormal];
        _selectBtn.imagePosition = QMUIButtonImagePositionRight;
        [_selectBtn addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
@end
