//
//  WHGetHealthyKit.h
//  WearTime
//
//  Created by layne on 2023/7/10.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
#import <UIKit/UIDevice.h>

#define HKVersion [[[UIDevice currentDevice] systemVersion] doubleValue]
#define CustomHealthErrorDomain @"com.sdqt.healthError"

NS_ASSUME_NONNULL_BEGIN

@interface WHGetHealthyKit : NSObject


@property (nonatomic, strong) HKHealthStore *healthStore;

/**
 创建单例对象~

 @return self
 */
+(instancetype)shareInstance;
/*
 *  @brief  检查是否支持获取健康数据
 */
- (void)authorizeHealthKit:(void(^)(BOOL success, NSError *error))compltion;

//获取步数
- (void)getStepCount:(void(^)(double value, NSError *error))completion;

//获取公里数
- (void)getDistance:(void(^)(double value, NSError *error))completion;

//获取运动时间
- (void)getTime:(void(^)(double value, NSError *error))completion;

//活动能量 千卡
-(void)getActiveEnergy:(void(^)(double value, NSError *error))completion;







// 获取心率数据
- (void)getHeatBaret:(void(^)(double value, NSError *error))completion;

// 获取血氧饱和度数据
- (void)getBloodOxygen:(void(^)(double value, NSError *error))completion;

// 获取皮电活动数据 HKQuantityTypeIdentifierElectrodermalActivity
- (void)getElectrodermal:(void(^)(double value, NSError *error))completion;

// 获取收缩压
- (void)getBloodPressureSystolic:(void(^)(double value, NSError *error))completion;

// 获取舒张压
- (void)getBloodPressureDiastolic:(void(^)(double value, NSError *error))completion;

// 获取血糖
- (void)getBloodGlucose:(void(^)(double value, NSError *error))completion;

// 获取睡眠质量
- (void)getSleepQuality:(void(^)(double value, NSError *error))completion;

// 获取心电图
- (void)getECG:(void(^)(double value, NSError *error))completion;


/**
 添加运动步数

 @param value 步数
 @param unit 单位
 @param completion 错误码
 */
-(void)addStepsValue:(double)value unit:(HKUnit *)unit state:(void(^)(BOOL success, NSError *error))completion;


/**
 添加饮水量

 @param value 水量
 @param unit 单位
 @param completion 状态码
 */
-(void)addWaterQuantity:(double)value unit:(HKUnit *)unit state:(void(^)(BOOL success, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
