//
//  WBKeyValueStore.h
//  WBO
//
//  Created by WBO on 12-11-6.
//  Copyright (c) 2012年 WBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBKeyValueItem : NSObject

@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) id itemObject;
@property (strong, nonatomic) NSDate *createdTime;

@end


@interface WBKeyValueStore : NSObject

// 打开名为dbName的数据库，如果该文件不存在，则创新一个新的。
- (id)initDBWithName:(NSString *)dbName;

- (id)initWithDBWithPath:(NSString *)dbPath;

//通过createTableWithName方法，我们可以在打开的数据库中创建表，如果表名已经存在，则会忽略该操作。
- (void)createTableWithName:(NSString *)tableName;

- (BOOL)isTableExists:(NSString *)tableName;

// 清除数据表中所有数据
- (void)clearTable:(NSString *)tableName;

- (void)dropTable:(NSString *)tableName;

- (void)close;

/************************ Put&Get methods ************************/
//WBKeyValueStore类提供key-value的存储接口，存入的所有数据需要提供key以及其对应的value，读取的时候需要提供key来获得相应的value。
//WBKeyValueStore类支持的value类型包括：NSString, NSNumber, NSDictionary和NSArray，为此提供了以下接口
//与此对应，有value为NSString, NSNumber, NSDictionary和NSArray的读取接口

- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;

- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

// 获得指定key的数据
- (WBKeyValueItem *)getWBKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName;

- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName;

- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName;

- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName;

- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;

// 获得所有数据
- (NSArray *)getAllItemsFromTable:(NSString *)tableName;

- (NSUInteger)getCountFromTable:(NSString *)tableName;

// 删除指定key的数据
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

// 批量删除一组key数组的数据
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;

// 批量删除所有带指定前缀的数据
- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName;


@end
