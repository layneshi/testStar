//
//  WHReportModel.m
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#import "WHReportModel.h"

@implementation WHReportModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"infoId" : @"id"
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"reportList":[WHReportDataListModel class]
    };
}


@end



@implementation WHReportDataListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"infoId" : @"id"
             };
}

@end
