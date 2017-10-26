//
//  NSArray+SafeKit.m
//  SafeKit
//
//  Created by WBO on 2016/10/01.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import "NSArray+SafeKit.h"
#import "NSObject+swizzle.h"

@implementation NSArray (SafeKit)

- (instancetype)initWithObjects_safe:(id *)objects count:(NSUInteger)cnt {
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!objects[i]) {
            break;
        }
        newCnt++;
    }
    self = [self initWithObjects_safe:objects count:newCnt];
    return self;
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

- (NSArray *)safe_arrayByAddingObject:(id)anObject {
    if (!anObject) {
        return self;
    }
    return [self safe_arrayByAddingObject:anObject];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(initWithObjects_safe:count:) tarClass:@"__NSPlaceholderArray" tarSel:@selector(initWithObjects:count:)];
        [self safe_swizzleMethod:@selector(safe_objectAtIndex:) tarClass:@"__NSArrayI" tarSel:@selector(objectAtIndex:)];
        [self safe_swizzleMethod:@selector(safe_arrayByAddingObject:) tarClass:@"__NSArrayI" tarSel:@selector(arrayByAddingObject:)];
    });
}

@end
