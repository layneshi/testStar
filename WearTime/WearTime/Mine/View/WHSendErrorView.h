//
//  WHSendErrorView.h
//  WearTime
//
//  Created by layne on 2023/7/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    WHBtnPressType_Continue        = 0, // 继续
    WHBtnPressType_NotYet     = 1, // 暂时不填
} WHBtnPressType;


@interface WHSendErrorView : UIView

@property(nonatomic, copy) void (^pressBtnAction)(NSInteger type);

@end


@interface WHErrorTipsView : UIView

@property(nonatomic, copy) void (^pressBtnAction)(NSInteger type);

@end

NS_ASSUME_NONNULL_END
