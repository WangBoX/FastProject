//
//  MainTabController.h
//  MoodGood
//
//  Created by WBO on 2017/10/12.
//  Copyright © 2017年 MoodGood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabController : UITabBarController
+ (instancetype)instance;
@property (nonatomic,copy)  NSDictionary *configs;
@end
