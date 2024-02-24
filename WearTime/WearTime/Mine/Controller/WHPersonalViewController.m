//
//  WHPersonalViewController.m
//  WearTime
//
//  Created by layne on 2023/7/7.
//

#import "WHPersonalViewController.h"
#import "WHInfoShowTableViewCell.h"
#import "WHMainTableViewCell.h"
#import "WHPersonalInfoViewController.h"
#import "WHMouldMViewController.h"
#import "WHListsViewController.h"
#import "WHSendViewController.h"
#import "WHSendTimeViewController.h"
#import "WHLoginViewController.h"

@interface WHPersonalViewController () <QMUITableViewDelegate,QMUITableViewDataSource>

@property(nonatomic, strong) QMUITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic, strong) QMUILabel *mTitleLabel;
@property(nonatomic, strong) WHInfoShowTableViewCell *infoCell;  // 用户信息展示
@property(nonatomic, strong) WHMainTableViewCell *personalCell;  // 个人资料
@property(nonatomic, strong) WHMainTableViewCell *detailCell;  // 体检报告项目清单
@property(nonatomic, strong) WHMainTableViewCell *tempCell;  // 体检报告魔板选择
@property(nonatomic, strong) WHMainTableViewCell *sendCell;  // 发送给谁
@property(nonatomic, strong) WHMainTableViewCell *timeCell;  // 时间
@property(nonatomic, strong) WHMainTableViewCell *logOutCell;  // 退出登录

@property(nonatomic, strong) UIStackView *mStackView;
@property(nonatomic, strong) QMUIButton *mineBtn;
@property(nonatomic, strong) QMUIButton *sendBtn;

@property(nonatomic, strong) WHUserModel *myUserModel;

@end

@implementation WHPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"个人中心";
    self.view.backgroundColor = ColorHex(@"#F2F1F6");
    [self.view addSubview:self.mTitleLabel];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.mStackView];
    
    [self.mTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17.5f);
        make.top.mas_equalTo(NavigationBarHeight + 40.f);
    }];
    

    [self.mStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(IsIphoneX ? 80.f : 60.f);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mTitleLabel.mas_bottom).offset(5.f);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mStackView.mas_top);
    }];
    
    [self getData];
}

- (void)getData{
    @weakify(self)
    [WHWearTimeApi getUserInfoWithTokenOnSuccess:^(WHUserModel * _Nonnull userModel) {
        @strongify(self)
        self.myUserModel = userModel;
        [[WHUserInfo sharedInfo] saveUserInfoWithModel:userModel];
        [self.tableView reloadData];
    } onFailure:^(NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
    }];
    
}

#pragma mark -- QMUITableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat height = 10;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    headView.backgroundColor = ColorHex(@"#f5f5f5");
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80.f;
    }
    return 50.f;
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 5;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WHInfoShowTableViewCell *cell = [WHInfoShowTableViewCell cellWithTableView:self.tableView];
        [cell setModel:self.myUserModel];
        return cell;
    } else if (indexPath.section == 1) {
        NSArray *imgArr = @[@"个人资料",@"报告清单",@"报告模板",@"报告发送",@"报告时间"];
        NSArray *titleArr = @[@"个人资料",@"体检报告项目清单",@"体检报告模板选择",@"体检报告发送给谁",@"体检报告自动发送时间"];
        WHMainTableViewCell *cell = [WHMainTableViewCell cellWithTableView:self.tableView];
        cell.iconImageView.image = [UIImage imageNamed:imgArr[indexPath.row]];
        cell.userName.text = titleArr[indexPath.row];
        return cell;
    } else {
        WHMainTableViewCell *cell = [WHMainTableViewCell cellWithTableView:self.tableView];
        cell.iconImageView.image = [UIImage imageNamed:@"退出登录"];
        cell.userName.text = @"退出登录";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return;
            break;
            
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self.navigationController pushViewController:[WHPersonalInfoViewController new] animated:YES];
                }
                    break;
                    
                case 1:
                {
                    
                    [self.navigationController pushViewController:[WHListsViewController new] animated:YES];
                }
                    break;
                    
                case 2:
                {
                    [self.navigationController pushViewController:[WHMouldMViewController new] animated:YES];
                }
                    break;
                    
                case 3:
                {
                    [self.navigationController pushViewController:[WHSendViewController new] animated:YES];
                }
                    break;
                    
                case 4:
                {
                    [self.navigationController pushViewController:[WHSendTimeViewController new] animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 2:{
            [self loginOut];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- Action
- (void)loginOut{
    
    [WHWearTimeApi logOutOnSuccess:^{
        NSLog(@"退出成功");
    } onFailure:^(NSError * _Nonnull error) {
        NSLog(@"退出失败");
    }];
    
    UIViewController *rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootController isKindOfClass:[WHBaseNavigationViewController class]]) {
        WHBaseNavigationViewController *navController = (WHBaseNavigationViewController *)rootController;
        if ([navController.topViewController isKindOfClass:[WHLoginViewController class]]) {
            return;
        }
    }
    WHLoginViewController *viewController = [WHLoginViewController new];
    WHBaseNavigationViewController *loginNavController = [[WHBaseNavigationViewController alloc] initWithRootViewController:viewController];
    [UIApplication sharedApplication].delegate.window.rootViewController = loginNavController;
        [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:WHUserToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -- lazy
- (QMUILabel *)mTitleLabel{
    if (!_mTitleLabel) {
        _mTitleLabel = [QMUILabel new];
        _mTitleLabel.text = @"个人中心";
        _mTitleLabel.font = [UIFont boldSystemFontOfSize:24];
        _mTitleLabel.textColor = ColorHex(@"#111111");
    }
    return _mTitleLabel;
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
        [_mStackView addArrangedSubview:self.sendBtn];
        [_mStackView addArrangedSubview:self.mineBtn];
    }
    return _mStackView;
}


- (QMUIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"手动发送报告" forState:UIControlStateNormal];
        [_sendBtn setImage:[UIImage imageNamed:@"形状 858 拷贝"] forState:UIControlStateNormal];
        [_sendBtn setTitleColor:ColorHex(@"#969698") forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = Font(10.f);
        _sendBtn.imagePosition = QMUIButtonImagePositionTop;
        _sendBtn.userInteractionEnabled = NO;
    }
    return _sendBtn;
}

- (QMUIButton *)mineBtn{
    if (!_mineBtn) {
        _mineBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_mineBtn setTitle:@"我的" forState:UIControlStateNormal];
        [_mineBtn setImage:[UIImage imageNamed:@"mine"] forState:UIControlStateNormal];
        [_mineBtn setTitleColor:WHBaseTextColor forState:UIControlStateNormal];
        _mineBtn.titleLabel.font = Font(10.f);
        _mineBtn.imagePosition = QMUIButtonImagePositionTop;
        _mineBtn.userInteractionEnabled = NO;
    }
    return _mineBtn;
}

@end
