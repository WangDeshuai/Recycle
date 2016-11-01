//
//  CityData.h
//  Recycle
//
//  Created by Macx on 16/7/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityPeople.h"
@interface CityData : NSObject

{
    NSManagedObjectContext *_context;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_model;
    NSData * _dao;
}

//连接数据库
-(void)connectSqlite;
//插入数据
- (void)insertPeopleWithName:(NSString *)name Sname:(NSString*)sname Pid:(NSString*)pid Code:(NSString*)code PinYin:(NSString*)pinyin;
//检索
-(NSArray*)searchAllPeople;
//根据id查询城市
-(NSMutableArray*)genJuPid:(NSString*)pid;
//查询省份
-(NSMutableArray*)shengFenChaXun;

//更新
-(void)updateWithPeople:(CityPeople *)people;
//删除数据
- (void)deleteWithPeople:(CityPeople *)p;


@end
