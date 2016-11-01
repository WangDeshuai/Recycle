//
//  ZJDao.m
//  Recycle
//
//  Created by Macx on 16/7/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZJDao.h"

@implementation ZJDao
//连接数据库
- (void)connectSqlite{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ZuJi.sqlite"];
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
- (void)insertPeopleWithName:(NSString *)name psw:(NSString*)pswWord gongqiu:(NSString*)gq timeSc:(NSString*)time Publictime:(NSString*)publictime{
    
    MyZuJi *p = [NSEntityDescription insertNewObjectForEntityForName:@"MyZuJi" inManagedObjectContext:_context];
    p.titlename = name;
    p.messageid=[NSString stringWithFormat:@"%@",pswWord];
    p.gongqiu=gq;
    p.timell=time;
    p.publictime=publictime;
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"失败》》》》》》》》》");
    }
    
    
}
//检索
-(NSArray*)searchAllPeople
{
    NSFetchRequest * req = [[NSFetchRequest alloc]init];
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"MyZuJi" inManagedObjectContext:_context];
    
    [req setEntity:entityDescription];
    
    
    NSArray * result = [_context executeFetchRequest:req error:nil];
    
    return result;
}

-(NSMutableArray*)searchWhoPeople:(NSString*)name{
   NSArray * arr= [self searchAllPeople];
    NSMutableArray * array=[NSMutableArray new];;
   // NSLog(@"看看%@",name);
    for (int i = 0; i<arr.count; i++)
    {
        MyZuJi * p = arr[i];
//        NSLog(@"传过来的时间%@",name);
//        NSLog(@"存的数据库时间%@",p.timell);
        if ([p.timell isEqualToString:name])
        {
            [array addObject:p];
        }
        
        
    }
    
    return array;
}
//根据messID去查找有没有相同的
-(NSMutableArray*)searchWhoMessageID:(NSString*)name{
    NSArray * arr= [self searchAllPeople];
    NSMutableArray * array=[NSMutableArray new];
    
    for (int i = 0; i<arr.count; i++)
    {
        MyZuJi * p = arr[i];
        if ([name intValue]==[p.messageid intValue])
        {
            //NSLog(@"相等");
            [array addObject:p];
        }

    }
    
    return array;
    
    
}

//更新
-(void)updateWithPeople:(MyZuJi *)people
{
    NSError * error = nil;
    if (![_context save:&error]) {
        NSLog(@"更新数据失败");
    }
}
//删除
- (void)deleteWithPeople:(MyZuJi *)p{
    
    [_context deleteObject:p];
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"nonono.....");
    }
    
}
@end
