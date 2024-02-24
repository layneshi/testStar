//
//  WHGetHealthyKit.m
//  WearTime
//
//  Created by layne on 2023/7/10.
//

#import "WHGetHealthyKit.h"
#import <HealthKit/HealthKit.h>

@implementation WHGetHealthyKit

/**
 创建单例对象

 */
+(instancetype)shareInstance
{
    static id manager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

/*
 *  @brief  检查是否支持获取健康数据
 */
- (void)authorizeHealthKit:(void(^)(BOOL success, NSError *error))compltion
{
    if(HKVersion >= 8.0)
    {
        if (![HKHealthStore isHealthDataAvailable]) {
            NSError *error = [NSError errorWithDomain: @"com.raywenderlich.tutorials.healthkit" code: 2 userInfo: [NSDictionary dictionaryWithObject:@"HealthKit is not available in th is Device"                                                                      forKey:NSLocalizedDescriptionKey]];
            if (compltion != nil) {
                compltion(false, error);
            }
            return;
        }
        if ([HKHealthStore isHealthDataAvailable]) {
            if(self.healthStore == nil)
                self.healthStore = [[HKHealthStore alloc] init];
            /*
             组装需要读写的数据类型
             */
            NSSet *writeDataTypes = [self dataTypesToWrite];
            NSSet *readDataTypes = [self dataTypesRead];
            
            /*
             注册需要读写的数据类型，也可以在“健康”APP中重新修改
             */
            [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
                
                if (compltion != nil) {
                    NSLog(@"error->%@", error.localizedDescription);
                    compltion (success, error);
                }
            }];
        }
    }
    else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"iOS 系统低于8.0"                                                                      forKey:NSLocalizedDescriptionKey];
        NSError *aError = [NSError errorWithDomain:CustomHealthErrorDomain code:0 userInfo:userInfo];
        compltion(0,aError);
    }
}

/*!
 *  @brief  写权限
 *  @return 集合  HKQuantityTypeIdentifierHeartRate
 */
- (NSSet *)dataTypesToWrite
{
    //身高
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    //体重
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    //基础体温
    HKQuantityType *temperatureType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    //活动能量
    HKQuantityType *activeEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    //步数
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //步行+跑步距离
    HKQuantityType *distance = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    //水 HKQuantityTypeIdentifierDietaryWater
    HKQuantityType *waterType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryWater];
    
    // 心率
    HKQuantityType *heartType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    
    // 血氧饱和度
    HKQuantityType *oxygenType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierOxygenSaturation];
    
    // 心电图
    HKQuantityType *ElectrodermalType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierElectrodermalActivity];

    
    // 睡眠分析
    HKCategoryType *sleepType = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    
    // 收缩压
    HKQuantityType *bloodPressureSystolicType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    
    // 舒张压
    HKQuantityType *bloodPressureDiastolicType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];

    // 血糖  
    HKQuantityType *bloodGlucose = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    

    return [NSSet setWithObjects:heightType, temperatureType, weightType,activeEnergyType,stepCountType,distance,waterType,heartType,oxygenType,ElectrodermalType,sleepType,bloodPressureSystolicType,bloodPressureDiastolicType,bloodGlucose,nil];
    

    

}

/*!
 *  @brief  读权限
 *  @return 集合
 */
