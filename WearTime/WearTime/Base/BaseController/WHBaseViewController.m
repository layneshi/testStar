//
//  WHBaseViewController.m
//  WearTime
//
//  Created by layne on 2023/7/5.
//

#import "WHBaseViewController.h"

@interface WHBaseViewController () <UINavigationControllerBackButtonHandlerProtocol,QMUINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic, strong) QMUIButton *backBtn;

@end

@implementation WHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [self configNavbar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:[self preferredNavigationBarHidden] animated:YES];
    }
    
    self.navigationController.interactivePopGestureRecognizer.enabled = [self enabledPopGestureRecognizer];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self updateNavigationBarAppearance];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)configNavbar {
    self.titleView.needsLoadingView = YES;
    self.navigationController.delegate = self;
    [self updateNavigationBarAppearance];
}

#pragma mark - action
- (void)base_setRightItemWithText:(NSString *)text {
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStylePlain target:self action:@selector(base_clickRightItemAction)];
    navItem.tintColor = WHBaseTextColor;
    self.navigationItem.rightBarButtonItem = navItem;
}

- (void)base_clickRightItemAction {
    
}

- (void)base_setLeftItemWithText:(NSString *)text {
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStylePlain target:self action:@selector(base_ClickLeftItemAction)];
    navItem.tintColor = WHBaseTextColor;
    self.navigationItem.leftBarButtonItem = navItem;
}

- (void)base_setLeftItemWithImage:(UIImage *)image{
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(base_ClickLeftItemAction)];
    navItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = navItem;
}

- (void)base_ClickLeftItemAction {
    [self base_backAction];
}

- (void)base_backAction {
    if (!self.navigationController) {
        //导航栏不存在
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    if (self.navigationController && self.navigationController.viewControllers.count == 1) {
        //已经是导航栏最顶层
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    //正常pop
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showLoading {
    self.titleView.loadingViewHidden = NO;
}

- (void)hideLoading {
    self.titleView.loadingViewHidden = YES;
}

- (void)setBackItemTintColor:(UIColor *)tintColor {
    self.backBtn.tintColor = tintColor;
}

#pragma mark - UIGestureRecognizerDelegate

//返回 YES 则由qmuikit接管controller的显示隐藏 每个controller的导航栏都是单独维护的
//通过 - (BOOL)preferredNavigationBarHidden; 控制
//- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
//    return YES;
//}

- (BOOL)preferredNavigationBarHidden {
    return NO;
}


- (BOOL)enabledPopGestureRecognizer {
    return YES;
}

#pragma mark - StatusBarStyle
- (UIStatusBarStyle)preferredStatusBarStyle {
   return UIStatusBarStyleDefault;
}

#pragma mark - UINavigationControllerBackButtonHandlerProtocol
- (BOOL)forceEnableInteractivePopGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

#pragma mark - lazy
- (QMUIButton *)backBtn {
    if (nil == _backBtn) {
        _backBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"wh_baseback"] forState:UIControlStateNormal];
        _backBtn.frame = CGRectMake(0, 0, 30, 30);
        [_backBtn setQmui_outsideEdge:UIEdgeInsetsMake(0.f, -10.f, 0.f, -10.f)];
        [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_backBtn setImagePosition:QMUIButtonImagePositionLeft];
        [_backBtn addTarget:self action:@selector(base_backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

@end
