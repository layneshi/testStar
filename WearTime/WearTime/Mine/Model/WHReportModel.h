//
//  WHReportModel.h
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#import <Foundation/Foundation.h>

@class WHReportDataListModel;

NS_ASSUME_NONNULL_BEGIN

@interface WHReportModel : NSObject


@property(nonatomic, assign) NSInteger reportId;   // 报告id 新增的话就不需要填
@property(nonatomic, assign) NSInteger infoId;   // 用户id
@property(nonatomic, copy) NSArray <WHReportDataListModel *> *reportList;


@end



@interface WHReportDataListModel : NSObject



@property(nonatomic, assign) NSInteger avgValue;   // 平均值
@property(nonatomic, copy) NSString *endTime;   // 结束时间
@property(nonatomic, assign) NSInteger ID;
@property(nonatomic, assign) NSInteger maxValue;   // 最大值
@property(nonatomic, assign) NSInteger minValue;   // 最小值
@property(nonatomic, assign) NSInteger reportId;
@property(nonatomic, copy) NSString *startTime;   // 开始时间
@property(nonatomic, assign) NSInteger type;   // 类型
@property(nonatomic, copy) NSString *unit;   // 结束时间

@end


NS_ASSUME_NONNULL_END
