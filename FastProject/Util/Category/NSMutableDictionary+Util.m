//
//  NSMutableDictionary+RejectNil.m
//  WBO
//
//  Created by WBO on 16/4/15.
//  Copyright © 2015 WBO. All rights reserved.
//

#import "NSMutableDictionary+Util.h"

@implementation NSMutableDictionary (Util)

-(void)setObjectExceptNil:(id)object forKey:(id)key
{
    if (![NSObject isEmpty:object]) {
        [self setValue:object forKey:key];
    }
}


@end
