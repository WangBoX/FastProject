//
//  SafeKitMacro.h
//  SafeKit
//
//  Created by WBO on 2016/10/01.
//  Copyright © 2016年 WBO. All rights reserved.
//

#if __has_feature(objc_arc)
#define SK_AUTORELEASE(exp) exp
#define SK_RELEASE(exp) exp
#define SK_RETAIN(exp) exp
#else
#define SK_AUTORELEASE(exp) [exp autorelease]
#define SK_RELEASE(exp) [exp release]
#define SK_RETAIN(exp) [exp retain]
#endif
