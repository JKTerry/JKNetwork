//
//  LBGetProjectBasicInfoRequest.h
//
//  Copyright © 2017年 JK. All rights reserved.
//

#import "JKBaseRequest.h"

@interface LBGetProjectBasicInfoModel : NSObject

@property (nonatomic, copy  ) NSString *address;
@property (nonatomic, copy  ) NSString *city_name;
@property (nonatomic, copy  ) NSString *project_id;
@property (nonatomic, copy  ) NSString *project_name;
@property (nonatomic, copy  ) NSString *province_name;

@end

@interface LBGetProjectBasicInfoRequest : JKBaseRequest

@property (nonatomic, copy  ) NSString *project_id;

@end
