//
//  HYData.h
//  Recycle
//
//  Created by Macx on 16/7/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYPeople.h"
@interface HYData : NSObject

{
    NSManagedObjectContext *_context;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_model;
    HYData * _dao;
}

//连接数据库
-(void)connectSqlite;
//插入数据
- (void)insertPeopleWithName:(NSString *)name Name1:(NSString *)name1 Name2:(NSString *)name2 Name3:(NSString *)name3 Name4:(NSString *)name4  Cid:(NSString*)cid PinYin:(NSString*)pinyin;
//检索
-(NSArray*)searchAllPeople;
//更新
-(void)updateWithPeople:(HYPeople *)people;
//删除数据
- (void)deleteWithPeople:(HYPeople *)p;
@end
