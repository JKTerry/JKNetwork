//
//  BaseNetworkManager.m
//
//  Copyright © 2017年 JK. All rights reserved.
//

#import "BaseNetworkManager.h"
// Common Base Server Url, Replace this for your own app
#define kBaseServerUrl @"https://example.com/"

@implementation BaseNetworkManager

+ (BaseNetworkManager *)sharedManager {
    static BaseNetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseServerUrl]];
    });
    return sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        self.requestSerializer.timeoutInterval = 30.0; //设置超时时间
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                                        @"text/json",
                                                                        @"text/html",
                                                                        @"text/plain",
                                                                        @"application/json",
                                                                        @"text/javascript",
                                                                        @"application/octet-stream",
                                                                        @"multipart/form-data",
                                                                        nil];
        [self.reachabilityManager startMonitoring];
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:{
                    NSLog(@"Network not Reachable");
                    break;
                }
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                    NSLog(@"Network is WiFi");
                    break;
                }
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    NSLog(@"Network is WWAN");
                    break;
                }
                default:
                    NSLog(@"Network unreachable");
                    break;
            }
        }];

    }
    return self;
}

- (void)cancelAllRequest {
    for (NSURLSessionTask *task in [BaseNetworkManager sharedManager].tasks) {
        [task cancel];
    }
}

- (BOOL)isNetworkAvailable {
        return self.reachabilityManager.isReachable;
}

@end