- (NSSet *)dataTypesRead
{
    //身高
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    //体重
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    //体温
    HKQuantityType *temperatureType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    //出生日期
    HKCharacteristicType *birthdayType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    //性别
    HKCharacteristicType *sexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
    //步数
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //步行+跑步距离
    HKQuantityType *distance = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    //活动能量
    HKQuantityType *activeEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    //水 HKQuantityTypeIdentifierDietaryWater
    HKQuantityType *waterType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryWater];
    
    //心率
    HKQuantityType *heartType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    
    // 血氧饱和度
    HKQuantityType *oxygenType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierOxygenSaturation];
    
    // 心电图
    HKQuantityType *ElectrodermalType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierElectrodermalActivity];
    
    // 睡眠
    HKCategoryType *sleepType = [HKCategoryType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    
    // 收缩压
    HKQuantityType *bloodPressureSystolicType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    
    // 舒张压
    HKQuantityType *bloodPressureDiastolicType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    
    // 血糖
    HKQuantityType *bloodGlucose = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    
    // 心电图
    if (@available(iOS 14.0, *)) {
        HKElectrocardiogramType *ecgType = HKObjectType.electrocardiogramType;
        return [NSSet setWithObjects:heightType, temperatureType,
                birthdayType,
                sexType,
                weightType,
                stepCountType,
                distance,
                activeEnergyType,
                waterType,
                heartType,
                oxygenType,
                ElectrodermalType,
                sleepType,
                bloodPressureSystolicType,
                bloodPressureDiastolicType,bloodGlucose,ecgType,nil];
    } else {
        // Fallback on earlier versions
        return [NSSet setWithObjects:heightType, temperatureType,
                birthdayType,
                sexType,
                weightType,
                stepCountType,
                distance,
                activeEnergyType,
                waterType,
                heartType,
                oxygenType,
                ElectrodermalType,
                sleepType,
                bloodPressureSystolicType,
                bloodPressureDiastolicType,bloodGlucose,nil];
    }
    

}

//获取步数
- (void)getStepCount:(void(^)(double value, NSError *error))completion
{
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    // Since we are interested in retrieving the user's latest sample, we sort the samples in descending order, and set the limit to 1. We are not filtering the data, and so the predicate is set to nil.
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:stepType predicate:[WHGetHealthyKit predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(error)
        {
            completion(0,error);
        }
        else
        {
            NSInteger totleSteps = 0;
            for(HKQuantitySample *quantitySample in results)
            {
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *heightUnit = [HKUnit countUnit];
                double usersHeight = [quantity doubleValueForUnit:heightUnit];
                totleSteps += usersHeight;
            }
            NSLog(@"当天行走步数 = %ld",(long)totleSteps);
            completion(totleSteps,error);
        }
    }];
    
    [self.healthStore executeQuery:query];
}

//获取公里数
- (void)getDistance:(void(^)(double value, NSError *error))completion
{
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    //HKObjectQueryNoLimit  HK对象查询无限制
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:distanceType predicate:[WHGetHealthyKit predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        if(error)
        {
            completion(0,error);
        }
        else
        {
            double totleSteps = 0;
            for(HKQuantitySample *quantitySample in results)
            {
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *distanceUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo];
                double usersHeight = [quantity doubleValueForUnit:distanceUnit];
                totleSteps += usersHeight;
            }
            NSLog(@"当天行走距离 = %.2f",totleSteps);
            completion(totleSteps,error);
        }
    }];
    [self.healthStore executeQuery:query];
}


/*!
 *  @brief  当天时间段
 *
 *  @return 时间段
 */
+ (NSPredicate *)predicateForSamplesToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    return predicate;
}

//获取运动时间
- (void)getTime:(void(^)(double value, NSError *error))completion
{
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //排序规则
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    //HKObjectQueryNoLimit 数量限制
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:stepType predicate:[WHGetHealthyKit predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(error)
        {
            completion(0,error);
        }
        else
        {
            double sumTime = 0;
            //获取数组
            for(HKQuantitySample *quantitySample in results){

                NSDateFormatter *fm=[[NSDateFormatter alloc]init];
                fm.dateFormat=@"yyyy-MM-dd HH:mm:ss";
                NSString *strNeedStart = [fm stringFromDate:quantitySample.startDate];
                NSLog(@"startDate %@",strNeedStart);
                NSString *strNeedEnd = [fm stringFromDate:quantitySample.endDate];
                NSLog(@"endDate %@",strNeedEnd);
                sumTime += [quantitySample.endDate timeIntervalSinceDate:quantitySample.startDate];
            }
            int h = sumTime / 3600;
            int m = ((long)sumTime % 3600)/60;
            int M = sumTime / 60;
            NSLog(@"运动时长：%@小时%@分", @(h), @(m));
            completion(M,error);
        }
    }];
    [self.healthStore executeQuery:query];
}


