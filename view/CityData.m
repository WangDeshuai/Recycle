//
//  CityData.m
//  Recycle
//
//  Created by Macx on 16/7/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CityData.h"

@implementation CityData
//连接数据库
- (void)connectSqlite{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"CityModel.sqlite"];
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
- (void)insertPeopleWithName:(NSString *)name Sname:(NSString*)sname Pid:(NSString*)pid Code:(NSString*)code PinYin:(NSString*)pinyin{
    
    CityPeople *p = [NSEntityDescription insertNewObjectForEntityForName:@"CityPeople" inManagedObjectContext:_context];
    p.pname = name;
    p.pcode=[NSString stringWithFormat:@"%@",code];
    p.psname=sname;
    p.pid=[NSString stringWithFormat:@"%@",pid];
    p.ppinyin=pinyin;
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"失败》》》》》》》》》");
    }
   
    
}
//检索
-(NSArray*)searchAllPeople
{
    NSFetchRequest * req = [[NSFetchRequest alloc]init];
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"CityPeople" inManagedObjectContext:_context];
    
    [req setEntity:entityDescription];
    
    
    NSArray * result = [_context executeFetchRequest:req error:nil];
    
    return result;
}

//更新
-(void)updateWithPeople:(CityPeople *)people
{
    NSError * error = nil;
    if (![_context save:&error]) {
        NSLog(@"更新数据失败");
    }
}
//删除
- (void)deleteWithPeople:(CityPeople *)p{
    
    [_context deleteObject:p];
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"nonono.....");
    }
    
}
//根据pid查询城市
-(NSMutableArray*)genJuPid:(NSString*)pid{
    NSArray * arr =[self searchAllPeople];
    NSMutableArray * array=[NSMutableArray new];
    for (int i = 0; i<arr.count; i++)
    {
        CityPeople * p = arr[i];
        if ([p.pid isEqualToString:pid])
        {
            [array addObject:p];
            NSLog(@"我查出来了，并且加进去了");
        }
    }
    
    return array;
}

//查询省份
-(NSMutableArray*)shengFenChaXun{
    NSArray * arr =[self searchAllPeople];
     NSMutableArray * shengArr=[NSMutableArray new];
    
    if (arr.count==0) {
        
    }else{
        for (int i = 0; i<34; i++)
        {
            CityPeople * p = arr[i];
            //NSLog(@"这是我取到的值%@",p.pname);
            [shengArr addObject:p];
        }
 
    }
   
    
    return shengArr;
}

@end
