//
//  SLRequestNetWorking.m
//  YxtRtcEngine
//
//  Created by 朱庆祥 on 2022/2/16.
//

#import "SLRequestNetWorking.h"
#import <AFNetworking/AFNetworking.h>

#define YXTDOMAIN @"YxtServerDomain"

#define hmacSha265key @"abcd"
#define xximOrgId @"default "

@implementation SLRequestNetWorking

+ (void)requestWithMethod:(SLRequesMethod)method
                urlString:(NSString *)urlString
                parameter:(id __nullable)parameter
                    token:(NSString * __nullable)token
                onSuccess:(void (^)(id data))onSuccess
                onFailure:(void (^)(NSError *error))onFailure {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSArray * methodArray = @[@"POST",@"GET",@"PATCH",@"DELETE",@"PUT"];
    NSString *httpMethod = methodArray[method];
    [request setHTTPMethod:httpMethod];
    if (method == SLPostMethod || method == SLPutMethod || method == SLPathMethod || method == SLDeleteMethod) {
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPBody:[[self TS_jsonStringEncoded:parameter] dataUsingEncoding:NSUTF8StringEncoding]];
        
//        [request setHTTPBody:[[self dealWithParam:parameter] dataUsingEncoding:NSUTF8StringEncoding]];
    
    }
    if (token.length > 0) {
        [request setValue:token forHTTPHeaderField:@"token"];
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (onFailure) {
                onFailure(error);
            }
            return;
        }
        if (onSuccess) {
            // [1]    (null)    @"Error" : @"json: cannot unmarshal number 1648003209.3764892 into Go struct field ChatroomPullReq.EndTime of type int64"
            NSError *error;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSInteger status = [[result objectForKey:@"status"] intValue];
            if (status != 200) {
                if (onFailure) {
                    NSString *msg = [result objectForKey:@"errorMsg"];
                    NSError *error = [self TS_makeErrorWithCode:status description:msg];
                    onFailure(error);
                }
                return;
            }
            NSDictionary *serData = result;
            onSuccess(serData);
        }
    }];
    [task resume];
    
}

#pragma mark -- private
+ (NSError *)TS_makeErrorWithCode:(NSInteger)code description:(NSString *)description {
    NSError *error = [NSError errorWithDomain:YXTDOMAIN code:code userInfo:@{NSLocalizedDescriptionKey:description ? description : @"unknow error"}];
    return error;
}

+ (NSString *)TS_jsonStringEncoded:(NSDictionary *)dic {
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

#pragma mark --  拼接参数
+ (NSString *)dealWithParam:(NSDictionary *)param{
    NSArray *allkeys = [param allKeys];
    NSMutableString *result = [NSMutableString string];
    for (NSString *key in allkeys) {
        NSString *string = [NSString stringWithFormat:@"%@=%@",key, param[key]];
        [result appendString:string];
    }
    return result;
}

#pragma mark -- AFN

//get
+ (void)getPath:(NSString *)url
     parameters:(nullable NSDictionary *)parameters
          token:(nullable NSString *)token
      onSuccess:(void (^)(id data))onSuccess
      onFailure:(void (^)(NSError *error))onFailure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *head = token.length > 0 ? @{@"token": token} : @{};
    
    [manager GET:url parameters:parameters headers:head progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (onSuccess) {
            NSData *data = responseObject;
            onSuccess(data);
        } else {
            NSLog(@"no success");
        }
        [manager.session finishTasksAndInvalidate];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            if (onFailure) {
                onFailure(error);
            }
        }

        
        [manager.session finishTasksAndInvalidate];
    }];
}


//post
+ (void)postPath:(NSString *)url
      parameters:(nullable NSDictionary *)parameters
           token:(nullable NSString *)token
       onSuccess:(void (^)(id data))onSuccess
       onFailure:(void (^)(NSError *error))onFailure{
//    NSError *error;
    if (parameters == nil) {
        parameters = @{};
    }
    NSDictionary *head = token.length > 0 ? @{@"token": token} : @{};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:parameters headers:head progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (onSuccess) {
            // [1]    (null)    @"Error" : @"json: cannot unmarshal number 1648003209.3764892 into Go struct field ChatroomPullReq.EndTime of type int64"
            NSError *error;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSInteger status = [[result objectForKey:@"status"] intValue];
            if (status != 200) {
                if (onFailure) {
                    NSString *msg = [result objectForKey:@"errorMsg"];
                    NSError *error = [self TS_makeErrorWithCode:status description:msg];
                    onFailure(error);
                }
                return;
            }
            NSDictionary *serData = result;
            onSuccess(serData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            if (onFailure) {
                onFailure(error);
            }
        }
    }];
}

@end
