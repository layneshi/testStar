//
//  WHMouldMViewController.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHMouldMViewController.h"
#import "WHMouldTableViewCell.h"
#import "WHModuleModel.h"
#import "WHSendViewController.h"

@interface WHMouldMViewController () <QMUITableViewDelegate,QMUITableViewDataSource>

@property(nonatomic, strong) QMUITableView *tableView;
@property(nonatomic, strong) QMUIButton *confirmBtn;
@property(nonatomic, strong) QMUILabel *warnLabel;

@end

@implementation WHMouldMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"体检报告模板选择";
    self.view.backgroundColor = ColorHex(@"#F2F1F6");
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.confirmBtn];
    [self.view addSubview:self.warnLabel];

    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(50.f);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.bottom.mas_equalTo(-50);
    }];
    
    [self.warnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.confirmBtn.mas_top).offset(-20.f);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.warnLabel.mas_top).offset(-20.f);
    }];
    [self querySelectReportModule];
}

#pragma mark -- Api
- (void)querySelectReportModule{
    [WHWearTimeApi queryMoudleWithId:@"" onSuccess:^(WHModuleModel * _Nonnull model) {
        
    } onFailure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -- UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 275.f;
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *imgArr = @[@"简易版",@"诊断版",@"医生版"];
    NSArray *titleArr = @[@"体检报告简易版",@"体检报告诊断版",@"体检报告医生简建议版"];
    WHMouldTableViewCell *cell = [WHMouldTableViewCell cellWithTableView:tableView];
    cell.titleLabel.text = titleArr[indexPath.row];
    cell.mImageView.image = [UIImage imageNamed:imgArr[indexPath.row]];
    return cell;
}

#pragma mark -- Action
- (void)confirmAction{
    WHModuleModel *model = [WHModuleModel new];
    [WHWearTimeApi reportModuleWithModels:@[model] onSuccess:^{
        
    } onFailure:^(NSError * _Nonnull error) {
        
        
    }];
    
    [self.navigationController pushViewController:[WHSendViewController new] animated:YES];
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
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.f)];
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

- (QMUILabel *)warnLabel{
    if (!_warnLabel) {
        _warnLabel = [QMUILabel new];
        _warnLabel.text = @"请至少选择一个模板";
        _warnLabel.textColor = ColorHex(@"#ED2D17");
        _warnLabel.font = [UIFont boldSystemFontOfSize:14.f];
    }
    return _warnLabel;
}

@end
