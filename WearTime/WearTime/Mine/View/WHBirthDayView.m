//
//  WHBirthDayView.m
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import "WHBirthDayView.h"

@interface WHBirthDayView () <UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic, strong) UIPickerView *pickerView;
@property(nonatomic, strong) QMUIButton *confirmBtn;
@property(nonatomic, strong) NSArray *yearArray;
@property(nonatomic, strong) NSArray *monthArray;

/** 选择的年 */
@property (nonatomic, assign)NSInteger selectYear;
/** 选择的月 */
@property (nonatomic, assign)NSInteger selectMonth;
/** 选择的日 */
@property (nonatomic, assign)NSInteger selectDay;
//现在的年月日
@property (nonatomic, assign)NSInteger currentYear;
@property (nonatomic, assign)NSInteger currentMonth;
@property (nonatomic, assign)NSInteger currentDay;
//默认年月日
@property (nonatomic, assign)NSInteger defaultYear;
@property (nonatomic, assign)NSInteger defaultMonth;
@property (nonatomic, assign)NSInteger defaultDay;

//显示的最低年
@property (nonatomic, assign)NSInteger minShowYear;

@end

@implementation WHBirthDayView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorHex(@"#f6f6f6");
        [self addSubview:self.pickerView];
        [self addSubview:self.confirmBtn];
        
        [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.right.mas_equalTo(-5);
            make.left.mas_equalTo(5.f);
            make.height.mas_offset(40.f);
        }];
        
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5.f);
            make.left.mas_equalTo(5.f);
            make.right.mas_equalTo(-5);
            make.bottom.equalTo(self.confirmBtn.mas_top).offset(-5);
        }];
        
        [self getCurrentTime];
    }
    return self;
}

- (void)getCurrentTime{
    //设置数据   110年
    _minShowYear = 1913;//最小年份
    
    
    NSCalendar *calendar = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* date = [NSDate date];
    // 指定获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [calendar components:unitFlags fromDate:date];
    _selectYear = comp.year;
    _selectMonth = comp.month;
    _selectDay = comp.day;
    _defaultYear = comp.year;
    _defaultMonth = comp.month;
    _defaultDay = comp.day;
    
    
    [self.pickerView selectRow:(_defaultYear - _minShowYear) inComponent:0 animated:YES];
    [self.pickerView selectRow:(_defaultMonth - 1) inComponent:1 animated:YES];
    [self.pickerView reloadComponent:1];
    [self.pickerView selectRow:(_defaultDay-1) inComponent:2 animated:NO];
    [self.pickerView reloadComponent:2];

}


#pragma mark -- Action
- (void)confirmAction{
    if (self.selectBirthDayAction) {
        self.selectBirthDayAction([NSString stringWithFormat:@"%@-%@-%@",@(_selectYear), @(_selectMonth), @(_selectDay)]);
    }
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            {
                return self.yearArray.count;
            }
            break;
            
        case 1:{
            return self.monthArray.count;
        }
            break;
            
        case 2: {
            NSInteger yearIndex = [pickerView selectedRowInComponent:0];
            NSInteger monthIndex = [pickerView selectedRowInComponent:1];
            NSInteger yearSelected = [self.yearArray[yearIndex] intValue];
            NSInteger monthSelected = [self.monthArray[monthIndex] intValue];
            return  [self getDaysWithYear:yearSelected month:monthSelected];
        }
            break;
            
        default:
            return 1;
            break;
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 60.f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50.f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *text;
    if (component == 0) {
        text =  [NSString stringWithFormat:@"%@年", self.yearArray[row]];
    } else if (component == 1) {
        text =  [NSString stringWithFormat:@"%@月", self.monthArray[row]];
    } else {
        text = [NSString stringWithFormat:@"%zd日", row + 1];
    }
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:15.f];
    label.text = text;
    
    return label;
}

- (NSInteger)getDaysWithYear:(NSInteger)year month:(NSInteger)month {
    switch (month) {
        case 1:
            return 31;
            break;
        case 2:
            //分为闰年和平年
            if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)) {
                return 29;
            }else{
                return 28;
            }
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSInteger selectYear;
    NSInteger selectMonth;
    switch (component) {
        case 0:
            [pickerView reloadComponent:1];
            selectYear = row + _minShowYear;
            [pickerView reloadComponent:2];
            break;
        case 1:
            selectMonth = row + 1;
            [pickerView reloadComponent:2];
        default:
            break;
    }
    [self refreshPickViewData];
}

//更新数据
- (void)refreshPickViewData {
    self.selectYear  = [self.pickerView selectedRowInComponent:0] + self.minShowYear;
    self.selectMonth = [self.pickerView selectedRowInComponent:1] + 1;
    self.selectDay   = [self.pickerView selectedRowInComponent:2] + 1;
}



#pragma mark -- lazy
- (UIPickerView *)pickerView {
    if (nil == _pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.backgroundColor = [UIColor clearColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.layer.cornerRadius = 10;
    }
    return _pickerView;;
}

- (QMUIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:WHBaseTextColor];
        _confirmBtn.layer.cornerRadius = 10.f;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (NSArray *)yearArray{
    if (nil == _yearArray) {
        _yearArray = [NSArray array];
        NSMutableArray *mutArr = [NSMutableArray array];
        for (NSInteger index = _minShowYear; index < 2024; index ++) {
            [mutArr addObject:[NSString stringWithFormat:@"%@",@(index)]];
        }
        _yearArray = [NSArray arrayWithArray:mutArr];
    }
    return _yearArray;
}

- (NSArray *)monthArray{
    if (nil == _monthArray) {
        _monthArray = [NSArray array];
        NSMutableArray *mutArr = [NSMutableArray array];
        for (NSInteger index = 1; index < 13; index ++) {
            [mutArr addObject:@(index).stringValue];
        }
        _monthArray = [NSArray arrayWithArray:mutArr];
    }
    return _monthArray;
}


@end
