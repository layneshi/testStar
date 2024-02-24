//
//  WHWechatInviteViewController.m
//  WearTime
//
//  Created by layne on 2023/7/10.
//

#import "WHWechatInviteViewController.h"
#import "WHWechatInviteTableViewCell.h"

@interface WHWechatInviteViewController () <QMUITableViewDelegate,QMUITableViewDataSource>

@property(nonatomic, strong) QMUILabel *titleLabel;
@property(nonatomic, strong) QMUIButton *cancelBtn;
@property(nonatomic, strong) QMUIButton *confirmBtn;
@property(nonatomic, strong) QMUITableView *tableView;
@property(nonatomic, strong) UIStackView *mStackView;


@end

@implementation WHWechatInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorHex(@"#f2f1f7");
    [self.view addSubview:self.titleLabel];
//    [self.view addSubview:self.mStackView];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.confirmBtn];
    [self.view addSubview:self.tableView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(30.f);
    }];
    
//    [self.mStackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.height.mas_equalTo(IsIphoneX ? 80.f : 60.f);
//    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22.5f);
        make.width.mas_equalTo(157.f);
        make.height.mas_equalTo(46.f);
        make.bottom.mas_equalTo(-(KSafeBottomHeight + 20.f));
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-22.5f);
        make.width.mas_equalTo(157.f);
        make.height.mas_equalTo(46.f);
        make.bottom.mas_equalTo(-(KSafeBottomHeight + 20.f));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5.f);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.cancelBtn.mas_top).offset(-20.f);
    }];
}

#pragma mark -- UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WHWechatInviteTableViewCell *cell = [WHWechatInviteTableViewCell cellWithTableView:self.tableView];
    cell.name.text = @"11111";
    return cell;
}

#pragma mark -- Action
- (void)cancelAction{
    
}

- (void)confirmAction{
    
}

#pragma mark -- lazy
- (QMUIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:WHBaseTextColor];
        _cancelBtn.layer.cornerRadius = 10.f;
        _cancelBtn.layer.masksToBounds = YES;
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (QMUIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMakeWithSize(CGSizeMake(100, 40));
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:WHBaseTextColor];
        _confirmBtn.layer.cornerRadius = 10.f;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QMUILabel new];
        _titleLabel.font = Font(16.f);
        _titleLabel.textColor = ColorHex(@"#282828");
        _titleLabel.text = @"微信邀请成功名单";
    }
    return _titleLabel;
}

- (QMUITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorColor = ColorHex(@"#E4E4E4");
//        _tableView.rowHeight = 55.f;
//        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.f)];
    }
    return _tableView;
}

- (UIStackView *)mStackView{
    if (!_mStackView) {
        _mStackView = [UIStackView new];
        _mStackView.axis = UILayoutConstraintAxisHorizontal;
        _mStackView.distribution = UIStackViewDistributionFillEqually;
        _mStackView.spacing = 18.f;
        _mStackView.backgroundColor = [UIColor whiteColor];
        [_mStackView addArrangedSubview:self.cancelBtn];
        [_mStackView addArrangedSubview:self.confirmBtn];
    }
    return _mStackView;
}

@end
