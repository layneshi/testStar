//
//  WHBaseViewController.h
//  WearTime
//
//  Created by layne on 2023/7/5.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHBaseViewController : QMUICommonViewController

/// 设置导航栏右侧按钮
/// @param text 按钮文字
- (void)base_setRightItemWithText:(NSString *)text;

/// 设置导航栏左侧按钮
/// @param text 按钮文字
- (void)base_setLeftItemWithText:(NSString *)text;

/// 设置导航栏左侧按钮
/// @param image 按钮图片
- (void)base_setLeftItemWithImage:(UIImage *)image;

/// 导航栏右侧按钮点击事件
- (void)base_clickRightItemAction;

/// 导航栏左侧按钮点击事件
- (void)base_ClickLeftItemAction;

/// 返回按钮点击事件 ，子类可根据不同需求重写此方法
- (void)base_backAction;

#pragma mark - 样式
- (void)setBackItemTintColor:(UIColor *)tintColor;

@end

NS_ASSUME_NONNULL_END
