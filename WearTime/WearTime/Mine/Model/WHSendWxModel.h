//
//  WXSendWxModel.h
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHSendWxModel : NSObject

@property(nonatomic, copy) NSString *wx;
@property(nonatomic, assign) NSInteger wxId;
@property(nonatomic, copy) NSString *wxName;
@property(nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
