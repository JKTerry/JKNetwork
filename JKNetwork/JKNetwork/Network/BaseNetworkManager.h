//
//  BaseNetworkManager.h
//
//  Copyright © 2017年 JK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface BaseNetworkManager : AFHTTPSessionManager

+ (BaseNetworkManager * _Nullable)sharedManager;

- (void) cancelAllRequest;

- (BOOL) isNetworkAvailable;

@end
