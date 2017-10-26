//
//  NSDictionary+SafeKit.m
//  SafeKit
//
//  Created by WBO on 2016/10/01.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import "NSDictionary+SafeKit.h"
#import "NSObject+Swizzle.h"

@implementation NSDictionary (SafeKit)

-(instancetype)initWithObjects_safe:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)cnt {
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!(keys[i] && objects[i])) {
            break;
        }
        newCnt++;
    }
    self = [self initWithObjects_safe:objects forKeys:keys count:newCnt];
    return self;
}

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(initWithObjects_safe:forKeys:count:) tarClass:@"__NSPlaceholderDictionary" tarSel:@selector(initWithObjects:forKeys:count:)];
    });
}

@end
