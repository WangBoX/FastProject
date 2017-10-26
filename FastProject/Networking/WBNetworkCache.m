//
//  WBNetworkCache.m
//  QP_iOS
//
//  Created by WBO on 2017/4/12.
//  Copyright © 2017年 WBO. All rights reserved.
//

#import "WBNetworkCache.h"
#import "YYCache.h"

@implementation WBNetworkCache

static NSString *const NetworkResponseCache = @"WBNetworkResponseCache";
static YYCache *_dataCache;


+ (void)initialize {
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}

+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}

+ (void)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters withBlock:(void(^)(id<NSCoding> object))block {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    [_dataCache objectForKey:cacheKey withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(object);
        });
    }];
}

+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    
    NSString *ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if(!parameters){
#warning todo:加入uid之类的
        NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,ver];
        return cacheKey;
    };
    
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
#warning todo:加入uid之类的
    // 将URL与转换好的参数字符串, app版本拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@%@",URL,paraString,ver];
    
    return cacheKey;
}


@end

