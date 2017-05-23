//
//  WPUserRequestHandler.h
//  AFNetworkingRequestManager
//
//  Created by 王鹏 on 16/9/20.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import "WPRequestHandler.h"

/**
 *  接口枚举
 */
typedef NS_ENUM(NSInteger ,WPRequestHandlerType) {
    
    /**
     *  登录
     */
    WPRequestHandlerTypeOfLogin
};


@interface WPUserRequestHandler : WPRequestHandler

@end
