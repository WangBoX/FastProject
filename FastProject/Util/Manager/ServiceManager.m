//
//  ServiceManager.m
//  MoodGood
//
//  Created by WBO on 2017/10/16.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import "ServiceManager.h"

@implementation ServiceManager
+ (instancetype)sharedManager
{
    static ServiceManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ServiceManager alloc]init];
    });
    return instance;
}
- (void)start {
   
    
}


@end
