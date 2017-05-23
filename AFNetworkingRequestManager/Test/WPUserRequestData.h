//
//  WPUserRequestData.h
//  AFNetworkingRequestManager
//
//  Created by 王鹏 on 16/9/20.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import "WPRequestController.h"
#import "WPUserRequestHandler.h"
#import "WPUserLoginModel.h"

@interface WPUserRequestData : WPRequestController

- (BOOL)loginRequestWithUserName:(NSString *)userName
                        password:(NSString *)password;
@end
