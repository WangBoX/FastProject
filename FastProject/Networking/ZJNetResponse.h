//
//  ZJNetResponse.h
//  MoodGood
//
//  Created by WBO on 2017/8/21.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, msgCodeType) {
    error_sys = 1,          //系统异常
    error_business = 2,     //业务异常
    //todo 状态码
};


@interface ZJNetResponse : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSString *msgCode;
@property (nonatomic, strong) NSString *msgInfo;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, assign) BOOL noResponse;//没连接成功【客户端、服务端无网络连接】

@end




