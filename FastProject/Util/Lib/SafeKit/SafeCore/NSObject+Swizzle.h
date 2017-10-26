//
//  NSObject+swizzle.h
//  SafeKit
//
//  Created by WBO on 2016/10/01.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * This category adds methods to the NSObject.
 */
@interface NSObject(Swizzle)

/*
 * To swizzle two selector for self class.
 * @param srcSel source selector
 * @param tarSel target selector
 */
+(void)safe_swizzleMethod:(SEL)srcSel tarSel:(SEL)tarSel;

/*
 * To swizzle two selector from self class to target class.
 * @param srcSel source selector
 * @param tarClassName target class name string
 * @param tarSel target selector
 */
+(void)safe_swizzleMethod:(SEL)srcSel tarClass:(NSString *)tarClassName tarSel:(SEL)tarSel;

/*
 * To swizzle two selector from self class to target class.
 * @param srcClass source class
 * @param srcSel source selector
 * @param tarClass target class
 * @param tarSel target selector
 */
+(void)safe_swizzleMethod:(Class)srcClass srcSel:(SEL)srcSel tarClass:(Class)tarClass tarSel:(SEL)tarSel;

@end
