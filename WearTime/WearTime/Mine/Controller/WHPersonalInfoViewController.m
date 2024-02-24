//
//  WHPersonalInfoViewController.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHPersonalInfoViewController.h"
#import "WHSexTableViewCell.h"
#import "WHBirthTableViewCell.h"
#import "WHDetailTableViewCell.h"
#import "WHBirthDayView.h"
#import "WHNumPadView.h"
#import "WHHisMedicalView.h"
#import "WHListsViewController.h"

@interface WHPersonalInfoViewController () <QMUITableViewDelegate,QMUITableViewDataSource>
@property(nonatomic, strong) QMUITableView *tableView;

@property(nonatomic, strong) WHBirthDayView *datePickView;
@property(nonatomic, assign) BOOL isDatePickerShow;

@property(nonatomic, strong) WHNumPadView *heightPickView;
@property(nonatomic, assign) BOOL isHeightPickerShow;
//@property(nonatomic, strong) NSString *popleHeight;  //身高


@property(nonatomic, strong) WHNumPadView *weightPickView;
@property(nonatomic, assign) BOOL isWeightPickerShow;
//@property(nonatomic, strong) NSString *peopleWeight;  //体重

@property(nonatomic, strong) WHHisMedicalView *medicalView;

@property(nonatomic, strong) NSArray *hisMedicArr;  // 过往病史数组

@property(nonatomic, assign) WHSelectMedicType selectType;

@property(nonatomic, strong) NSString *hisMedicals;   //过去病史

@property(nonatomic, strong) NSString *familyMedicals;   //家庭病史

@property(nonatomic, strong) QMUIButton *nextBtn;

@property(nonatomic, assign) BOOL isUpdate;   // 存在个人资料id就是新增

/// /传输的数据
//@property(nonatomic, strong) NSString *birthday;   //生日
//@property(nonatomic, strong) NSString *familyHistory;   //家庭病史
//@property(nonatomic, strong) NSString *pastHistory;   // 过往病史
//@property(nonatomic, strong) NSString *sex;   // 性别
//@property(nonatomic, assign) NSInteger userId;   // 用户id
//@property(nonatomic, assign) NSString *pID; //  资料id对应接口的id


@property(nonatomic, assign) BOOL isChangeInfo;   // 是否修改资料
@property(nonatomic, strong) WHPeopleModel *peopleModel;


@end

@implementation WHPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    self.view.backgroundColor = ColorHex(@"#F2F1F6");
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.medicalView];
    [self.view addSubview:self.nextBtn];

    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(50.f);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.bottom.mas_equalTo(-50);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.nextBtn.mas_top).offset(-20.f);
    }];
    
    [self.medicalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.medicalView.hidden = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenPopView)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
//    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self getLastCases];
    
    // 查询个人资料显示
    [self getMyInfo];
}

- (void)getMyInfo{
    // queryUserInfoWithUserModel
    WHPeopleModel *model = [WHPeopleModel new];
    model.userId = [[WHUserInfo sharedInfo].userId integerValue];
    @weakify(self)
    [WHWearTimeApi queryUserInfoWithUserModel:model onSuccess:^(WHPeopleModel * _Nonnull peopleModel) {
        @strongify(self)
        NSLog(@"获取个人资料成功 %@",[peopleModel sl_modelToJSONString]);
        self.peopleModel = peopleModel;
        [self.tableView reloadData];
        [[WHUserInfo sharedInfo] saveUserPerInfoWith:peopleModel];
    } onFailure:^(NSError * _Nonnull error) {
        NSLog(@"获取个人资料出错");
    }];
}

