//
//  ZYData.h
//  beauty
//
//  Created by mac on 15-12-29.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "People.h"
@interface ZYData : NSObject

{
    NSManagedObjectContext *_context;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_model;
     ZYData * _dao;
}

//连接数据库
-(void)connectSqlite;
//插入数据
- (void)insertPeopleWithName:(NSString *)name psw:(NSString*)pswWord gongqiu:(NSString*)gq timeSc:(NSString*)time;
//检索
-(NSArray*)searchAllPeople;
//更新
-(void)updateWithPeople:(People *)people;
//删除数据
- (void)deleteWithPeople:(People *)p;
+(ZYData *)shareMange;

@end
