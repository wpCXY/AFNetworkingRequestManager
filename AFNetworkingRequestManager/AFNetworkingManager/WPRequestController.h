//
//  WPRequestController.h
//  AFNetworkingRequestManager
//
//  Created by 王鹏 on 16/9/18.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WPRequestController;

@protocol WPRequestControllerDelegate <NSObject>

@required
- (void)finishRequestDatas:(WPRequestController *)request userInfo:(id)info result:(id)result;
- (void)failedRequestDatas:(WPRequestController *)request userInfo:(id)info error:(NSError *)error;

@end

typedef void (^WPRequestFinish)(WPRequestController *requestBase,id info,id rs);
typedef void (^WPRequestFailed)(WPRequestController *requestBase,id info,NSError *error);

/**
 网络请求类 不直接使用呢 
 */
@interface WPRequestController : NSObject
/**
 *  请求参数、URL处理类 初始化时需要赋值
 */
@property (nonatomic, assign) Class   handlerClass;
/**
 *  请求结果数据处理类 如不赋值则默认为WPRequestDataAnalysis类解析
 */
@property (nonatomic, assign) Class   dataAnalysisClass;
@property (nonatomic, weak) id<WPRequestControllerDelegate>delegate;

#pragma mark - delegate 回调

- (BOOL)doPostRequest:(id)params
       dateModelClass:(Class)modelClass
          requestType:(NSInteger)type
             userInfo:(id)info;

- (BOOL)doGetRequest:(NSDictionary *)params
      dataModelClass:(Class)modelClass
         requestType:(NSInteger)type
            userInfo:(id)info;

#pragma mark - Block 回调
+ (BOOL)doPostRequest:(id)params
       dateModelClass:(Class)modelClass
          requestType:(NSInteger)type
             userInfo:(id)info
             complete:(WPRequestFinish)complete
               failed:(WPRequestFailed)failed;
+ (BOOL)doGetRequest:(NSDictionary *)params
      dataModelClass:(Class)modelClass
         requestType:(NSInteger)type
            userInfo:(id)info
            complete:(WPRequestFinish)complete
              failed:(WPRequestFailed)failed;
@end
