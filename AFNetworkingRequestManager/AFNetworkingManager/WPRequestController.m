//
//  WPRequestController.m
//  AFNetworkingRequestManager
//
//  Created by 王鹏 on 16/9/18.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import "WPRequestController.h"
#import "WPRequestHandler.h"
#import "WPRequestDataAnalysis.h"
#import <AFNetworking.h>
@interface WPRequestController ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, copy) WPRequestFinish complete;
@property (nonatomic, copy) WPRequestFailed failed;


@end

@implementation WPRequestController


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - delegate 回调
-(BOOL)doPostRequest:(id)params dateModelClass:(Class)modelClass requestType:(NSInteger)type userInfo:(id)info {
    
    
    if (![self checkNetworkStats]) {
        //检查是否有网，无网情况下算作请求成功！
        NSError *error = [NSError errorWithDomain:@"无网络" code:9999 userInfo:nil];
        [self failedRequestDatas:self userInfo:info error:error];
        return YES;
    }
    __weak typeof(self) weakSelf = self;

    NSString *url = [self requestURLWithType:type];
    NSDictionary *baseParam = [self requstBaseParamWith:type];
    
    // 将基础参数拼接到URL后
    NSMutableArray *urlParams = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *key in baseParam) {
        NSString *value= [baseParam valueForKey:key];
        [urlParams addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
    }
    NSString *paramString = [urlParams componentsJoinedByString:@"&"];
    
    NSString * postUrl = [NSString stringWithFormat:@"%@?%@",url,paramString];
    NSURLSessionTask *task = [self.manager POST:postUrl
                                     parameters:params
                                       progress:nil
                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            [weakSelf dataAnalysisWihtResponseObject:responseObject
                                                                                task:task
                                                                         requestType:type
                                                                          modelClass:modelClass
                                                                            userInfo:info];
                                        }
                                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            [weakSelf failedRequestDatas:self
                                                                userInfo:info
                                                                   error:error];
                                            
                                        }];
    
    if (task)
    {
        return YES;
    }
    else
    {
        return NO;
    }

    
}

-(BOOL)doGetRequest:(NSDictionary *)params dataModelClass:(Class)modelClass requestType:(NSInteger)type userInfo:(id)info {
    
    
    if (![self checkNetworkStats]) {
        //检查是否有网，无网情况下算作请求成功！
        NSError *error = [NSError errorWithDomain:@"无网络" code:9999 userInfo:nil];
        [self failedRequestDatas:self userInfo:info error:error];
        return YES;
    }
    __weak typeof(self) weakSelf = self;
    if (![self checkNetworkStats]) {
        return YES;
    }
    NSString *url = [self requestURLWithType:type];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
    [dic addEntriesFromDictionary:[self requstBaseParamWith:type]];
    NSURLSessionTask * task = [self.manager GET:url
                                     parameters:dic
                                       progress:nil
                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            [weakSelf dataAnalysisWihtResponseObject:responseObject
                                                                                task:task
                                                                         requestType:type
                                                                          modelClass:modelClass
                                                                            userInfo:info];                      }
                                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            [weakSelf failedRequestDatas:self
                                                                userInfo:info
                                                                   error:error];
                                        }];
    if (task)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - Block 回调
+ (BOOL)doPostRequest:(id)params
       dateModelClass:(Class)modelClass
          requestType:(NSInteger)type
             userInfo:(id)info
             complete:(WPRequestFinish)complete
               failed:(WPRequestFailed)failed {
    WPRequestController *request = [[WPRequestController alloc] init];
    request.complete = complete;
    request.failed   = failed;
    return [request doPostRequest:params
                   dateModelClass:modelClass
                      requestType:type
                         userInfo:info];
}
+ (BOOL)doGetRequest:(NSDictionary *)params
      dataModelClass:(Class)modelClass
         requestType:(NSInteger)type
            userInfo:(id)info
            complete:(WPRequestFinish)complete
              failed:(WPRequestFailed)failed {
    WPRequestController *request = [[WPRequestController alloc] init];
    request.complete = complete;
    request.failed   = failed;
    return [request doGetRequest:params 
                  dataModelClass:modelClass
                     requestType:type
                        userInfo:info];
}
#pragma mark - Private
- (NSString *)requestURLWithType:(NSInteger)type {
    if (!_handlerClass) {
        _handlerClass = [WPRequestHandler class];
    }
    return [_handlerClass requestURLWithType:type];
}
- (NSDictionary *)requstBaseParamWith:(NSInteger)type
{
    if (!_handlerClass) {
        _handlerClass = [WPRequestHandler class];
    }
    return [_handlerClass paramsWithType:type];
}
- (BOOL)checkNetworkStats {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    switch (manager.networkReachabilityStatus) {
        case AFNetworkReachabilityStatusUnknown:
        {
            return YES;
        }
            break;
        case AFNetworkReachabilityStatusNotReachable:
        {
            return NO;
        }
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
        {
            return YES;
        }
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
        {
            return YES;
        }
            break;
    }
}

#pragma mark - 处理结果
- (void)dataAnalysisWihtResponseObject:(id)responseObject task:(NSURLSessionDataTask *)task requestType:(NSInteger)type modelClass:(Class)modelClass userInfo:(id)info{
    
    if (!_dataAnalysisClass) {
        _dataAnalysisClass = [WPRequestDataAnalysis class];
    }
    NSLog(@"%@",task.response.URL);
    id result = [_dataAnalysisClass dataAnalysisWithRequestType:type
                                                      datasJson:responseObject
                                                 dataModelClass:modelClass];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!result || [result isKindOfClass:[NSError class]]) {
            if ([result isKindOfClass:[NSError class]]) {
                [self failedRequestDatas:self
                                userInfo:info
                                   error:result];
            }else{
                [self failedRequestDatas:self
                                userInfo:info
                                   error:task.error];
                
            }
            
        }else{
            [self finishRequestDatas:self
                            userInfo:info
                              result:result];
        }
    });
}

#pragma mark - 代理回调
- (void)finishRequestDatas:(WPRequestController *)request userInfo:(id)info result:(id)result {
    if ([self.delegate respondsToSelector:@selector(finishRequestDatas:userInfo:result:)]) {
        [self.delegate finishRequestDatas:request
                                 userInfo:info
                                   result:result];
    }
    if (_complete) {
        __weak typeof(self) weakSelf = self;
        _complete(weakSelf,info,result);
    }
}
- (void)failedRequestDatas:(WPRequestController *)request userInfo:(id)info error:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(failedRequestDatas:userInfo:error:)]) {
        [self.delegate failedRequestDatas:request
                                 userInfo:info
                                    error:error];
    }
    if (_failed) {
        __weak typeof(self) weakSelf = self;
        _failed(weakSelf,info,error);
    }
}
#pragma mark - Getter

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        [_manager.requestSerializer setValue:@"Epaper" forHTTPHeaderField:@"User-Agent"];
        [_manager.requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/text"]];
        _manager.operationQueue.maxConcurrentOperationCount = 2;
        
    }
    return _manager;
}

@end
