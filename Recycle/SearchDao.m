//
//  SearchDao.m
//  Recycle
//
//  Created by Macx on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SearchDao.h"


@implementation SearchDao
//+(SearchDao *)shareMange
//{
//    static dispatch_once_t once;
//    dispatch_once(&once, ^{
//        _dao = [[SearchDao alloc]init];
//        
//    });
//    return _dao;
//}
//连接数据库
- (void)connectSqlite{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Model1.sqlite"];
    NSLog(@"%@",path);
    if ([_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:nil]) {
        _context = [[NSManagedObjectContext alloc]init];
        [_context setPersistentStoreCoordinator:_persistentStoreCoordinator];
    }else{
        abort();
    }
    
    
}
//向表中插入一条新数据
//插入数据
- (void)insertPeopleWithName:(NSString *)name{
    
    ZuiJinSearch *p = [NSEntityDescription insertNewObjectForEntityForName:@"ZuiJinSearch" inManagedObjectContext:_context];
    p.name=name;
//    p.titleName = name;
//    p.messID=[NSString stringWithFormat:@"%@",pswWord];
//    p.gongQiu=gq;
//    p.timeSc=time;
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"失败》》》》》》》》》");
    }
    
    
}
//检索
-(NSArray*)searchAllPeople
{
    NSFetchRequest * req = [[NSFetchRequest alloc]init];
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"ZuiJinSearch" inManagedObjectContext:_context];
    
    [req setEntity:entityDescription];
    
    
    NSArray * result = [_context executeFetchRequest:req error:nil];
    
    return result;
}
//更新
-(void)updateWithPeople:(ZuiJinSearch *)people
{
    NSError * error = nil;
    if (![_context save:&error]) {
        NSLog(@"更新数据失败");
    }
}
//删除
- (void)deleteWithPeople:(ZuiJinSearch *)p{
    
    [_context deleteObject:p];
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"nonono.....");
    }
    
}

@end
