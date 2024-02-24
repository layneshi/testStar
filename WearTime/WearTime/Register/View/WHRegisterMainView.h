//
//  WHRegisterMainView.h
//  WearTime
//
//  Created by layne on 2023/7/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHRegisterMainView : UIView

@property(nonatomic, strong) QMUIButton *codeButton;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) QMUITextField *textField;

@end

@interface WHRegisterCodeField : UIView

@property(nonatomic, strong) QMUIButton *sendCodeBtn;
@property(nonatomic, strong) QMUITextField *textField;


@property(nonatomic, copy) void (^getPhoneCodeAction) (void);

@end

NS_ASSUME_NONNULL_END
