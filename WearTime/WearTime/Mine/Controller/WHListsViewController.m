//
//  WHListsViewController.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHListsViewController.h"
#import "WHMouldTableViewCell.h"
#import "WHListsTableViewCell.h"
#import "WHNormalListTableViewCell.h"
#import "BEMCheckBox.h"
#import "WHMouldMViewController.h"
#import "WHReportModel.h"

@interface WHListsViewController () <QMUITableViewDelegate,QMUITableViewDataSource,BEMCheckBoxDelegate>

@property(nonatomic, strong) QMUITableView *tableView;
@property(nonatomic, strong) QMUIButton *confirmBtn;
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) NSArray *sourceArr;

@property(nonatomic, strong) WHReportListModel *listModel;

@end

@implementation WHListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"体检报告项目清单";
    self.view.backgroundColor = ColorHex(@"#F2F1F6");
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.confirmBtn];

    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(50.f);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.bottom.mas_equalTo(-50);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.confirmBtn.mas_top).offset(-20.f);
    }];
    
    /// 获取已选择的体检模块
    [self getSelectLists];
}


#pragma mark -- UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}


- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.dataSource.count : self.sourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WHNormalListTableViewCell *cell = [WHNormalListTableViewCell cellWithTableView:tableView];
        NSString *text = self.dataSource[indexPath.row];
        cell.titleLabel.text = text;
        return cell;
    }else {
        WHListsTableViewCell *cell = [WHListsTableViewCell cellWithTableView:tableView];
        cell.titleLabel.text = _sourceArr[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 1 ? 50.f : 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        CGFloat height = 50.f;//section == 2 ? 36.f : 10.f;
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        headView.backgroundColor = [UIColor clearColor];
        
        QMUILabel *label = [QMUILabel new];
        label.textColor = ColorHex(@"#111111");
        label.font = [UIFont boldSystemFontOfSize:16.f];
        label.text = @"以下全选";
        
        BEMCheckBox *checkBox = [BEMCheckBox new];
        checkBox.onTintColor = WHBaseTextColor;
        checkBox.onCheckColor = WHBaseTextColor;
        checkBox.animationDuration = 0.4;
//        _checkBox.hidden = YES;
        checkBox.qmui_outsideEdge = UIEdgeInsetsMake(-10, -10, -10, -10);
        checkBox.boxType = BEMBoxTypeSquare;
        checkBox.delegate = self;
        
        [headView addSubview:label];
        [headView addSubview:checkBox];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-12.f);
            make.left.mas_equalTo(21.5f);
        }];
        
        [checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label);
            make.right.mas_equalTo(-30.5f);
            make.width.height.mas_equalTo(18.f);
        }];
        
        return headView;
    }
    return nil;
}
#pragma mark -- Action
- (void)confirmAction{
    
    self.listModel.bloodOxygen = 1;
    self.listModel.heartRate = 1;

//
//    [WHWearTimeApi saveChooseWithId:[WHUserInfo sharedInfo].userId onSuccess:^{
//        NSLog(@"清单选择成功");
//    } onFailure:^(NSError * _Nonnull error) {
//        NSLog(@"清单选择失败");
//    }];
    
    [WHWearTimeApi saveChooseWithId:[WHUserInfo sharedInfo].userId listModel:self.listModel onSuccess:^{
        NSLog(@"清单选择成功");
    } onFailure:^(NSError * _Nonnull error) {
        NSLog(@"清单选择失败");
    }];
    
    
    [self.navigationController pushViewController:[WHMouldMViewController new] animated:YES];
}

/**
 查询选择的清单
 */
- (void)getSelectLists{
    [WHWearTimeApi queryChooseWithId:[WHUserInfo sharedInfo].userId onSuccess:^(WHReportListModel * _Nonnull model) {
        NSLog(@"获取查询的已选择的项目清单成功 %@",[model sl_modelToJSONString]);
        self.listModel = model;
        [self.tableView reloadData];
    } onFailure:^(NSError * _Nonnull error) {
        NSLog(@"获取查询的已选择的项目清单失败  %@",error);
    }];
}

#pragma mark -- BEMCheckBoxDelegate
- (void)didTapCheckBox:(BEMCheckBox*)checkBox{
    // 全选
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

- (QMUIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:WHBaseTextColor];
        _confirmBtn.layer.cornerRadius = 10.f;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
        _dataSource = @[
            @"心率",
            @"血糖",
            @"收缩压",
            @"舒张压",
            @"血氧饱和度"
        ];
    }
    return _dataSource;
}

- (NSArray *)sourceArr{
    if (!_sourceArr) {
        _sourceArr = [NSArray array];
        _sourceArr = @[
            @"基础体温",
            @"末梢灌注指数",
            @"血液酒精浓度",
            @"最大肺活量丨用力肺活量",
            @"第一次用力呼气量",
            @"呼气流量峰值",
            @"膳食胆固醇"
        ];
    }
    return _sourceArr;
}

@end
