//
//  ZJNetAPIClient.h
//  WBO
//
//  Created by ios on 16/6/16.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^SuccessBlock)(NSURLSessionDataTask * task, id responseObject);
typedef void (^FailBlock)(NSURLSessionDataTask * task, ZJNetResponse *response);
typedef void (^CacheBlock)(id responseObject);

typedef NS_ENUM(NSUInteger, NetworkMethod) {
    GET = 0,
    POST,
    PUT,
    DELETE
};


@interface ZJNetAPIClient : NSObject

+ (instancetype)shareClient;


/**
 *  自定义发送请求
 *
 *  @param api           api
 *  @param apiVerson     apiVerson
 *  @param params        参数－－－NSDictionary
 *  @param MainURL       url
 *  @param method        GET/POST/PUT/DELETE
 *  @param autoShowError 是否自动弹出错误msg
 *  @param autoURLCache  是否缓存网络请求
 *  @param cacheBlock    缓存数据的回调
 *  @param successBlock       成功回调
 *  @param failBlock       失败回调
 *  @return NSURLSessionDataTask
 */

- (NSURLSessionDataTask *)WBrequestJsonDataWithAPI:(NSString *)api
                                         APIVerson:(NSString *)apiVerson
                                            Params:(id)params
                                           MainURL:(NSString *)MainURL
                                        MethodType:(NetworkMethod)method
                                     autoShowError:(BOOL)autoShowError
                                      autoURLCache:(BOOL)autoURLCache
                                             cache:(CacheBlock)cacheBlock
                                           success:(SuccessBlock)successBlock
                                           failure:(FailBlock)failBlock;


//上传接口
- (void)uploadParam:(NSDictionary *)param
            MainURL:(NSString *)URL
                API:(NSString *)api
          apiVerson:(NSString *)apiVerson
           formData:(NSData *)data
           progress:( void (^)(NSProgress *))uploadProgressBlock
            success:(SuccessBlock)successBlock
            failure:(FailBlock)failBlock;

//解析url中的参数key对应的value
+(NSString *)URLSession:(NSString *)param Webaddress:(NSString *)webaddress;


/**
 取消所有HTTP请求
 */
- (void)cancelAllRequest;

/**
 取消指定URL的HTTP请求
 */
- (void)cancelRequestWithURL:(NSString *)URL;




@end
