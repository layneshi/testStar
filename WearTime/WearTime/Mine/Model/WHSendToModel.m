//
//  WHSendToModel.m
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import "WHSendToModel.h"

@implementation WHSendToModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"sendId" : @"id"
         };
}

@end
