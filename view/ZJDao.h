//
//  ZJDao.h
//  Recycle
//
//  Created by Macx on 16/7/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyZuJi.h"
@interface ZJDao : NSObject

{
    NSManagedObjectContext *_context;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_model;
    MyZuJi * _dao;
}

//连接数据库
-(void)connectSqlite;
//插入数据
- (void)insertPeopleWithName:(NSString *)name psw:(NSString*)pswWord gongqiu:(NSString*)gq timeSc:(NSString*)time Publictime:(NSString*)publictime;
//检索
-(NSArray*)searchAllPeople;
//根据谁去查找谁
-(NSMutableArray*)searchWhoPeople:(NSString*)name;
//根据messID去查找有没有相同的
-(NSMutableArray*)searchWhoMessageID:(NSString*)name;
//更新
-(void)updateWithPeople:(MyZuJi *)people;
//删除数据
- (void)deleteWithPeople:(MyZuJi *)p;

@end
