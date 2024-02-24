//
//  WHOtherLoginView.h
//  WearTime
//
//  Created by layne on 2023/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    OtherLogin_Wechat         = 0, //微信
    OtherLogin_Apple     = 1, // 苹果ID
} OtherLoginType;

@interface WHOtherLoginView : UIView

@property(nonatomic, copy) void (^otherLoginAction)(OtherLoginType type);

@end

NS_ASSUME_NONNULL_END
