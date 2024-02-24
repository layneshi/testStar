//
//  WHSelectSendTimeView.h
//  WearTime
//
//  Created by layne on 2023/7/10.
//

#import <UIKit/UIKit.h>
#import "WHSendTimeModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface WHSelectSendTimeView : UIView


@property (nonatomic, copy) void (^blockPickView)(NSString *showString, WHSendTimeModel *timeModel);

@end


@interface WHTimePickView : UIView

/// 刷新pickview的数据
- (void)reloadPickViewData:(WHPickViewType)type;

@property (nonatomic, copy) void (^blockPickView)(NSString *showString, WHSendTimeModel *timeModel);

@end

NS_ASSUME_NONNULL_END
