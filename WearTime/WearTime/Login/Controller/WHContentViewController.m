//
//  WHContentViewController.m
//  WearTime
//
//  Created by layne on 2023/7/6.
//

#import "WHContentViewController.h"

@interface WHContentViewController ()

@property(nonatomic, strong) QMUITextView *mTextView;;

@end

@implementation WHContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"协议内容";
    self.view.backgroundColor = ColorHex(@"#F2F1F6");
    [self.view addSubview:self.mTextView];
    [self.mTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationBarHeight + 20.f);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(200.f);
    }];
}

#pragma mark -- lazy
- (QMUITextView *)mTextView{
    if (!_mTextView) {
        _mTextView = [QMUITextView new];
        _mTextView.backgroundColor = [UIColor whiteColor];
        _mTextView.font = Font(14.f);
        _mTextView.text = @"用户单击《时刻体检用户协议》或者《时刻体检隐 私政策》或者《认证服务协议》；查看对应的协议 内容展示内容，用户单击《时刻体检用户协议》或者《时刻体检隐 私政策》或者《认证服务协议》；查看对应的协议 内容展示内容，用户单击《时刻体检用户协议》或者《时刻体检隐 私政策》或者《认证服务协议》；查看对应的协议 内容展示内容，用户单击《时刻体检用户协议》或者《时刻体检隐 私政策》或者《认证服务协议》；查看对应的协议 内容展示内容，";
    }
    return _mTextView;
}

@end
