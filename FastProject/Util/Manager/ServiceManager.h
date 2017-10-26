//
//  ServiceManager.h
//  MoodGood
//
//  Created by WBO on 2017/10/16.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceManager : NSObject
+ (instancetype)sharedManager;
- (void)start;
@end
