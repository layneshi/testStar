//
//  WXSendWxModel.m
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import "WHSendWxModel.h"

@implementation WHSendWxModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"wxId" : @"id"
         };
}

@end
