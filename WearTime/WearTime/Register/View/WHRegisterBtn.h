//
//  WHRegisterBtn.h
//  WearTime
//
//  Created by layne on 2023/7/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHRegisterBtn : UIView

@property(nonatomic, copy) void (^clickBtn)(void);

- (void)setBtnTitle:(NSString *)title;

- (void)changeBtnStatus:(BOOL)isSelect;

@end

NS_ASSUME_NONNULL_END
