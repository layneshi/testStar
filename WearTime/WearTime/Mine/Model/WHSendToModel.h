//
//  WHSendToModel.h
//  WearTime
//
//  Created by layne on 2023/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHSendToModel : NSObject

@property(nonatomic, copy) NSString *email;
@property(nonatomic, assign) NSInteger sendId;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
