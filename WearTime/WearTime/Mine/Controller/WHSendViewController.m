//
//  WHSendViewController.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHSendViewController.h"
#import "WHSendTableViewCell.h"
#import "WHWechatInviteViewController.h"
#import "WHSendErrorView.h"


@interface WHSendViewController ()  <QMUITableViewDelegate,QMUITableViewDataSource>

@property(nonatomic, strong) QMUITableView *tableView;
@property(nonatomic, strong) QMUIButton *confirmBtn;


@property(nonatomic, strong) WHSendErrorView *errView;

@property(nonatomic, strong) NSMutableArray *selectArr;  // 所有人 包括自己 朋友 医生

@property(nonatomic, strong) NSMutableArray *friendArr;   // 朋友




@end

@implementation WHSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"体检报告发送给谁";
    self.view.backgroundColor = ColorHex(@"#F2F1F6");
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.confirmBtn];
    [self.view addSubview:self.errView];

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
    
    [self.errView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.errView.hidden = YES;
    
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [view resignFirstResponder];
//}  

#pragma mark -- UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat height = 10;//section == 2 ? 36.f : 10.f;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    headView.backgroundColor = ColorHex(@"#f5f5f5");
    return headView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 205.f;
    } else if (indexPath.section == 1) {
        return 320.f;
    }
    return 270.f;
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WHSendTableViewCell *cell = [WHSendTableViewCell cellWithTableView:tableView withRole:WHSendRole_Self];
        return cell;
    } else if (indexPath.section == 1) {
        WHSendTableViewCell *cell = [WHSendTableViewCell cellWithTableView:tableView withRole:WHSendRole_Friend];
        return cell;
    } else {
        WHSendTableViewCell *cell = [WHSendTableViewCell cellWithTableView:tableView withRole:WHSendRole_Doctor];
        return cell;
    }
}

#pragma mark -- Action
- (void)confirmAction{
    if (self.selectArr.count == 0) {
        self.errView.hidden = NO;
        [self.view bringSubviewToFront:self.errView];
        return;
    }
    
    
    
//    [self.navigationController pushViewController:[WHWechatInviteViewController new] animated:YES];
//    [self presentViewController:[WHWechatInviteViewController new] animated:YES completion:nil];
    
//    [self showErrorAlertViewController];
}

- (void)showErrorAlertViewController{
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:QMUIAlertControllerStyleAlert];
    [alertController addAction:[QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[QMUIAlertAction actionWithTitle:@"前往设置" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    }]];
    [alertController showWithAnimated:YES];
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

- (NSMutableArray *)selectArr{
    if (!_selectArr) {
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}

- (NSMutableArray *)friendArr{
    if (!_friendArr) {
        _friendArr = [NSMutableArray array];
    }
    return _friendArr;
}

- (WHSendErrorView *)errView{
    if (!_errView ) {
        _errView = [WHSendErrorView new];
        @weakify(self)
        _errView.pressBtnAction = ^(NSInteger type) {
            @strongify(self)
            self.errView.hidden = YES;
            [self.view sendSubviewToBack:self->_errView];
        };
    }
    return _errView;
}

@end



