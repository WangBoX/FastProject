//
//  ZJEncryption.h
//  WBO
//
//  Created by WBO on 16/6/16.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZJEncryption : NSObject

+ (NSDictionary *)encryption:(NSDictionary *)params
                         API:(NSString *)api
                   APIVerson:(NSString *)apiVerson;

@end
