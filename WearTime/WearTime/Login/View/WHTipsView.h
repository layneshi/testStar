//
//  WHTipsView.h
//  WearTime
//
//  Created by layne on 2023/7/6.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WHLoginTi_Agreement         = 0, //用户协议
    WHLoginTi_Polic     = 1, // 隐私策略
    WHLoginTi_Term    = 2, // 移动认证服务条款
} WHLoginTipType;

NS_ASSUME_NONNULL_BEGIN

@interface WHTipsView : UIView

@property(nonatomic, copy) void(^clickCloseAction) (void);

@property(nonatomic, copy) void(^clickTypeAction) (WHLoginTipType type);

@property(nonatomic, copy) void(^clickAgreeAction) (void);

@end

NS_ASSUME_NONNULL_END
