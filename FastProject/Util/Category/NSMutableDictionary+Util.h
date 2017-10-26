//
//  NSMutableDictionary+RejectNil.h
//  WBO
//
//  Created by WBO on 16/4/15.
//  Copyright © 2015 WBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Util)

-(void)setObjectExceptNil:(NSObject*)object forKey:(NSString*)key;

@end
