//
//  ZJNetAPIClient.m
//  WBO
//
//  Created by ios on 16/6/16.
//  Copyright © 2016年 WBO. All rights reserved.
//

#define kNetworkMethodName @[@"GET", @"POST", @"PUT", @"DELETE"]

#import "ZJNetAPIClient.h"
#import "ZJEncryption.h"
#import "Reachability.h"
#import "WBNetworkCache.h"
#import "NSMutableDictionary+Util.h"

@implementation ZJNetAPIClient

static NSMutableArray *_allSessionTask;



+ (instancetype)shareClient{
    static ZJNetAPIClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[[self class] alloc] init];
    });
    return client;
}

- (NSURLSessionDataTask *)WBrequestJsonDataWithAPI:(NSString *)api
                                         APIVerson:(NSString *)apiVerson
                                            Params:(id)params
                                           MainURL:(NSString *)MainURL
                                        MethodType:(NetworkMethod)method
                                     autoShowError:(BOOL)autoShowError
                                      autoURLCache:(BOOL)autoURLCache
                                             cache:(CacheBlock)cacheBlock
                                           success:(SuccessBlock)successBlock
                                           failure:(FailBlock)failBlock{
    if (!api || api.length <= 0) {
        return nil;
    }
    NSString *URL = [NSString stringWithFormat:@"%@", MainURL];
    
    if (autoURLCache) {
        //读取缓存
        //todo:params为空的时候，----也需要缓存
        if ([params isKindOfClass:[NSDictionary class]]) {
            NSDictionary *a = params;
            NSMutableDictionary *params_api = a.mutableCopy;
            [params_api setObjectExceptNil:api forKey:@"api"];
            [params_api setObjectExceptNil:apiVerson forKey:@"apiVerson"];
            id responceCache = [WBNetworkCache httpCacheForURL:URL parameters:params_api];
            if (![NSObject isEmpty:cacheBlock] && ![NSObject isEmpty:responceCache]) {
                cacheBlock!=nil ? cacheBlock(responceCache) : nil;
            }
        }
    }
    
    if (!method) {
        method = POST;
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];//开启状态栏网络活动
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", @"application/octet-stream", nil];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    // Https
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setValidatesDomainName:NO];
    manager.securityPolicy = securityPolicy;
    
    NSDictionary *fullParams = [ZJEncryption encryption:params API:api APIVerson:apiVerson];
    
    NSURLSessionDataTask *sessionTask = [[NSURLSessionDataTask alloc] init];
    
    switch (method) {
        case GET:{
            sessionTask = [manager GET:URL parameters:fullParams progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//状态栏网络活动
                NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                DebugLog(@"\n******************** response ********************\n%@:\n%@", api, responseData);
                ZJNetResponse *response = [self handleResponse:responseData autoShowError:autoShowError];
                if (response.success) {//success --> true
                    id responseModel = responseData[@"model"];
                    if (autoURLCache) {
                        //对数据进行异步缓存
                        if ([params isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *a = params;
                            NSMutableDictionary *params_api = a.mutableCopy;
                            [params_api setObjectExceptNil:api forKey:@"api"];
                            [params_api setObjectExceptNil:apiVerson forKey:@"apiVerson"];
                            cacheBlock!=nil ? [WBNetworkCache setHttpCache:responseModel URL:URL parameters:params_api] : nil;
                        }
                    }
                    successBlock(task, responseModel);
                }else{//success --> false
                    failBlock(task, response);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", api, error);
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//状态栏网络活动
                DebugLog(@"%@", error);
                ZJNetResponse *response = [self handleNetFail:error];
                failBlock(task, response);
            }];
            // 添加最新的sessionTask到数组
            sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
            break;
        }
        case POST:{
            sessionTask = [manager POST:URL parameters:fullParams progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//状态栏网络活动
                NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                DebugLog(@"\n******************** response ********************\n%@:\n%@", api, responseData);
                ZJNetResponse *response = [self handleResponse:responseData autoShowError:autoShowError];
                if (response.success) {//success --> true
                    id responseModel = responseData[@"model"];
                    if (autoURLCache) {
                        //对数据进行异步缓存
                        if ([params isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *a = params;
                            NSMutableDictionary *params_api = a.mutableCopy;
                            [params_api setObjectExceptNil:api forKey:@"api"];
                            [params_api setObjectExceptNil:apiVerson forKey:@"apiVerson"];
                            cacheBlock!=nil ? [WBNetworkCache setHttpCache:responseModel URL:URL parameters:params_api] : nil;
                        }
                    }
                    successBlock(task, responseModel);
                }else{//success --> false
                    failBlock(task, response);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", api, error);
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//状态栏网络活动
                DebugLog(@"%@", error);
                ZJNetResponse *response = [self handleNetFail:error];
                
                failBlock(task, response);
            }];
            // 添加最新的sessionTask到数组
            sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
            break;
        }
        case PUT:{
            sessionTask = [manager PUT:URL parameters:fullParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//状态栏网络活动
                NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                DebugLog(@"\n******************** response ********************\n%@:\n%@", api, responseData);
                ZJNetResponse *response = [self handleResponse:responseData autoShowError:autoShowError];
                if (response.success) {//success --> true
                    id responseModel = responseData[@"model"];
                    //对数据进行异步缓存
                    if ([params isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *a = params;
                        NSMutableDictionary *params_api = a.mutableCopy;
                        [params_api setObjectExceptNil:api forKey:@"api"];
                        [params_api setObjectExceptNil:apiVerson forKey:@"apiVerson"];
                        cacheBlock!=nil ? [WBNetworkCache setHttpCache:responseModel URL:URL parameters:params_api] : nil;
                    }
                    successBlock(task, responseModel);
                }else{//success --> false
                    failBlock(task, response);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", api, error);
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//状态栏网络活动
                DebugLog(@"%@", error);
                ZJNetResponse *response = [self handleNetFail:error];
                failBlock(task, response);
            }];
            // 添加最新的sessionTask到数组
            sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
            break;

        }
        case DELETE:{
            sessionTask = [manager PUT:URL parameters:fullParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//状态栏网络活动
                NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                DebugLog(@"\n******************** response ********************\n%@:\n%@", api, responseData);
                ZJNetResponse *response = [self handleResponse:responseData autoShowError:autoShowError];
                if (response.success) {//success --> true
                    id responseModel = responseData[@"model"];
                    //对数据进行异步缓存
                    if ([params isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *a = params;
                        NSMutableDictionary *params_api = a.mutableCopy;
                        [params_api setObjectExceptNil:api forKey:@"api"];
                        [params_api setObjectExceptNil:apiVerson forKey:@"apiVerson"];
                        cacheBlock!=nil ? [WBNetworkCache setHttpCache:responseModel URL:URL parameters:params_api] : nil;
                    }
                    successBlock(task, responseModel);
                }else{//success --> false
                    failBlock(task, response);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", api, error);
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//状态栏网络活动
                DebugLog(@"%@", error);
                ZJNetResponse *response = [self handleNetFail:error];
                failBlock(task, response);
            }];
            // 添加最新的sessionTask到数组
            sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
            break;
        }
        default:
            break;
    }
    return sessionTask;
}

- (void)uploadParam:(NSDictionary *)param
            MainURL:(NSString *)URL
                API:(NSString *)api
          apiVerson:(NSString *)apiVerson
           formData:(NSData *)data
           progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgressBlock
            success:(SuccessBlock)successBlock
            failure:(FailBlock)failBlock{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60.0;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", @"application/octet-stream", nil];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    // Https
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setValidatesDomainName:NO];
    manager.securityPolicy = securityPolicy;
    
    NSDictionary *fullParams = [ZJEncryption encryption:param API:api APIVerson:apiVerson];
    
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:URL parameters:fullParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        [formData appendPartWithFileData:data name:@"upfile" fileName:fileName mimeType:@"file"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        uploadProgressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//状态栏网络活动
        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        DebugLog(@"\n******************** response ********************%@:\n", responseData);
        ZJNetResponse *response = [self handleResponse:responseData autoShowError:NO];
        if (response.success) {//success --> true
            id responseModel = responseData[@"model"];
            successBlock(task, responseModel);
        }else{//success --> false
            failBlock(task, response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DebugLog(@"\n===========response===========%@:\n", error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//状态栏网络活动
        DebugLog(@"%@", error);
        ZJNetResponse *response = [self handleNetFail:error];
        failBlock(task, response);
    }];

}


+(NSString *)URLSession:(NSString *)param Webaddress:(NSString *)webaddress
{

    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",param];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    // NSString *webaddress=@"http://www.baidu.com/dd/adb.htm?adc=e12&xx=lkw&dalsjd=12";
    NSArray *matches = [regex matchesInString:webaddress
                                      options:0
                                        range:NSMakeRange(0, [webaddress length])];
    for (NSTextCheckingResult *match in matches) {
        
        NSString *tagValue = [webaddress substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return @"";
}


- (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

- (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

/**
 存储着所有的请求task数组
 */
- (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}
@end



