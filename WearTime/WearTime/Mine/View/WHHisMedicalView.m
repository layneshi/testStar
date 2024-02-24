//
//  WHHisMedicalView.m
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import "WHHisMedicalView.h"
#import "WHListsTableViewCell.h"

@interface WHHisMedicalView () <QMUITableViewDelegate,QMUITableViewDataSource>

@property(nonatomic, strong) QMUITableView *tableView;
@property(nonatomic, strong) NSMutableArray *selectArray;

@end

@implementation WHHisMedicalView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ColorHex(@"#666666") colorWithAlphaComponent:0.5];
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.height.mas_equalTo(250.f);
        }];
//
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction:)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark -- Action
- (void)dismissAction:(UIGestureRecognizer *)tap{
    [UIView animateWithDuration:0.1 animations:^{
        self.hidden = YES;;
    }];
}


- (void)giveUpAction{
    [UIView animateWithDuration:0.1 animations:^{
        self.hidden = YES;;
    }];
}

- (void)confirmAction{
    [UIView animateWithDuration:0.1 animations:^{
        self.hidden = YES;;
    }];
    if (self.backWithArr){
        self.backWithArr(self.selectArray);
    }
}

- (void)reloadTableViewWithaArr:(NSArray *)arr{
    self.hisArr = [NSArray arrayWithArray:arr];
    [self.tableView reloadData];
}

#pragma mark -- UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat height = 50;//section == 2 ? 36.f : 10.f;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    headView.backgroundColor = [UIColor clearColor];
    
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"父母、祖父母、外祖父母曾确诊过一下疾病的请选择:";
    titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    titleLabel.textColor = ColorHex(@"#282828");
    titleLabel.numberOfLines = 0;
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headView);
        make.left.mas_equalTo(18.5f);
        make.right.mas_equalTo(-15.f);
    }];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGFloat height = 60;//section == 2 ? 36.f : 10.f;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    headView.backgroundColor = [UIColor clearColor];
    
    QMUIButton *giveUpBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    giveUpBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [giveUpBtn setTitle:@"放弃" forState:UIControlStateNormal];
    [giveUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [giveUpBtn setBackgroundColor:WHBaseTextColor];
    giveUpBtn.layer.cornerRadius = 10.f;
    giveUpBtn.layer.masksToBounds = YES;
    [giveUpBtn addTarget:self action:@selector(giveUpAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    QMUIButton *confirmBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:WHBaseTextColor];
    confirmBtn.layer.cornerRadius = 10.f;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:giveUpBtn];
    [headView addSubview:confirmBtn];
    
    [giveUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22.5f);
        make.height.mas_equalTo(46.f);
        make.width.mas_equalTo(158.f);
        make.centerY.equalTo(headView);
    }];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-22.5f);
        make.height.mas_equalTo(46.f);
        make.width.mas_equalTo(158.f);
        make.centerY.equalTo(headView);
    }];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WHListsTableViewCell *cell = [WHListsTableViewCell cellWithTableView:tableView];
    cell.titleLabel.text = self.hisArr[indexPath.row];
    @weakify(self)
    @weakify(cell)
    cell.cellPress = ^{
        @strongify(self)
        @strongify(cell)
        NSLog(@"statd %@",@(cell.checkBox.on));
        if (!cell.checkBox.on ){
            if (![self.selectArray containsObject:self.hisArr[indexPath.row]]) {
                [self.selectArray addObject:self.hisArr[indexPath.row]];
            }
            cell.checkBox.on = YES;
        } else {
            if ([self.selectArray containsObject:self.hisArr[indexPath.row]]) {
                [self.selectArray removeObject:self.hisArr[indexPath.row]];
            }
            cell.checkBox.on = NO;
        }
    };
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//}


#pragma mark -- lazy
- (QMUITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ColorHex(@"#f2f1f6");
        _tableView.separatorColor = ColorHex(@"#f2f1f6");
        _tableView.layer.cornerRadius = 10.f;
//        _tableView.rowHeight = 55.f;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60.f)];
    }
    return _tableView;
}

- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

@end
