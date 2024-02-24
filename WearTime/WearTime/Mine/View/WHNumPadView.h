//
//  WHNumPadView.h
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHNumPadView : UIView

@property(nonatomic, strong) QMUIGridView *gridView;

@property(nonatomic, copy) void (^selectNum)(NSString *num);

// 放弃
@property(nonatomic, copy) void (^giveUpAction)(void);

// 确认
@property(nonatomic, copy) void (^confirmAction)(void);

@end



NS_ASSUME_NONNULL_END
