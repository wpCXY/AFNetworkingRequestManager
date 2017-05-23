//
//  WPUserRequestHandler.m
//  AFNetworkingRequestManager
//
//  Created by 王鹏 on 16/9/20.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import "WPUserRequestHandler.h"

@implementation WPUserRequestHandler
+ (NSString *)requestURLWithType:(NSInteger)type {
    NSMutableString *url = [NSMutableString stringWithString:@"域名"];
    switch (type) {
        case WPRequestHandlerTypeOfLogin: {
            url = [NSMutableString stringWithString:@"路径"];

        }
            break;     
        default:
            break;
    }
    return url;
}
+ (NSDictionary *)paramsWithType:(NSUInteger)type {
    
    NSDictionary *param = @{@"token":@"token",
                            @"其他基本参数":@"参数"};
    return param;
}
+ (NSString *)appendBaseUrl {
    return nil;
}
@end
