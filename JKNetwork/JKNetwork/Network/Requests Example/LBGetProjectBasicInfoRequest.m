//
//  LBGetProjectBasicInfoRequest.m
//
//  Copyright © 2017年 JK. All rights reserved.
//

#import "LBGetProjectBasicInfoRequest.h"

@implementation LBGetProjectBasicInfoModel

@end

@implementation LBGetProjectBasicInfoRequest

- (NSString *)subUrl {
    return @"project/get-project-basic-info";
}

- (HTTP_TYPE)httpType {
    return HTTP_TYPE_GET;
}

- (void)startRequest:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure {
    [super sendRequest:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        LBGetProjectBasicInfoModel *model = [LBGetProjectBasicInfoModel mj_objectWithKeyValues:responseObject[@"project_info"]];
        if (success) {
            success(task, model);
        }
    } failure:failure];
}

@end
