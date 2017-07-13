//
//  JKBaseRequest.m
//
//  Copyright © 2017年 JK. All rights reserved.
//

#import "JKBaseRequest.h"
#import "BaseNetworkManager.h"

@implementation JKBaseRequest

- (void)dealloc {
    NSLog(@"dealloc %@",self);
}

+ (NSError *) constructError:(NSError *)error {
    NSInteger errorCode = error.code;
    NSString *errorDomain = error.domain;
   
    
    return [NSError errorWithDomain:errorDomain code:errorCode userInfo:error.userInfo];
}

#pragma mark - PublicMethods
- (void) sendRequest:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    HTTP_TYPE httpType = [self httpType];
    NSURLSessionDataTask *dataTask = nil;
    switch (httpType) {
        case HTTP_TYPE_GET:
        {
            dataTask = [[BaseNetworkManager sharedManager] GET:[self subUrl]
                                                    parameters:[self parameters]
                                                      progress:nil
                                                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                           NSDictionary *responseDic = (NSDictionary *)responseObject;
                                                           NSLog(@"%@\n Request Success：%@",task.currentRequest.URL,responseDic);
                                                           int status = [responseDic[@"status"] intValue];
                                                        
                                                           if (status == 0) {
                                                               if (success) {
                                                                   success(task,responseDic);
                                                               }
                                                           } else {
                                                               NSErrorDomain errorDomain = responseDic[@"message"];
                                                               NSError *error = [NSError errorWithDomain:errorDomain code:status userInfo:nil];
                                                               NSError *defineError = [JKBaseRequest constructError:error];
                                                               if (failure) {
                                                                   failure(task, defineError);
                                                               }
                                                           }
                                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                           NSLog(@"%@\n Request Failure：%@",task.currentRequest.URL,error);
                                                           NSError *err = [JKBaseRequest constructError:error];
                                                           if (failure) {
                                                               failure(task, err);
                                                           }
                                                       }];
            break;
        }
        case HTTP_TYPE_POST:
        {
            NSLog(@"POST parameters:%@",[self parameters]);
            dataTask = [[BaseNetworkManager sharedManager] POST:[self subUrl]
                                                     parameters:[self parameters]
                                                       progress:nil
                                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                            NSDictionary *responseDic = (NSDictionary *)responseObject;
                                                            NSLog(@"%@\n Request Success：%@",task.currentRequest.URL,responseDic);
                                                            int status = [responseDic[@"status"] intValue];
                                                            if (status == 0) {
                                                                if (success) {
                                                                    success(task,responseDic);
                                                                }
                                                            } else {
                                                                NSErrorDomain errorDomain = responseDic[@"message"];
                                                                NSError *error = [NSError errorWithDomain:errorDomain code:status userInfo:nil];
                                                                NSError *defineError = [JKBaseRequest constructError:error];
                                                                if (failure) {
                                                                    failure(task, defineError);
                                                                }
                                                            }
                                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                            NSLog(@"%@\n Request Failure：%@",task.currentRequest.URL,error);
                                                            NSError *err = [JKBaseRequest constructError:error];
                                                            if (failure) {
                                                                failure(task, err);
                                                            }
                                                        }];
            break;
        }
            
        default:
            break;
    }
    return;
}

#pragma mark - SubClass Methods
- (HTTP_TYPE)httpType{
    return HTTP_TYPE_GET;
}

- (NSString *)subUrl {
    return @"";
}

- (NSMutableDictionary *)parameters {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self objectDictionary]];
    return dic;
}

- (void) startRequest:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
              failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    [self sendRequest:success failure:failure];
}
@end
