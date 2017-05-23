//
//  WPRequestDataAnalysis.m
//  AFNetworkingRequestManager
//
//  Created by 王鹏 on 16/9/18.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import "WPRequestDataAnalysis.h"
#import <YYModel.h>

#define Net_Response_Param_ERRCODE            @"errcode"
#define Net_Response_Param_MSG                @"msg"
#define Net_Response_Param_RET                @"ret"
#define Net_Response_Param_DATA               @"data"

@implementation WPRequestDataAnalysis
+ (id)dataAnalysisWithRequestType:(NSInteger)type
                        datasJson:(id )json
                   dataModelClass:(Class)modelClass {
    
    if (json) { // 请求数据为空
        NSLog(@"请求的数据：%@",json);
    } else {
        NSLog(@" 请求数据为空");
        return [NSError errorWithDomain:@"数据解析失败！"
                                   code:110
                               userInfo:nil];
    }
    NSDictionary *dic = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    }
    BOOL isError = [[dic valueForKey:Net_Response_Param_RET] integerValue] == 1;
    if (isError) { //判断返回的数据是否为错误信息
        return [NSError errorWithDomain:[dic valueForKey:Net_Response_Param_MSG]
                                   code:[[dic valueForKey:Net_Response_Param_ERRCODE] integerValue]
                               userInfo:nil];
    }
    if ([modelClass isSubclassOfClass:[NSDictionary class]] ||
        !modelClass) {
        return modelClass;
    }
    //根据模型的Class，YYModel将json数据转化为对象
    id model = [modelClass yy_modelWithDictionary:dic[Net_Response_Param_DATA]];
    return model;
   
}
@end
