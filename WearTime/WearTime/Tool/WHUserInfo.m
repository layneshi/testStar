//
//  WHUserInfo.m
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#import "WHUserInfo.h"

@implementation WHUserInfo

static WHUserInfo  * _userInfo;
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userInfo = [super allocWithZone:zone];
        
    });
    return _userInfo;
}

+ (instancetype)sharedInfo{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userInfo = [[self alloc] init];
    });
    return _userInfo;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    return _userInfo;
}

- (void)saveUserInfoWithModel:(WHUserModel *)userModel{
    self.userId = userModel.ID;
    self.phone = userModel.phone;
    self.name = userModel.username;
//    self.token = userModel.token;
    self.password = userModel.password;
}

- (void)saveUserPerInfoWith:(WHPeopleModel *)peopleModel{
    self.birthday = peopleModel.birthday;
    self.sex = peopleModel.sex;
    self.weight = peopleModel.weight;
    self.height = peopleModel.height;
    self.infoId = peopleModel.ID;
}

@end
