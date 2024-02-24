//
//  WHBirthDayView.h
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHBirthDayView : UIView

@property (nonatomic, copy) void (^selectBirthDayAction)(NSString *day);

@end

NS_ASSUME_NONNULL_END
