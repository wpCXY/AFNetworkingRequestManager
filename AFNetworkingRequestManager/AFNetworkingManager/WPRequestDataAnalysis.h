//
//  WPRequestDataAnalysis.h
//  AFNetworkingRequestManager
//
//  Created by 王鹏 on 16/9/18.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 请求结果解析类
 根据请求的类型 请求回来数据对应的模型 请求的结果 将 数据转化为对象
 */
@interface WPRequestDataAnalysis : NSObject
 
/**
 *  解析请求数据
 *
 *  @param type       请求类型
 *  @param data       请求的二级制数据
 *  @param modelClass 对应的数据模型
 *
 *  @return 解析结果
 */
+ (id)dataAnalysisWithRequestType:(NSInteger)type
                        datasJson:(NSData *)data
                   dataModelClass:(Class)modelClass;
@end
