//
//  WHSendTimeViewController.h
//  WearTime
//
//  Created by layne on 2023/7/9.
//

#import "WHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WHSendTimeViewController : WHBaseViewController

@end



@interface WHSendHeadView : UIView

@end

@interface WHSendSelectView : UIView


- (void)updateTitleWithStr:(NSString *)title;

@property(nonatomic, copy) void (^selectTimeBlock) (void);

@end

NS_ASSUME_NONNULL_END
