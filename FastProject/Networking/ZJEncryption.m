
//  ZJEncryption.m
//  WBO
//
//  Created by WBO on 16/6/16.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import "ZJEncryption.h"
#import "NSMutableDictionary+Util.h"
#import "NSString+Encryption.h"

@implementation ZJEncryption

  

+ (NSDictionary *)encryption:(NSDictionary *)params
                         API:(NSString *)api
                   APIVerson:(NSString *)apiVerson{
    return  [ZJEncryption beingToken:params API:api APIVerson:apiVerson];
}

+ (NSDictionary *)beingToken:(NSDictionary *)params API:(NSString *)api APIVerson:(NSString *)apiVerson{
    
    NSMutableDictionary* fullParams=params?params.mutableCopy:[NSMutableDictionary dictionary];
    [fullParams setObjectExceptNil:api forKey:@"_api"];
    [fullParams setObjectExceptNil:apiVerson ? apiVerson:@"1.0" forKey:@"_v"];

    //可以做一些加密
    DebugLog(@"\n body = %@", fullParams);
    
    return fullParams;
}



@end



