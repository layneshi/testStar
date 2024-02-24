//
//  WHAgreementView.m
//  WearTime
//
//  Created by layne on 2023/7/5.
//

#import "WHAgreementView.h"
#import "BEMCheckBox.h"
#import "NSAttributedString+Add.h"
#import "WHContentViewController.h"
#import "WHTipsView.h"

@interface WHAgreementView ()<UITextViewDelegate>
@property(nonatomic, strong) BEMCheckBox *checkBox;
@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) WHTipsView *tipsView;
@property(nonatomic, strong) QMUIModalPresentationViewController *modelPresentationViewController;
@end

@implementation WHAgreementView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {

    [self addSubview:self.checkBox];
    
    [self addSubview:self.textView];
    
    CGSize textSize = [self.textView sizeThatFits:CGSizeMake(SCREEN_WIDTH * 0.8, 100.f)];
    
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(15.f, 15.f));
//        make.centerY.equalTo(self);
        make.top.left.mas_equalTo(5.f);
//        make.left.mas_equalTo(self);
    }];
    
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
        make.left.equalTo(self.checkBox.mas_right).offset(5.f);
        make.size.sizeOffset(textSize);
//        make.centerY.equalTo(self.checkBox.mas_centerY);
        make.top.mas_equalTo(0.f);
    }];
}

- (BOOL)on {
    return self.checkBox.on;
}

- (void)setDefaultOnStatus:(BOOL)onStatus {
    self.checkBox.on = onStatus;
}

- (void)layoutSubviews {
    [super layoutSubviews];

//    CGFloat space = (self.width - self.textView.size.width + self.checkBox.width) / 2.f;
//
//    [self.checkBox mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(space);
//    }];
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction API_AVAILABLE(ios(10.0)) {
    if ([URL.absoluteString isEqualToString:@"1"] || [URL.absoluteString isEqualToString:@"2"] || [URL.absoluteString isEqualToString:@"3"]) {
        QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
        modalViewController.animationStyle = QMUIModalPresentationAnimationStyleSlide;
        modalViewController.contentView = self.tipsView;
        //虽说layoutBlock 重写了该属性就无效了 不过还是会影响 contentViewDefaultFrame 中的 contentViewDefaultFrame
        modalViewController.contentViewMargins = UIEdgeInsetsMake(0, 10, 0, 10);
        @weakify(self)
        modalViewController.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
            @strongify(self)
            self.tipsView.qmui_frameApplyTransform = CGRectMake(25.f, KSHEIGHT / 2 - 160.f, 325, 312.5);
//            CGRectSetXY(self.tipsView.frame, CGFloatGetCenter(CGRectGetWidth(containerBounds), CGRectGetWidth(self.tipsView.frame)), CGRectGetHeight(containerBounds) - 20 - CGRectGetHeight(self.tipsView.frame));
//            NSLog(@"frameis %@ %@",@(self.tipsView.origin.x), @(self.tipsView.origin.y));
        };
        [modalViewController showWithAnimated:YES completion:nil];
        self.modelPresentationViewController = modalViewController;
        
        
        return NO;
    }
    return YES;
}

#pragma mark -- Action
- (void)hiddenModelViewController{
    if (self.modelPresentationViewController) {
        [self.modelPresentationViewController hideWithAnimated:YES completion:nil];
        self.modelPresentationViewController = nil;
    }
}

#pragma mark - lazy
- (BEMCheckBox *)checkBox {
    if (nil == _checkBox) {
        _checkBox = [BEMCheckBox new];
        _checkBox.onTintColor = WHBaseTextColor;
        _checkBox.onCheckColor = WHBaseTextColor;
        _checkBox.animationDuration = 0.4;
//        _checkBox.hidden = YES;
        _checkBox.qmui_outsideEdge = UIEdgeInsetsMake(-10, -10, -10, -10);
    }
    return _checkBox;
}

- (UITextView *)textView {
    if (nil == _textView) {
        _textView = [UITextView new];
        _textView.delegate = self;
        _textView.editable = NO;
        UIFont *textFont =  IS_320WIDTH_SCREEN ? Font(10.f) : Font(11.f);
        _textView.linkTextAttributes = @{NSForegroundColorAttributeName: WHBaseTextColor };
        // [NSString stringWithFormat:@"%@%@ %@ %@",@"",@"《用户协议》",@"和",@"《隐私政策》"]
        _textView.attributedText = [NSMutableAttributedString makeAttributedWithText:[NSString stringWithFormat:@"%@%@%@%@%@",@"我已经阅读并同意",@"《时刻体验用户协议》",@"《时刻体验隐私策略》",@"和",@"《中国移动认证服务条款》"]
                                                                            keyWords:@[@"《时刻体验用户协议》",@"《时刻体验隐私策略》",@"《中国移动认证服务条款》"]
                                                                            urlArray:@[@"1",@"2",@"3"]
                                                                     normalTextColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]
                                                                        keyWordColor:WHBaseTextColor
                                                                                font:textFont];
    }
    return _textView;
}

- (WHTipsView *)tipsView{
    if (!_tipsView) {
        _tipsView = [WHTipsView new];
        _tipsView.layer.cornerRadius = 16.f;
        @weakify(self)
        _tipsView.clickTypeAction = ^(WHLoginTipType type) {
            @strongify(self)
            [self hiddenModelViewController];
            [[self qmui_viewController].navigationController pushViewController:[WHContentViewController new] animated:YES];
        };
        _tipsView.clickAgreeAction = ^{
            @strongify(self)
            [self hiddenModelViewController];
        };
        _tipsView.clickCloseAction = ^{
            @strongify(self)
            [self hiddenModelViewController];
        };
    }
    return _tipsView;
}

@end
