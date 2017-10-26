//
//  NSMutableArray+SafeKitMRC.m
//  SafeKit
//
//  Created by WBO on 2016/10/01.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import "NSMutableArray+SafeKitMRC.h"
#import "NSObject+swizzle.h"

// fix enter background crash bug when keyboard show.
@implementation NSMutableArray (SafeKitMRC)

- (id)safe_objectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(safe_objectAtIndex:) tarClass:@"__NSArrayM" tarSel:@selector(objectAtIndex:)];
    });
}

@end
