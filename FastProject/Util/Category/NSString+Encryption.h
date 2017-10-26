#import <Foundation/Foundation.h>

@interface NSString (Encryption)

@property (nonatomic, readonly) NSString *md5;

//获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (NSString *)getUUID;//获取设备uuid
@end
