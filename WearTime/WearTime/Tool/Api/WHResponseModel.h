//
//  WHResponseModel.h
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHResponseModel : NSObject

@property(nonatomic, copy) id data;
@property(nonatomic, copy) NSString *errorMsg;
@property(nonatomic, assign) NSInteger status;
@property(nonatomic, assign) BOOL success;
@property(nonatomic, copy) NSString *timestamp;


@end

NS_ASSUME_NONNULL_END
