//
//  WHPhoneViewController.m
//  WearTime
//
//  Created by layne on 2023/7/10.
//

#import "WHPhoneViewController.h"
#import "WHPhoneCodeTableViewCell.h"

@interface WHPhoneViewController () <QMUITableViewDelegate,QMUITableViewDataSource>

@property(nonatomic, strong) QMUITableView *tableView;

@end

@implementation WHPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorHex(@"#f2f1f7");
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
    WHPhoneCodeTableViewCell *cell = [WHPhoneCodeTableViewCell cellWithTableView:self.tableView];
    cell.name.text = @"+86 (中国大陆)";
    return cell;
}

#pragma mark -- lazy
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

@end