/**
 活动能量 千卡
 */
-(void)getActiveEnergy:(void(^)(double value, NSError *error))completion
{
    //活动能量
    HKQuantityType *activeEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:activeEnergyType predicate:[WHGetHealthyKit predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        if(error)
        {
            NSLog(@"错误----%@",error);
        }
        else
        {
            double totleSteps = 0;
            for(HKQuantitySample *quantitySample in results){
                
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *distanceUnit = [HKUnit kilocalorieUnit];
                double usersHeight = [quantity doubleValueForUnit:distanceUnit];
                totleSteps += usersHeight;
            }
            
            NSLog(@"活动能量--%f千卡",totleSteps);
            
            completion(totleSteps,error);
        }
    }];
    [self.healthStore executeQuery:query];
    
    
    
//    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:activeEnergyType quantitySamplePredicate:[AWHealthKitManage predicateForSamplesToday] options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error) {
//
//        if(error)
//        {
//            NSLog(@"错误----%@",error);
//        }
//        else
//        {
//            HKQuantity *sum = [result sumQuantity];
//
//            double value = [sum doubleValueForUnit:[HKUnit kilocalorieUnit]];
//            NSLog(@"%@卡路里--->%.2f",activeEnergyType.identifier,value);
////            DebugLog(@"%@卡路里 ---> %.2lf",quantityType.identifier,value);

//        }
//    }];
}


- (void)getHeatBaret:(void(^)(double value, NSError *error))completion{
    HKQuantityType *heartRateType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:heartRateType predicate:[WHGetHealthyKit predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(error)
        {
            completion(0,error);
        }
        else
        {
            if (@available(iOS 13.0, *)) {
                
                NSMutableArray *rateArr = [NSMutableArray array];
                
                for(HKDiscreteQuantitySample *quantitySample in results)
                {
                    
                    WHReportModel *reportModel = [WHReportModel new];
                    
                    
                    
                    HKUnit *heartRateUnit = [[HKUnit countUnit] unitDividedByUnit:[HKUnit minuteUnit]];
                    
                    HKQuantity *minimumQuantity = quantitySample.minimumQuantity;
                    double minRate = [minimumQuantity doubleValueForUnit:heartRateUnit];
                    
                    HKQuantity *averageQuantity = quantitySample.averageQuantity;
                    double averageRate = [averageQuantity doubleValueForUnit:heartRateUnit];
                    
                    
                    
                    HKQuantity *maximumQuantity  = quantitySample.maximumQuantity;
                    double maxRate = [maximumQuantity doubleValueForUnit:heartRateUnit];
                    
                    
                    HKQuantity *mostRecentQuantity = quantitySample.mostRecentQuantity;
                    double mostRecentRate = [mostRecentQuantity doubleValueForUnit:heartRateUnit];
                    
                    
                    NSString *startDate = [WHTools dateToStringWithDate:quantitySample.startDate];
                    NSString *endDate = [WHTools dateToStringWithDate:quantitySample.endDate];
                    
                    
//                    re
                    
                    
                    
                    NSLog(@"想要的心率 min :%@, max :%@, average :%@, mostRec :%@ 开始时间 :%@, 结束时:%@",@(minRate),@(maxRate),@(averageRate),@(mostRecentRate),startDate,endDate);

                }
            } else {
                // Fallback on earlier versions
            }
            completion(0,error);
        }
    }];
    
    [self.healthStore executeQuery:query];
}


