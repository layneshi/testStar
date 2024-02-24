//
//  WHSendTimeModel.h
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHSendTimeModel : NSObject

@property(nonatomic, assign) NSInteger day;    // 是否每天发送 1是 0否(默认传0)
@property(nonatomic, assign) NSInteger hour;
@property(nonatomic, copy)   NSString *ID;
@property(nonatomic, assign) NSInteger intervalDays;    // 间隔发送天数
@property(nonatomic, assign) NSInteger minutes;
@property(nonatomic, copy)   NSString *nextSendTime;    // 下次发送时间(此参数后台计算不用传)
@property(nonatomic, assign) NSInteger reportId;
@property(nonatomic, assign) NSInteger week;    // 每周几发送

@end

NS_ASSUME_NONNULL_END