#pragma mark -- QMUITableView
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGFloat height = 40.f;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    headView.backgroundColor = [UIColor clearColor];
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.font = Font(13);
    detailLabel.textColor = ColorHex(@"#666666");
    detailLabel.numberOfLines = 0;
    detailLabel.text = @"以上信息无误，请点击下一步；如有误，请点击相应位置进行修改。";
    
    [headView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView);
        make.left.mas_equalTo(25.f);
        make.right.mas_equalTo(-25.f);
        make.top.mas_equalTo(10.f);
    }];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            WHSexTableViewCell *cell = [WHSexTableViewCell cellWithTableView:self.tableView];
            cell.warnLabel.hidden = self.peopleModel.sex.length > 0 ? YES : NO;
            if ([self.peopleModel.sex isEqualToString:@"1"]) {
                cell.manBox.on = YES;
                cell.womenBox.on = NO;
            }
            if ([self.peopleModel.sex  isEqualToString:@"0"]) {
                cell.manBox.on = NO;
                cell.womenBox.on = YES;
            }
            @weakify(self)
            cell.selectSex = ^(SexType type, BOOL isCheckOn) {
                @strongify(self)
                self.peopleModel.sex  = type == SexType_Man ? @"1" : @"0";
                [self.tableView reloadRow:0 inSection:0 withRowAnimation:0];
            };
            return cell;
        }
            break;
            
        case 1: {
            WHBirthTableViewCell *cell = [WHBirthTableViewCell cellWithTableView:self.tableView];
            cell.titleLabel.text = @"出生日期(必填)";
            [cell.mBtn setTitle:self.peopleModel.birthday.length > 0 ? self.peopleModel.birthday : @"请选择" forState:UIControlStateNormal];
            cell.warnLabel.hidden = self.peopleModel.birthday.length > 0 ? YES : NO;
            return cell;
        }
            break;
            
        case 2:{
            WHDetailTableViewCell *cell = [WHDetailTableViewCell cellWithTableView:self.tableView];
            cell.titleLabel.text = @"身高";
            cell.text.text = @"厘米";
            NSString *height = @"请选择";
            if (self.peopleModel.height > 0) {
                height = [NSString stringWithFormat:@"%@",@(self.peopleModel.height)];
            }
            [cell.mBtn setTitle:height forState:UIControlStateNormal];
            
            return cell;
        }
            break;
            
        case 3:{
            WHDetailTableViewCell *cell = [WHDetailTableViewCell cellWithTableView:self.tableView];
            cell.titleLabel.text = @"体重";
            cell.text.text = @"斤";
            NSString *weight = @"请选择";
            if (self.peopleModel.weight > 0) {
                weight = [NSString stringWithFormat:@"%@",@(self.peopleModel.weight)];
            }
            [cell.mBtn setTitle:weight forState:UIControlStateNormal];
            return cell;
        }
            break;
            
        case 4:{
            WHBirthTableViewCell *cell = [WHBirthTableViewCell cellWithTableView:self.tableView];
            cell.titleLabel.text = @"过去病史";
            [cell.mBtn setTitle:self.hisMedicals.length > 0 ? self.hisMedicals : @"请选择" forState:UIControlStateNormal];
            cell.warnLabel.hidden = YES;
            return cell;
        }
            break;
            
        case 5:{
            WHBirthTableViewCell *cell = [WHBirthTableViewCell cellWithTableView:self.tableView];
            cell.titleLabel.text = @"家族病史";
            cell.warnLabel.hidden = YES;
            [cell.mBtn setTitle:self.familyMedicals.length > 0 ? self.familyMedicals : @"请选择" forState:UIControlStateNormal];
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            return;
        }
            break;
            
        case 1:{
            ///  展示出生日期
            [self showBirthpickView];
        }
            break;
            
        case 2:{
            [self showHeightView];
        }
            break;
            
        case 3:{
            [self showWeightView];
        }
            break;
            
        case 4:{
            [self showHisMedicaViewWithType:WHSelectMedicType_His];
        }
            break;
            
        case 5:{
            [self showHisMedicaViewWithType:WHSelectMedicType_Family];
        }
            break;
            
        default:
            break;
    }
}

- (void)hiddenPopView{
    if (self.isDatePickerShow) {
        [self.datePickView removeFromSuperview];
        self.datePickView = nil;
        self.isDatePickerShow = NO;
        return;
    }
    
    if (self.isHeightPickerShow) {
        [self.heightPickView removeFromSuperview];
        self.heightPickView = nil;
        self.isHeightPickerShow = NO;
        return;
    }
    
    if (self.isWeightPickerShow) {
        [self.weightPickView removeFromSuperview];
        self.weightPickView = nil;
        self.isWeightPickerShow = NO;
        return;
    }
}

#pragma mark -- DidMethod
- (void)showBirthpickView{
    if (self.isDatePickerShow) {
        [self hiddenPopView];
        return;
    }
    
    WHBirthDayView *pickerView = [WHBirthDayView new];
    pickerView.backgroundColor = ColorHex(@"#f6f6f6");
    [self.view addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-14.5f);
        make.left.mas_equalTo(70.f);
        make.top.mas_equalTo(180.f);
        make.height.mas_equalTo(270.f);
    }];
    
    @weakify(self)
    pickerView.selectBirthDayAction = ^(NSString * _Nonnull day) {
        @strongify(self)
        self.peopleModel.birthday  = day;
        [self.tableView reloadRow:1 inSection:0 withRowAnimation:0];
        [self hiddenPopView];
    };

    self.datePickView = pickerView;
    [self.view bringSubviewToFront:self.datePickView];
    self.isDatePickerShow = YES;
}

- (void)showHeightView{
    // 身高规则是50-230
    if (self.isHeightPickerShow) {
        [self hiddenPopView];
        return;
    }
    
    WHNumPadView *pickerView = [WHNumPadView new];
    pickerView.backgroundColor = ColorHex(@"#f6f6f6");
    pickerView.userInteractionEnabled = YES;
    [self.view addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-14.5f);
        make.left.mas_equalTo(70.f);
        make.top.mas_equalTo(240.f);
        make.height.mas_equalTo(270.f);
    }];

    @weakify(self)
    pickerView.selectNum = ^(NSString * _Nonnull num) {
        @strongify(self)
        NSString *needHeight = [NSString stringWithFormat:@"%@%@",@(self.peopleModel.height),num];
        self.peopleModel.height = [needHeight integerValue];
        [self.tableView reloadRow:2 inSection:0 withRowAnimation:0];
    };
    
    pickerView.giveUpAction = ^{
        @strongify(self)
        [self hiddenPopView];
        self.peopleModel.height = 0;
        [self.tableView reloadRow:2 inSection:0 withRowAnimation:0];
    };
    
    pickerView.confirmAction = ^{
        [self hiddenPopView];
    };
    

    self.heightPickView = pickerView;
    [self.view bringSubviewToFront:self.heightPickView];
    self.isHeightPickerShow = YES;
}