// 获取血氧饱和度数据
- (void)getBloodOxygen:(void(^)(double value, NSError *error))completion{
    HKQuantityType *oxygenType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierOxygenSaturation];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    // Since we are interested in retrieving the user's latest sample, we sort the samples in descending order, and set the limit to 1. We are not filtering the data, and so the predicate is set to nil.
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:oxygenType predicate:[WHGetHealthyKit predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(error)
        {
            completion(0,error);
        }
        else
        {
            if (@available(iOS 13.0, *)) {
                for(HKDiscreteQuantitySample *quantitySample in results)
                {
                    HKUnit *oxygenUnit = [HKUnit percentUnit];
                    HKQuantity *minimumQuantity = quantitySample.minimumQuantity;
                    double minRate = [minimumQuantity doubleValueForUnit:oxygenUnit];
                    
                    HKQuantity *averageQuantity = quantitySample.averageQuantity;
                    double averageRate = [averageQuantity doubleValueForUnit:oxygenUnit];
                    
                    HKQuantity *maximumQuantity  = quantitySample.maximumQuantity;
                    double maxRate = [maximumQuantity doubleValueForUnit:oxygenUnit];
                                        
                    HKQuantity *mostRecentQuantity = quantitySample.mostRecentQuantity;
                    double mostRecentRate = [mostRecentQuantity doubleValueForUnit:oxygenUnit];
                    
                    
                    NSString *startDate = [WHTools dateToStringWithDate:quantitySample.startDate];
                    NSString *endDate = [WHTools dateToStringWithDate:quantitySample.endDate];
                    
                    
                    NSLog(@"想要的血氧饱和度 min :%@, max :%@, average :%@, mostRec :%@ 开始时间 :%@, 结束时:%@",@(minRate),@(maxRate),@(averageRate),@(mostRecentRate),startDate,endDate);

                }
            } else {
                // Fallback on earlier versions
            }
            completion(0,error);
        }
    }];
    
    [self.healthStore executeQuery:query];
}


- (void)getElectrodermal:(void(^)(double value, NSError *error))completion{
    HKQuantityType *ecgType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierElectrodermalActivity];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:ecgType predicate:[WHGetHealthyKit predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(error)
        {
            completion(0,error);
        }
        else
        {
            completion(0,error);
        }
    }];
    
    [self.healthStore executeQuery:query];
}

// 获取收缩压
- (void)getBloodPressureSystolic:(void(^)(double value, NSError *error))completion{
    HKQuantityType *ecgType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    // Since we are interested in retrieving the user's latest sample, we sort the samples in descending order, and set the limit to 1. We are not filtering the data, and so the predicate is set to nil.
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:ecgType predicate:[WHGetHealthyKit predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(error)
        {
            completion(0,error);
        }
        else
        {
            if (@available(iOS 13.0, *)) {
                for(HKDiscreteQuantitySample *quantitySample in results)
                {
                    HKUnit *bloodPressureDiastolicUnit = [HKUnit millimeterOfMercuryUnit];
                    HKQuantity *minimumQuantity = quantitySample.minimumQuantity;
                    double minRate = [minimumQuantity doubleValueForUnit:bloodPressureDiastolicUnit];
                    
                    HKQuantity *averageQuantity = quantitySample.averageQuantity;
                    double averageRate = [averageQuantity doubleValueForUnit:bloodPressureDiastolicUnit];
                    
                    HKQuantity *maximumQuantity  = quantitySample.maximumQuantity;
                    double maxRate = [maximumQuantity doubleValueForUnit:bloodPressureDiastolicUnit];
                                        
                    HKQuantity *mostRecentQuantity = quantitySample.mostRecentQuantity;
                    double mostRecentRate = [mostRecentQuantity doubleValueForUnit:bloodPressureDiastolicUnit];
                    
                    NSString *startDate = [WHTools dateToStringWithDate:quantitySample.startDate];
                    NSString *endDate = [WHTools dateToStringWithDate:quantitySample.endDate];
                    
                    
                    NSLog(@"想要的收缩压 min :%@, max :%@, average :%@, mostRec :%@ 开始时间 :%@, 结束时:%@",@(minRate),@(maxRate),@(averageRate),@(mostRecentRate),startDate,endDate);

                }
            } else {
                // Fallback on earlier versions
            }
            completion(0,error);
        }
    }];
    
    [self.healthStore executeQuery:query];
}

