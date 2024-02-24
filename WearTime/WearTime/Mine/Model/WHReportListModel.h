//
//  WHReportListModel.h
//  WearTime
//
//  Created by layne on 2023/7/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHReportListModel : NSObject

@property(nonatomic, assign) NSInteger acticvityEnergy;  // 活动能量
@property(nonatomic, assign) NSInteger activity;           // 活动（千卡）
@property(nonatomic, assign) NSInteger aerobicFitness;       // 有氧适能
@property(nonatomic, assign) NSInteger aerobicFitnessNotice;   // 有氧适能通知
@property(nonatomic, assign) NSInteger aerobicRecovery;    // 有氧恢复
@property(nonatomic, assign) NSInteger asymmetricGait;    //  步伐不对称
@property(nonatomic, assign) NSInteger bipedalSupportTime;   //  双足支撑时间

@property(nonatomic, assign) NSInteger bloodOxygen;    //  血氧
@property(nonatomic, assign) NSInteger climbedFloors;    //  已爬楼层
@property(nonatomic, assign) NSInteger coreSleep;       //  核心睡眠
@property(nonatomic, assign) NSInteger deepSleep;     //  深度睡眠
@property(nonatomic, assign) NSInteger electrocardiogram;    //  心电图
@property(nonatomic, assign) NSInteger exercise;        // 锻炼（分钟
@property(nonatomic, assign) NSInteger exerciseMinutes;  // 锻炼分钟数

@property(nonatomic, assign) NSInteger heartRate;   //  心率(次数/分钟)
@property(nonatomic, assign) NSInteger heartRateVariability; //  心率变异性
@property(nonatomic, assign) NSInteger highHeartRate;   //  高心率通知
@property(nonatomic, copy) NSString *ID;  //
@property(nonatomic, assign) NSInteger infoId;  //  用户信息id
@property(nonatomic, assign) NSInteger ladderClimbingSpeedDown;  //  爬梯速度：下楼
@property(nonatomic, assign) NSInteger ladderClimbingSpeedUp;  //  爬梯速度：上楼

@property(nonatomic, assign) NSInteger lowHeartRate;   //  低心率通知
@property(nonatomic, assign) NSInteger mobilePulseRateAtrialFibrillation;  //  移动脉率房颤通知
@property(nonatomic, assign) NSInteger physicalFitnessTraining;   //  体能训练（分钟）
@property(nonatomic, assign) NSInteger remsleep;   //  呼吸频率
@property(nonatomic, assign) NSInteger respiratoryRate;  //  呼吸频率
@property(nonatomic, assign) NSInteger restingEnergy; //  静息能量
@property(nonatomic, assign) NSInteger restingHeartRate;  //  静息心率

@property(nonatomic, assign) NSInteger runSpeed;   // 跑步速度
@property(nonatomic, assign) NSInteger runningPower;  // 跑步功率
@property(nonatomic, assign) NSInteger runningStrideLength;   // 跑步步长
@property(nonatomic, assign) NSInteger sixMinuteWalk;  // 六分钟步行
@property(nonatomic, assign) NSInteger standing;   // 站立（小时）
@property(nonatomic, assign) NSInteger standingHour;   // 站立小时数
@property(nonatomic, assign) NSInteger standingMinutes;  // 站立分钟数

@property(nonatomic, assign) NSInteger step;   // 步数
@property(nonatomic, assign) NSInteger walkingAvgHeartRate;  // 步行平均心率
@property(nonatomic, assign) NSInteger walkingRunningDistance;    // 步行+跑步距离
@property(nonatomic, assign) NSInteger walkingSpeed;  // 步行速度
@property(nonatomic, assign) NSInteger walkingStability;  // 步行稳定性
@property(nonatomic, assign) NSInteger walkingStrideLength;  // 步行步长
@property(nonatomic, assign) NSInteger wristTemperature;   // 手腕温度
 
@end

NS_ASSUME_NONNULL_END
