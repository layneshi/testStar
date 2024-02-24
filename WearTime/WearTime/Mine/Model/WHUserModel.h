//
//  WHUserModel.h
//  WearTime
//
//  Created by layne on 2023/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHUserModel : NSObject

//
//"id": null,
//    "username": null,
//    "password": null,
//    "phone": null,
//    "token": null

@property(nonatomic, copy) NSString *ID;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *phone;
//@property(nonatomic, copy) NSString *token;




@end

NS_ASSUME_NONNULL_END