// 获取舒张压
- (void)getBloodPressureDiastolic:(void(^)(double value, NSError *error))completion{
    HKQuantityType *ecgType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:ecgType predicate:[WHGetHealthyKit predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(error)
        {
            completion(0,error);
        }
        else
        {
            if (@available(iOS 13.0, *)) {
                for(HKDiscreteQuantitySample *quantitySample in results)
                {
                    HKUnit *bloodPressureDiastolicUnit = [HKUnit millimeterOfMercuryUnit];
                    HKQuantity *minimumQuantity = quantitySample.minimumQuantity;
                    double minRate = [minimumQuantity doubleValueForUnit:bloodPressureDiastolicUnit];
                    
                    HKQuantity *averageQuantity = quantitySample.averageQuantity;
                    double averageRate = [averageQuantity doubleValueForUnit:bloodPressureDiastolicUnit];
                    
                    HKQuantity *maximumQuantity  = quantitySample.maximumQuantity;
                    double maxRate = [maximumQuantity doubleValueForUnit:bloodPressureDiastolicUnit];
                                        
                    HKQuantity *mostRecentQuantity = quantitySample.mostRecentQuantity;
                    double mostRecentRate = [mostRecentQuantity doubleValueForUnit:bloodPressureDiastolicUnit];
                    
                    NSString *startDate = [WHTools dateToStringWithDate:quantitySample.startDate];
                    NSString *endDate = [WHTools dateToStringWithDate:quantitySample.endDate];
                    
                    
                    NSLog(@"想要的舒张压 min :%@, max :%@, average :%@, mostRec :%@ 开始时间 :%@, 结束时:%@",@(minRate),@(maxRate),@(averageRate),@(mostRecentRate),startDate,endDate);

                }
            } else {
                // Fallback on earlier versions
            }
            completion(0,error);
        }
    }];
    
    [self.healthStore executeQuery:query];
}


// 获取血糖
- (void)getBloodGlucose:(void(^)(double value, NSError *error))completion{
    HKQuantityType *bloodGlucoseType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    // Since we are interested in retrieving the user's latest sample, we sort the samples in descending order, and set the limit to 1. We are not filtering the data, and so the predicate is set to nil.
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:bloodGlucoseType predicate:[WHGetHealthyKit predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(error)
        {
            completion(0,error);
        }
        else
        {
            if (@available(iOS 13.0, *)) {
                for(HKDiscreteQuantitySample *quantitySample in results)
                {
                    HKUnit *bloodGlucoseUnit = [HKUnit millimeterOfMercuryUnit];
                    HKQuantity *minimumQuantity = quantitySample.minimumQuantity;
                    double minRate = [minimumQuantity doubleValueForUnit:bloodGlucoseUnit];
                    
                    HKQuantity *averageQuantity = quantitySample.averageQuantity;
                    double averageRate = [averageQuantity doubleValueForUnit:bloodGlucoseUnit];
                    
                    HKQuantity *maximumQuantity  = quantitySample.maximumQuantity;
                    double maxRate = [maximumQuantity doubleValueForUnit:bloodGlucoseUnit];
                                        
                    HKQuantity *mostRecentQuantity = quantitySample.mostRecentQuantity;
                    double mostRecentRate = [mostRecentQuantity doubleValueForUnit:bloodGlucoseUnit];
                    
                    NSString *startDate = [WHTools dateToStringWithDate:quantitySample.startDate];
                    NSString *endDate = [WHTools dateToStringWithDate:quantitySample.endDate];
                    
                
                    
                    NSLog(@"想要的血糖 min :%@, max :%@, average :%@, mostRec :%@ 开始时间 :%@, 结束时:%@",@(minRate),@(maxRate),@(averageRate),@(mostRecentRate),startDate,endDate);

                }
            } else {
                // Fallback on earlier versions
            }
            completion(0,error);
        }
    }];
    
    [self.healthStore executeQuery:query];
}


