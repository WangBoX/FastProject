//
//  NSFileLocationHelper
//  NSFileLocationHelper
//
//  Created by WBO on 16/4/12.
//  Copyright (c) 2016年  WBO. All rights reserved.
//

#import "NSFileLocationHelper.h"
#import <sys/stat.h>

#define RDVideo    (@"video")
#define RDImage    (@"image")

@interface NSFileLocationHelper ()
+ (NSString *)filepathForDir: (NSString *)dirname filename: (NSString *)filename;
@end


@implementation NSFileLocationHelper
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@(YES)
                                  forKey:NSURLIsExcludedFromBackupKey
                                   error:&error];
    if(!success)
    {
        DebugLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
    
}
+ (NSString *)getAppDocumentPath
{
    static NSString *appDocumentPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        appDocumentPath= [[NSString alloc]initWithFormat:@"%@/%@/",[paths objectAtIndex:0],kAppBunbleID];
        if (![[NSFileManager defaultManager] fileExistsAtPath:appDocumentPath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:appDocumentPath
                                      withIntermediateDirectories:NO
                                                       attributes:nil
                                                            error:nil];
        }
        [NSFileLocationHelper addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:appDocumentPath]];
    });
    return appDocumentPath;
    
}

+ (NSString *)getAppTempPath
{
    return NSTemporaryDirectory();
}

//+ (NSString *)userDirectory
//{
//    NSString *documentPath = [NSFileLocationHelper getAppDocumentPath];
//   todo： NSString *userID = USER.uid; 用户唯一识别码
//    if ([userID length] == 0)
//    {
//        DebugLog(@"Error: Get User Directory While UserID Is Empty");
//    }
//    NSString* userDirectory= [NSString stringWithFormat:@"%@%@/",documentPath,userID];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:userDirectory])
//    {
//        [[NSFileManager defaultManager] createDirectoryAtPath:userDirectory
//                                  withIntermediateDirectories:NO
//                                                   attributes:nil
//                                                        error:nil];
//
//    }
//    return userDirectory;
//}

+ (NSString *)resourceDir: (NSString *)resouceName
{
    NSString *dir = [[NSFileLocationHelper userDirectory] stringByAppendingPathComponent:resouceName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:dir
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:nil];
    }
    return dir;
}


+ (NSString *)filepathForVideo:(NSString *)filename
{
    return [NSFileLocationHelper filepathForDir:RDVideo
                                     filename:filename];
}

+ (NSString *)filepathForImage:(NSString *)filename
{
    return [NSFileLocationHelper filepathForDir:RDImage
                                     filename:filename];
}

+ (NSString *)genFilenameWithExt:(NSString *)ext
{
    CFUUIDRef uuid = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuid);
    CFRelease(uuid);
    NSString *uuidStr = [[uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
    NSString *name = [NSString stringWithFormat:@"%@",uuidStr];
    return [ext length] ? [NSString stringWithFormat:@"%@.%@",name,ext]:name;
}


#pragma mark - 辅助方法
+ (NSString *)filepathForDir:(NSString *)dirname
                    filename:(NSString *)filename
{
    return [[NSFileLocationHelper resourceDir:dirname] stringByAppendingPathComponent:filename];}

@end
