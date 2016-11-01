//
//  SearchDao.h
//  Recycle
//
//  Created by Macx on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZuiJinSearch.h"
@interface SearchDao : NSObject

{
    NSManagedObjectContext *_context;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_model;
    SearchDao * _dao;
}

//连接数据库
-(void)connectSqlite;
//插入数据
- (void)insertPeopleWithName:(NSString *)name;
//检索
-(NSArray*)searchAllPeople;
//更新
-(void)updateWithPeople:(ZuiJinSearch *)people;
//删除数据
- (void)deleteWithPeople:(ZuiJinSearch *)p;
//+(SearchDao *)shareMange;
@end
