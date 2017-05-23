//
//  WPUserRequestData.m
//  AFNetworkingRequestManager
//
//  Created by 王鹏 on 16/9/20.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import "WPUserRequestData.h"
@implementation WPUserRequestData
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.handlerClass = [WPUserRequestHandler class];
    }
    return self;
}
- (BOOL)loginRequestWithUserName:(NSString *)userName password:(NSString *)password {
    return [self doGetRequest:@{@"userName":userName, @"passWord":password}
               dataModelClass:[WPUserLoginModel class]
                  requestType:WPRequestHandlerTypeOfLogin
                     userInfo:nil];
}

@end
