//
//  WPRequestHandler.h
//  AFNetworkingRequestManager
//
//  Created by 王鹏 on 16/9/18.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 请求接口参数处理抽象类，不实现具体逻辑
 根据请求类型返回完整URL
 根据请求类型返回基本参数和其他特别参数
 */
@interface WPRequestHandler : NSObject

/**
 *  根据请求类型获取参数
 *
 *  @param type 请求类型
 *
 *  @return 字典 基本参数
 */
+ (NSDictionary *)paramsWithType:(NSUInteger)type;
/**
 *  根据请求类型获取URL
 *
 *  @param type 请求类型
 *
 *  @return URL
 */
+ (NSString *)requestURLWithType:(NSInteger)type;

@end
