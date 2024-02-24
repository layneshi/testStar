//
//  WHPeopleModel.h
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHPeopleModel : NSObject

@property(nonatomic, copy) NSString *birthday;   // 生日
@property(nonatomic, copy) NSString *familyHistory;   // 家族病史
@property(nonatomic, assign) NSInteger height;   // 身高
@property(nonatomic, copy) NSString *ID;   // 个人资料id   修改才添加  新增不需要    //用于查询体检报告的infoid
@property(nonatomic, copy) NSString *pastHistory;   // 家族病史
@property(nonatomic, copy) NSString *sex;   // 性别
@property(nonatomic, assign) NSInteger userId;   // 用户id  通过bytoken获取到的
@property(nonatomic, assign) NSInteger weight;   // 体重





@end

NS_ASSUME_NONNULL_END
