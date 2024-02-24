//
//  AppDelegate+Healthy.m
//  WearTime
//
//  Created by layne on 2023/7/14.
//

#import "AppDelegate+Healthy.h"
#import "WHReportModel.h"


@interface AppDelegate ()

@property(nonatomic, strong) NSMutableArray *dataArr;

@property(nonatomic, strong)  WHReportModel *sendReportModel;   // 发送报告模型

@end


@implementation AppDelegate (Healthy)


- (void)getHealthyData{
    
    /// 新建子线程去发送
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @strongify(self);
    });
    
    
    [[WHGetHealthyKit shareInstance] authorizeHealthKit:^(BOOL success, NSError * _Nonnull error) {
        NSLog(@"是否支持健康 %@",@(success));
        
        /// 获取心率
        [[WHGetHealthyKit shareInstance] getHeatBaret:^(double value, NSError * _Nonnull error) {
            NSLog(@"获取心率");
        }];
        
        /// 获取血氧饱和度
        [[WHGetHealthyKit shareInstance] getBloodOxygen:^(double value, NSError * _Nonnull error) {
            NSLog(@"获取血氧饱和度");
        }];
        
        [[WHGetHealthyKit shareInstance] getBloodPressureSystolic:^(double value, NSError * _Nonnull error) {
            NSLog(@"获取收缩压");
        }];
        
        [[WHGetHealthyKit shareInstance] getBloodPressureDiastolic:^(double value, NSError * _Nonnull error) {
            NSLog(@"获取舒张压");
        }];
        
        [[WHGetHealthyKit shareInstance] getSleepQuality:^(double value, NSError * _Nonnull error) {
            
            
        }];
        
//        [[WHGetHealthyKit shareInstance] getBloodGlucose:^(double value, NSError * _Nonnull error) {
//            NSLog(@"获取血糖");
//        }];
        
        [[WHGetHealthyKit shareInstance] getSleepQuality:^(double value, NSError * _Nonnull error) {
            
        }];
        
        [[WHGetHealthyKit shareInstance] getECG:^(double value, NSError * _Nonnull error) {
            
        }];
        
    }];
    
    

}

@end
