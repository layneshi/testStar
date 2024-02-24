//
//  WHSelectSendTimeView.m
//  WearTime
//
//  Created by layne on 2023/7/10.
//

#import "WHSelectSendTimeView.h"

@interface WHSelectSendTimeView ()

@property(nonatomic, strong) QMUIButton *cancelBtn;
@property(nonatomic, strong) QMUIButton *everyDayBtn;  // 每天
@property(nonatomic, strong) QMUIButton *everyWeekBtn;   // 每周
@property(nonatomic, strong) QMUIButton *otherTimeBtn;   // 每周间隔几天
@property(nonatomic, strong) WHTimePickView *pickView;
@property(nonatomic, strong) WHSendTimeModel *timeModel;



@end


@implementation WHSelectSendTimeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.cancelBtn];
        [self addSubview:self.everyDayBtn];
        [self addSubview:self.everyWeekBtn];
        [self addSubview:self.otherTimeBtn];
        [self addSubview:self.pickView];
        
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(21.f);
            make.top.mas_equalTo(16.f);
            make.width.mas_equalTo(50.f);
            make.height.mas_equalTo(20.f);
        }];
        
        [self.everyDayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.mas_equalTo(21.f);
            make.width.mas_equalTo(100.f);
            make.height.mas_equalTo(20.f);
        }];
        
        [self.otherTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self);
            make.top.equalTo(self.everyDayBtn.mas_bottom).offset(21.f);
            make.left.mas_equalTo(21.f);
            make.width.mas_equalTo(100.f);
            make.height.mas_equalTo(20.f);
        }];
        
        [self.everyWeekBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self);
            make.top.equalTo(self.otherTimeBtn.mas_bottom).offset(21.f);
            make.left.mas_equalTo(21.f);
            make.width.mas_equalTo(100.f);
            make.height.mas_equalTo(20.f);
        }];
        
        [self.pickView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cancelBtn.mas_bottom).offset(15.f);
            make.bottom.right.equalTo(self);
            make.left.equalTo(self.otherTimeBtn.mas_right).offset(15.f);
        }];
        
        [self clickPress:self.everyDayBtn];
    }
    return self;
}