// 获取睡眠质量
- (void)getSleepQuality:(void(^)(double value, NSError *error))completion{
    HKCategoryType *sleepAnalysisType = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:sleepAnalysisType predicate:[WHGetHealthyKit predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(error)
        {
            completion(0,error);
        }
        else
        {
            for (HKCategorySample *sample in results) {
                /// 根据type 记录睡眠类型
                ///
                ///

                NSLog(@"睡眠的sampleValue :%ld",(long)sample.value);
                switch (sample.value) {
                    case HKCategoryValueSleepAnalysisInBed:
                        {
                            NSLog(@"卧床时间");
                        }
                        break;
                        
                    case HKCategoryValueSleepAnalysisAsleepCore:{
                        NSLog(@"核心睡眠");
                    }
                        break;
                        
                    case HKCategoryValueSleepAnalysisAsleepDeep:{
                        NSLog(@"深度睡眠");
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }
            completion(0,error);
        }
    }];
    
    [self.healthStore executeQuery:query];
}

// 获取心电图
- (void)getECG:(void(^)(double value, NSError *error))completion{
    if (@available(iOS 14.0, *)) {
        HKElectrocardiogramType *ecgType = HKObjectType.electrocardiogramType;
        HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:ecgType predicate:nil limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
            if (error) {
                completion(0,error);
            } else {
                for (HKElectrocardiogram *ecgPram in results) {
                    
                    
//                    HKElectrocardiogramQuery *pramQuery = [[HKElectrocardiogramQuery alloc] initWithElectrocardiogram:ecgPram dataHandler:^(HKElectrocardiogramQuery * _Nonnull query, HKElectrocardiogramVoltageMeasurement * _Nullable voltageMeasurement, BOOL done, NSError * _Nullable error) {
//                        if (error) {
//
//                        } else {
//                            HKQuantity *qulity = [voltageMeasurement quantityForLead:HKElectrocardiogramLeadAppleWatchSimilarToLeadI];
//
//                            NSLog(@"每个数组里面的数据 点1：%@, start:%f",@([qulity doubleValueForUnit:[HKUnit voltUnit]]),voltageMeasurement.timeSinceSampleStart);
//                        }
//
//                    }];
                    
//                    [self.healthStore executeQuery:pramQuery];
                    
                    
                    
                    
                    NSInteger numberOfVoltageMeasurements = ecgPram.numberOfVoltageMeasurements;
                    HKElectrocardiogramClassification classification = ecgPram.classification;
                    
                    
                    // 数据采样的频率
                    HKQuantity *samplingFrequency = ecgPram.samplingFrequency;
                    double sampCy = [samplingFrequency doubleValueForUnit:[HKUnit hertzUnit]];
                    
                    //记录心电图时用户的平均心率
                    HKUnit *heartRateUnit = [[HKUnit countUnit] unitDividedByUnit:[HKUnit minuteUnit]];
                    HKQuantity *averageHeartRate = ecgPram.averageHeartRate;
                    double averageRate = [averageHeartRate doubleValueForUnit:heartRateUnit];
                    
                    HKElectrocardiogramSymptomsStatus symptomsStatus = ecgPram.symptomsStatus;
                    
                    NSLog(@"心电图电压测试值%@ 心率%@ 赫兹%@",@(numberOfVoltageMeasurements),@(averageRate),@(sampCy));
                }
            }
        }];
        
        
        [self.healthStore executeQuery:query];
        
    } else {
        // Fallback on earlier versions
    }

    
}


#pragma mark -- 自定义操作

