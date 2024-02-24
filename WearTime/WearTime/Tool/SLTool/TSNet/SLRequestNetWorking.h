//
//  SLRequestNetWorking.h
//  YxtRtcEngine
//
//  Created by 朱庆祥 on 2022/2/16.
//

#import <Foundation/Foundation.h>
#

NS_ASSUME_NONNULL_BEGIN

@interface SLRequestNetWorking : NSObject

typedef enum : NSUInteger {
    SLPostMethod     = 0,
    SLGetMethod      = 1,
    SLPathMethod     = 2,
    SLDeleteMethod   = 3,
    SLPutMethod      = 4,
} SLRequesMethod;

+ (void)requestWithMethod:(SLRequesMethod)method
                urlString:(NSString *)urlString
                parameter:(id __nullable)parameter
                    token:(NSString * __nullable)token
                onSuccess:(void (^)(id data))onSuccess
                onFailure:(void (^)(NSError *error))onFailure;



#pragma mark -- AFN

//get
+ (void)getPath:(NSString *)url
     parameters:(nullable NSDictionary *)parameters
          token:(nullable NSString *)token
      onSuccess:(void (^)(id data))onSuccess
      onFailure:(void (^)(NSError *error))onFailure;

//post 
+ (void)postPath:(NSString *)url
      parameters:(nullable NSDictionary *)parameters
           token:(nullable NSString *)token
       onSuccess:(void (^)(id data))onSuccess
       onFailure:(void (^)(NSError *error))onFailure;


@end

NS_ASSUME_NONNULL_END