#pragma mark -- Action
- (void)clickPress:(UIButton *)btn{
    [self.pickView reloadPickViewData:btn.tag];
    switch (btn.tag) {
        case WHPickViewType_Everyday:
        {
            self.everyDayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
            self.otherTimeBtn.titleLabel.font = Font(16.f);
            self.everyWeekBtn.titleLabel.font = Font(16.f);
        }
            break;
            
        case WHPickViewType_OtherDay:{
            self.everyDayBtn.titleLabel.font = Font(16.f);
            self.otherTimeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
            self.everyWeekBtn.titleLabel.font = Font(16.f);
        }
            break;
            
        case WHPickViewType_EveryWeek:{
            self.everyDayBtn.titleLabel.font = Font(16.f);
            self.otherTimeBtn.titleLabel.font = Font(16.f);
            self.everyWeekBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- lazy
- (QMUIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = Font(15.f);
        _cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _cancelBtn;
}

- (QMUIButton *)everyDayBtn{
    if (!_everyDayBtn) {
        _everyDayBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_everyDayBtn setTitle:@"每天" forState:UIControlStateNormal];
        [_everyDayBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        _everyDayBtn.titleLabel.font = Font(15.f);
        _everyDayBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _everyDayBtn.tag = WHPickViewType_Everyday;
        [_everyDayBtn addTarget:self action:@selector(clickPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _everyDayBtn;
}

- (QMUIButton *)otherTimeBtn{
    if (!_otherTimeBtn) {
        _otherTimeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_otherTimeBtn setTitle:@"每周间隔几天" forState:UIControlStateNormal];
        [_otherTimeBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        _otherTimeBtn.titleLabel.font = Font(15.f);
        _otherTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _otherTimeBtn.tag = WHPickViewType_OtherDay;
        [_otherTimeBtn addTarget:self action:@selector(clickPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _otherTimeBtn;
}

- (QMUIButton *)everyWeekBtn{
    if (!_everyWeekBtn) {
        _everyWeekBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_everyWeekBtn setTitle:@"每周" forState:UIControlStateNormal];
        [_everyWeekBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        _everyWeekBtn.titleLabel.font = Font(15.f);
        _everyWeekBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _everyWeekBtn.tag = WHPickViewType_EveryWeek;
        [_everyWeekBtn addTarget:self action:@selector(clickPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _everyWeekBtn;
}

- (WHTimePickView *)pickView{
    if (!_pickView) {
        _pickView = [WHTimePickView new];
        _pickView.backgroundColor = [UIColor whiteColor];
        @weakify(self)
        _pickView.blockPickView = ^(NSString * _Nonnull showString, WHSendTimeModel * _Nonnull timeModel) {
            @strongify(self)
            if (self.blockPickView) {
                self.blockPickView(showString, timeModel);
            }
        };
    }
    return _pickView;
}

@end


@interface WHTimePickView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) QMUILabel *label1;
@property(nonatomic, strong) QMUILabel *label2;
@property(nonatomic, strong) QMUILabel *label3;
@property(nonatomic, strong) UIStackView *mStackView;

@property(nonatomic, strong) UIPickerView *pickerView;
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, assign) WHPickViewType viewType;
@property(nonatomic, strong) WHSendTimeModel *timeModel;

@property(nonatomic, assign) NSInteger indexOfFirstComponent;
@property(nonatomic, assign) NSInteger indexOfSecondComponent;
@property(nonatomic, assign) NSInteger indexOfThirdComponent;

@property(nonatomic, assign) NSInteger whSelectHour;  // 选择的时
@property(nonatomic, assign) NSInteger whSelectMinute;  // 选择的分钟
@property(nonatomic, assign) NSInteger  whSelectFirst;  // 每周周几


@end


@implementation WHTimePickView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self addSubview:self.label1];
//        [self addSubview:self.label2];
//        [self addSubview:self.label3];
        
        [self addSubview:self.mStackView];
        [self addSubview:self.pickerView];
        
        [self.mStackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.width.mas_equalTo(20);
        }];
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.top.equalTo(self.mStackView.mas_bottom).offset(10.f);
        }];
    }
    return self;
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *sectionArray = self.dataArray[component];
    return sectionArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component  {
    NSArray *sectionArray = self.dataArray[component];
    NSString *string = sectionArray[row];
    
    string = component == 0 ? [string stringByAppendingString:@":"] :string;
    
    return string;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 55.f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50.f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *tView = (UILabel *)view;
    if (!tView) {
        tView = [UILabel new];
        tView.textColor = [UIColor blackColor];
        tView.font = self.viewType == WHPickViewType_Everyday ? Font(22.f) : Font(17.f);
        tView.textAlignment = NSTextAlignmentCenter;
        if (component == self.dataArray.count - 2) {
            tView.textAlignment = NSTextAlignmentRight;
        }
        if (component == self.dataArray.count - 1) {
            [tView setText:[NSString stringWithFormat:@": %@",self.dataArray[component][row]]];
        } else {
            [tView setText:self.dataArray[component][row]];
        }
        
        
    }
    return tView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        self.indexOfFirstComponent = row;
    } else if (component == 1) {
        self.indexOfSecondComponent = row;
    } else {
        self.indexOfThirdComponent = row;
    }
    
        switch (self.viewType) {
        case WHPickViewType_Everyday:
            {
            
                NSString *hour = [self.dataArray firstObject][self.indexOfFirstComponent];
                NSString *minute = [self.dataArray lastObject][self.indexOfSecondComponent];
                
                if([hour isEqualToString:@"0"] && self.whSelectHour != 0) {
                    hour = [self.dataArray firstObject][self.whSelectHour];
                }
                
                if([minute isEqualToString:@"00"] && self.whSelectMinute != 0 ) {
                    minute = [self.dataArray lastObject][self.whSelectMinute];
                }
                
                NSString *showStr = [NSString stringWithFormat:@"每天 %@:%@",hour,minute];
                
                if (component == 0) {
                    self.whSelectHour = row;
                } else {
                    self.whSelectMinute = row;
                }
                
                self.timeModel.day = 1;
                self.timeModel.hour = [hour intValue];
                self.timeModel.minutes = [minute intValue];
                
                if(self.blockPickView){
                    self.blockPickView(showStr, self.timeModel);
                }
            }
            break;
            
        case WHPickViewType_OtherDay:{
                        
            NSString *day = [self.dataArray firstObject][self.indexOfFirstComponent];
            NSString *hour = self.dataArray[1][self.indexOfSecondComponent];
            NSString *minute = [self.dataArray lastObject][self.indexOfThirdComponent];
            
            
            if([hour isEqualToString:@"0"] && self.whSelectHour != 0) {
                hour = self.dataArray[1][self.whSelectHour];
            }
            
            if([minute isEqualToString:@"00"] && self.whSelectMinute != 0 ) {
                minute = [self.dataArray lastObject][self.whSelectMinute];
            }
            
            NSString *showStr = [NSString stringWithFormat:@"每隔%@天 %@:%@",day,hour,minute];
        
            self.whSelectFirst = self.indexOfFirstComponent;
            
            self.timeModel.intervalDays = [day integerValue];
            self.timeModel.hour = [hour intValue];
            self.timeModel.minutes = [minute intValue];
            
            if (component == 1) {
                self.whSelectHour = row;
            } else if (component == 2) {
                self.whSelectMinute = row;
            }
            
            if(self.blockPickView){
                self.blockPickView(showStr, self.timeModel);
            }
            
        }
            break;
            
        case WHPickViewType_EveryWeek:{
            
            NSString *week = [self.dataArray firstObject][self.indexOfFirstComponent];
            NSString *hour = self.dataArray[1][self.indexOfSecondComponent];
            NSString *minute = [self.dataArray lastObject][self.indexOfThirdComponent];
            
            if([hour isEqualToString:@"0"] && self.whSelectHour != 0) {
                hour = self.dataArray[1][self.whSelectHour];
            }
            
            if([minute isEqualToString:@"00"] && self.whSelectMinute != 0 ) {
                minute = [self.dataArray lastObject][self.whSelectMinute];
            }
            
            NSString *showStr = [NSString stringWithFormat:@"每%@ %@:%@",week,hour,minute];
            self.whSelectFirst = self.indexOfFirstComponent;
            
            if (component == 1) {
                self.whSelectHour = row;
            } else if (component == 2) {
                self.whSelectMinute = row;
            }
            
            NSInteger needWeak;
            if ([week isEqualToString:@"星期一"]) {
                needWeak = 1;
            }
            else if ([week isEqualToString:@"星期二"]){
                needWeak = 2;
            }
            else if ([week isEqualToString:@"星期三"]){
                needWeak = 3;
            }
            else if ([week isEqualToString:@"星期四"]){
                needWeak = 4;
            }
            else if ([week isEqualToString:@"星期五"]){
                needWeak = 5;
            }
            else if ([week isEqualToString:@"星期六"]){
                needWeak = 6;
            }
            else {
                needWeak = 7;
            }
            
            self.timeModel.week = needWeak;
            self.timeModel.hour = [hour intValue];
            self.timeModel.minutes = [minute intValue];
            
            if(self.blockPickView){
                self.blockPickView(showStr, self.timeModel);
            }
            
        }
            break;
            
            
        default:
            break;
    }
}

#pragma mark -- Action
- (void)reloadPickViewData:(WHPickViewType)type{
    self.dataArray = nil;
    self.viewType = type;
    [_mStackView removeAllSubviews];
    self.indexOfFirstComponent = 0;
    self.indexOfSecondComponent = 0;
    self.indexOfThirdComponent = 0;
    
    
    NSString *showStr = nil;
    switch (type) {
        case WHPickViewType_Everyday:
        {
            NSMutableArray *hourArray = [NSMutableArray new];
            for (NSInteger index = 0; index < 24; index++) {
                [hourArray addObject:@(index).stringValue];
            }
            NSMutableArray *minArray = [NSMutableArray new];
            for (NSInteger index = 0; index < 60; index++) {
                if (index < 10) {
                    [minArray addObject:[NSString stringWithFormat:@"%@%@",@"0",@(index)]];
                } else {
                    [minArray addObject:@(index).stringValue];
                }
            }
            _dataArray = @[hourArray,minArray];
            
            [_mStackView addArrangedSubview:self.label2];
            [_mStackView addArrangedSubview:self.label3];
        }
            break;
            
        case WHPickViewType_OtherDay:{
            NSMutableArray *dayArray = [NSMutableArray array];
            for (NSInteger index = 1; index < 8; index++) {
                [dayArray addObject:@(index).stringValue];
            }
            
            NSMutableArray *hourArray = [NSMutableArray new];
            for (NSInteger index = 0; index < 24; index++) {
                [hourArray addObject:@(index).stringValue];
            }
            NSMutableArray *minArray = [NSMutableArray new];
            for (NSInteger index = 0; index < 60; index++) {
                if (index < 10) {
                    [minArray addObject:[NSString stringWithFormat:@"%@%@",@"0",@(index)]];
                } else {
                    [minArray addObject:@(index).stringValue];
                }
            }
            _dataArray = @[dayArray,hourArray,minArray];
            
            self.label1.text = @"天";
            [_mStackView addArrangedSubview:self.label1];
            [_mStackView addArrangedSubview:self.label2];
            [_mStackView addArrangedSubview:self.label3];
            
        }
            break;
            
        case WHPickViewType_EveryWeek:{
            NSMutableArray *dayArray = [NSMutableArray arrayWithArray:@[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"]];
            NSMutableArray *hourArray = [NSMutableArray new];
            for (NSInteger index = 0; index < 24; index++) {
                [hourArray addObject:@(index).stringValue];
            }
            NSMutableArray *minArray = [NSMutableArray new];
            for (NSInteger index = 0; index < 60; index++) {
                if (index < 10) {
                    [minArray addObject:[NSString stringWithFormat:@"%@%@",@"0",@(index)]];
                } else {
                    [minArray addObject:@(index).stringValue];
                }
            }
            _dataArray = @[dayArray,hourArray,minArray];
            
            self.label1.text = @"周";
            [_mStackView addArrangedSubview:self.label1];
            [_mStackView addArrangedSubview:self.label2];
            [_mStackView addArrangedSubview:self.label3];
            
        }
            break;
            
        default:
            break;
    }
    [self.pickerView reloadAllComponents];

    if (self.pickerView.numberOfComponents == 3) {
        [self.pickerView selectRow:self.whSelectFirst inComponent:1 animated:YES];
        [self.pickerView reloadComponent:0];
        [self.pickerView selectRow:self.whSelectHour inComponent:1 animated:YES];
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:self.whSelectMinute inComponent:2 animated:YES];
        [self.pickerView reloadComponent:2];
    } else {
        [self.pickerView selectRow:self.whSelectHour inComponent:0 animated:YES];
        [self.pickerView reloadComponent:0];
        [self.pickerView selectRow:self.whSelectMinute inComponent:1 animated:YES];
        [self.pickerView reloadComponent:1];
    }
    
    [self showTitleWithType:type];
}

- (void)showTitleWithType:(WHPickViewType)type{
    NSString *showStr = nil;
    switch (type) {
        case WHPickViewType_Everyday:
        {
            NSString *hour = [self.dataArray firstObject][self.whSelectHour];
            NSString *minute = [self.dataArray lastObject][self.whSelectMinute];
            NSString *showStr = [NSString stringWithFormat:@"每天 %@:%@",hour,minute];
            self.timeModel.day = 1;
            self.timeModel.hour = [hour intValue];
            self.timeModel.minutes = [minute intValue];
            
            if(self.blockPickView){
                self.blockPickView(showStr, self.timeModel);
            }
        }
            break;
            
        case WHPickViewType_OtherDay:{
            NSString *day = [self.dataArray firstObject][self.self.whSelectFirst];
            NSString *hour = self.dataArray[1][self.whSelectHour];
            NSString *minute = [self.dataArray lastObject][self.whSelectMinute];
            NSString *showStr = [NSString stringWithFormat:@"每隔%@天 %@:%@",day,hour,minute];
            self.timeModel.intervalDays = [day integerValue];
            self.timeModel.hour = [hour intValue];
            self.timeModel.minutes = [minute intValue];
            
            if(self.blockPickView){
                self.blockPickView(showStr, self.timeModel);
            }
            
        }
            break;
            
        case WHPickViewType_EveryWeek:{
            
            NSString *week = [self.dataArray firstObject][self.whSelectFirst];
            NSString *hour = self.dataArray[1][self.whSelectHour];
            NSString *minute = [self.dataArray lastObject][self.whSelectMinute];
            NSString *showStr = [NSString stringWithFormat:@"每%@ %@:%@",week,hour,minute];
            NSInteger needWeak;
            if ([week isEqualToString:@"星期一"]) {
                needWeak = 1;
            }
            else if ([week isEqualToString:@"星期二"]){
                needWeak = 2;
            }
            else if ([week isEqualToString:@"星期三"]){
                needWeak = 3;
            }
            else if ([week isEqualToString:@"星期四"]){
                needWeak = 4;
            }
            else if ([week isEqualToString:@"星期五"]){
                needWeak = 5;
            }
            else if ([week isEqualToString:@"星期六"]){
                needWeak = 6;
            }
            else {
                needWeak = 7;
            }
            
            self.timeModel.week = needWeak;
            self.timeModel.hour = [hour intValue];
            self.timeModel.minutes = [minute intValue];
            
            if(self.blockPickView){
                self.blockPickView(showStr, self.timeModel);
            }
            
        }
            break;
            
        default:
            break;
    }
}





#pragma mark -- lazy
- (QMUILabel *)label1{
    if (!_label1) {
        _label1 = [QMUILabel new];
        _label1.textColor = ColorHex(@"#282828");
        _label1.text = @"天";
        _label1.font = Font(14.f);
        _label1.textAlignment = NSTextAlignmentCenter;
    }
    return _label1;
}

- (QMUILabel *)label2{
    if (!_label2) {
        _label2 = [QMUILabel new];
        _label2.textColor = ColorHex(@"#282828");
        _label2.text = @"时";
        _label2.font = Font(14.f);
        _label2.textAlignment = NSTextAlignmentCenter;
    }
    return _label2;
}

- (QMUILabel *)label3{
    if (!_label3) {
        _label3 = [QMUILabel new];
        _label3.textColor = ColorHex(@"#282828");
        _label3.text = @"分";
        _label3.font = Font(14.f);
        _label3.textAlignment = NSTextAlignmentCenter;
    }
    return _label3;
}

- (UIPickerView *)pickerView {
    if (nil == _pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.layer.cornerRadius = 10;
    }
    return _pickerView;;
}

- (NSArray *)dataArray{
    if (nil == _dataArray) {
        
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (UIStackView *)mStackView{
    if (!_mStackView) {
        _mStackView = [UIStackView new];
        _mStackView.axis = UILayoutConstraintAxisHorizontal;
        _mStackView.distribution = UIStackViewDistributionFillEqually;
        _mStackView.spacing = 18.f;
        _mStackView.backgroundColor = [UIColor whiteColor];
//        [_mStackView addArrangedSubview:self.label1];
//        [_mStackView addArrangedSubview:self.label2];
//        [_mStackView addArrangedSubview:self.label3];
    }
    return _mStackView;
}

- (WHSendTimeModel *)timeModel{
    if (!_timeModel) {
        _timeModel = [WHSendTimeModel new];
    }
    return _timeModel;
}

@end