-(void)addStepsValue:(double)value unit:(HKUnit *)unit state:(void(^)(BOOL success, NSError *error))completion{
    
    //开始时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    NSDate *startDate = [calendar dateFromComponents:components];
    
    //结束时间
    NSDate *endDate = [NSDate date];
    
    /**
     
     //这里的quantityWithUnit单位如果不对则会报错注意 ，有以下单位获取下面的对应的健康数据需要注意
     
     + (instancetype)meterUnitWithMetricPrefix:(HKMetricPrefix)prefix;      // m
     + (instancetype)meterUnit;  // m
     + (instancetype)inchUnit;   // in
     + (instancetype)footUnit;   // ft
     + (instancetype)yardUnit HK_AVAILABLE_IOS_WATCHOS(9_0, 2_0);   // yd
     + (instancetype)mileUnit;   // mi
     
     **/
    
    //单位和数量
    HKQuantity *stepQuantityConsumed = [HKQuantity quantityWithUnit:unit doubleValue:value];
    //类型
    HKQuantityType *stepConsumedType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    NSString *strName = [[UIDevice currentDevice] name];
    NSString *strModel = [[UIDevice currentDevice] model];
    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
    NSString *localeIdentifier = [[NSLocale currentLocale] localeIdentifier];
    
    HKDevice *device = [[HKDevice alloc] initWithName:strName manufacturer:@"Apple" model:strModel hardwareVersion:strModel firmwareVersion:strModel softwareVersion:strSysVersion localIdentifier:localeIdentifier UDIDeviceIdentifier:localeIdentifier];
    
    HKQuantitySample *stepConsumedSample = [HKQuantitySample quantitySampleWithType:stepConsumedType quantity:stepQuantityConsumed startDate:startDate endDate:endDate device:device metadata:nil];
    
    
    //此处在iOS 8 的系统中使用会崩溃，报错找不到该方法，由于以前一直用iOS10的系统测试的未曾发现这个问题，修改为以下方法即可
    
    //    HKQuantitySample *stepConsumedSample = [HKQuantitySample quantitySampleWithType:stepConsumedType quantity:stepQuantityConsumed startDate:startDate endDate:endDate];
    
    
    [self.healthStore saveObject:stepConsumedSample withCompletion:^(BOOL success, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
            
                completion(YES,error);
            }else {
                
                completion(NO,error);
 
            }
        });
    }];
    
}

/**
 添加饮水量
 
 @param value 水量
 @param unit 单位
 @param completion 状态码
 */
-(void)addWaterQuantity:(double)value unit:(HKUnit *)unit state:(void (^)(BOOL, NSError *))completion{
    
    //开始时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    NSDate *startDate = [calendar dateFromComponents:components];
    
    //结束时间
    NSDate *endDate = [NSDate date];
    
    //单位和数量
    HKQuantity *stepQuantityConsumed = [HKQuantity quantityWithUnit:unit doubleValue:value];
    //类型
    HKQuantityType *stepConsumedType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryWater];
    
    NSString *strName = [[UIDevice currentDevice] name];
    NSString *strModel = [[UIDevice currentDevice] model];
    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
    NSString *localeIdentifier = [[NSLocale currentLocale] localeIdentifier];
    
    HKDevice *device = [[HKDevice alloc] initWithName:strName manufacturer:@"Apple" model:strModel hardwareVersion:strModel firmwareVersion:strModel softwareVersion:strSysVersion localIdentifier:localeIdentifier UDIDeviceIdentifier:localeIdentifier];
    
    HKQuantitySample *stepConsumedSample = [HKQuantitySample quantitySampleWithType:stepConsumedType quantity:stepQuantityConsumed startDate:startDate endDate:endDate device:device metadata:nil];
    
    
    //此处在iOS 8 的系统中使用会崩溃，报错找不到该方法，由于以前一直用iOS10的系统测试的未曾发现这个问题，修改为以下方法即可
    
    //    HKQuantitySample *stepConsumedSample = [HKQuantitySample quantitySampleWithType:stepConsumedType quantity:stepQuantityConsumed startDate:startDate endDate:endDate];
    
    
    [self.healthStore saveObject:stepConsumedSample withCompletion:^(BOOL success, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                
                completion(YES,error);
            }else {
                
                completion(NO,error);
                
            }
        });
    }];
}

@end