- (void)showWeightView{
    if (self.isWeightPickerShow) {
        [self hiddenPopView];
        return;
    }
    
    WHNumPadView *pickerView = [WHNumPadView new];
    pickerView.backgroundColor = ColorHex(@"#f6f6f6");
    pickerView.userInteractionEnabled = YES;
    [self.view addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-14.5f);
        make.left.mas_equalTo(70.f);
        make.top.mas_equalTo(300.f);
        make.height.mas_equalTo(270.f);
    }];

    @weakify(self)
    pickerView.selectNum = ^(NSString * _Nonnull num) {
        @strongify(self)
        NSString *needWeight = [NSString stringWithFormat:@"%@%@",@(self.peopleModel.weight),num];
        self.peopleModel.weight = [needWeight integerValue];
        [self.tableView reloadRow:3 inSection:0 withRowAnimation:0];
    };
    
    pickerView.giveUpAction = ^{
        @strongify(self)
        self.peopleModel.height = 0;
        [self.tableView reloadRow:2 inSection:0 withRowAnimation:0];
    };
    
    pickerView.confirmAction = ^{
        [self hiddenPopView];
    };
    

    self.weightPickView = pickerView;
    [self.view bringSubviewToFront:self.weightPickView];
    self.isWeightPickerShow = YES;
}

#pragma mark -- Action
/// 获取过往病史
- (void)getLastCases{
    @weakify(self)
    [WHWearTimeApi getMedicalCasesOnSuccess:^(NSArray * _Nonnull cases) {
        @strongify(self)
        self.hisMedicArr = [NSArray arrayWithArray:cases];
        [self.tableView reloadData];
    } onFailure:^(NSError * _Nonnull error) {
        NSLog(@"获取病例数组失败");
    }];
    
}

// 弹框
- (void)showHisMedicaViewWithType:(WHSelectMedicType)type{
    [self hiddenPopView];
    
    
    self.selectType = type;
    [self.medicalView reloadTableViewWithaArr:self.hisMedicArr];
    if (self.medicalView.hidden == NO) {
        [self.view bringSubviewToFront:self.medicalView];
    }
    self.medicalView.hidden = !self.medicalView.hidden;
}

- (void)nextPress{
    _peopleModel.userId = [[WHUserInfo sharedInfo].userId integerValue];
    NSLog(@"nextPress :%@",[_peopleModel sl_modelToJSONString]);
    [WHWearTimeApi addOrChangeInfoWithUserInfo:_peopleModel onSuccess:^(WHPeopleModel * _Nonnull peopleModel) {
        NSLog(@"添加成功");
        /// 进入体检报告清单界面
        [[WHUserInfo sharedInfo] saveUserPerInfoWith:self.peopleModel];
        [self.navigationController pushViewController:[WHListsViewController new] animated:YES];

    } onFailure:^(NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"失败"];
        NSLog(@"添加失败");
    }];
}

#pragma mark -- lazy
- (QMUITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorColor = ColorHex(@"#E4E4E4");
        _tableView.layer.cornerRadius = 10.f;
//        _tableView.rowHeight = 55.f;
//        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.f)];
    }
    return _tableView;
}

- (WHHisMedicalView *)medicalView{
    if (!_medicalView){
        _medicalView = [WHHisMedicalView new];
        @weakify(self)
        _medicalView.backWithArr = ^(NSArray * _Nonnull array) {
            @strongify(self)
            if (self.selectType == WHSelectMedicType_His) {
                self.hisMedicals = [array componentsJoinedByString:@","];
                [self.tableView reloadRow:4 inSection:0 withRowAnimation:0];
            } else {
                self.familyMedicals = [array componentsJoinedByString:@","];
                [self.tableView reloadRow:5 inSection:0 withRowAnimation:0];
            }
            
        };
    }
    return _medicalView;
}

- (NSArray *)hisMedicArr{
    if (!_hisMedicArr) {
        _hisMedicArr = [NSArray array];
    }
    return _hisMedicArr;
}

- (QMUIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:WHBaseTextColor];
        _nextBtn.layer.cornerRadius = 10.f;
        _nextBtn.layer.masksToBounds = YES;
        [_nextBtn addTarget:self action:@selector(nextPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (WHPeopleModel *)peopleModel{
    if (!_peopleModel) {
        _peopleModel = [WHPeopleModel new];
    }
    return _peopleModel;
}


@end
