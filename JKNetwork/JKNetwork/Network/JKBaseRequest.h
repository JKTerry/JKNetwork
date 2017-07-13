//
//  JKBaseRequest.h
//
//  Copyright © 2017年 JK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
#import <NSObject_ObjectMap/NSObject+ObjectMap.h>

typedef NS_ENUM(NSInteger, HTTP_TYPE) {
    //For now, just add GET and POST Methods
    HTTP_TYPE_GET,          //GET
    HTTP_TYPE_POST,         //POST
};

@interface JKBaseRequest : NSObject

/**
 Send Request
 
 @param success The Request success block
 @param failure The Request failed block
 */
- (void) sendRequest:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

#pragma mark - SubClass Methods

/**
 HTTP_TYPE include (GET, POST)

 @return Default is GET Methods
 */
- (HTTP_TYPE) httpType;

/**
 Usually, Url is like "http://example.com/user/getUserName",
 Base Url is http://example.com/ subUrl is "user/getUserName"
 
 @return subUrl
 */
- (nonnull NSString *)subUrl;

/**
 When the url include parameters, you need to construct it,
 eg:http://example.com/user/getUserName?mobile=15787697660&type=1 ,mobile and type is parameters

 @return parameters dictionary
 */
- (nullable NSMutableDictionary *)parameters;

/**
 Start Request
 
 @param success The Request success block
 @param failure The Request failed block
 */
- (void) startRequest:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
              failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;


@end
