//
//  NSFileLocationHelper
//  NSFileLocationHelper
//
//  Created by WBO on 16/4/12.
//  Copyright (c) 2016年  WBO. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VideoExt   (@"mp4")
#define ImageExt   (@"jpg")


@interface NSFileLocationHelper : NSObject

+ (NSString *)getAppDocumentPath;

+ (NSString *)getAppTempPath;

+ (NSString *)userDirectory;

+ (NSString *)genFilenameWithExt:(NSString *)ext;

+ (NSString *)filepathForVideo:(NSString *)filename;

+ (NSString *)filepathForImage:(NSString *)filename;

@end
