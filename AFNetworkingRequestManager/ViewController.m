//
//  ViewController.m
//  AFNetworkingRequestManager
//
//  Created by 王鹏 on 16/6/3.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import "ViewController.h"
#import "WPRequestDataAnalysis.h"
#import "WPRequestController.h"
#import "WPUserRequestData.h"
#import "WPUserLoginModel.h"
#import <YYModel.h>
@interface ViewController ()<WPRequestControllerDelegate>
@property (nonatomic, strong) WPUserRequestData *request;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonDidClick:(id)sender {

  
}
#pragma mark - Block
- (void)startRequestBlock {
    [WPUserRequestData doGetRequest:@{@"userName":@"userName",@"passWord":@"passWord"}
                     dataModelClass:[WPUserLoginModel class]
                        requestType:WPRequestHandlerTypeOfLogin
                           userInfo:nil
                           complete:^(WPRequestController *requestBase, id info, id rs) {
                               NSLog(@"%@",[rs yy_modelDescription]);
                           }
                             failed:^(WPRequestController *requestBase, id info, NSError *error) {
                                 NSLog(@"%@",error);
                             }];
}

#pragma mark - 代理
- (void)startRequestDelegate {
    _request = [[WPUserRequestData alloc] init];
    _request.delegate = self;
    [_request loginRequestWithUserName:@"98540" password:@"111111"];

}
#pragma mark - WPRequestControllerDelegate
- (void)finishRequestDatas:(WPRequestController *)request userInfo:(id)info result:(id)result {
    NSLog(@"%@",[result yy_modelDescription]);

}
- (void)failedRequestDatas:(WPRequestController *)request userInfo:(id)info error:(NSError *)error {
    NSLog(@"%@",error);
}
#pragma mark - 字符转Data
- (NSData *)getData {
    NSString *str = @"{\"data\":{\"name\":\"NAME\",\"age\":18,\"icon\":\"ICON\",\"sex\":1,\"location\":\"SHENZHEN\",\"desc\":\"DDDDDDDDDDDDDDD\"},\"ret\":0,\"errcode\":0,\"msg\":\"success\"}";
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

@end
