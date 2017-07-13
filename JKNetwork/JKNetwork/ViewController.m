//
//  ViewController.m
//  JKNetwork
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 JK. All rights reserved.
//

#import "ViewController.h"
#import "LBGetProjectBasicInfoRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendGetProjectBasicInfoRequest];
}

- (void) sendGetProjectBasicInfoRequest {
    LBGetProjectBasicInfoRequest *request = [LBGetProjectBasicInfoRequest new];
    request.project_id = @"1222";
    [request startRequest:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        LBGetProjectBasicInfoModel *model = responseObject;
        NSLog(@"%@",model.project_name);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
