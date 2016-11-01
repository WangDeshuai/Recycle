//
//  HYData.m
//  Recycle
//
//  Created by Macx on 16/7/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HYData.h"

@implementation HYData
//连接数据库
- (void)connectSqlite{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HyModel.sqlite"];
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
- (void)insertPeopleWithName:(NSString *)name Name1:(NSString *)name1 Name2:(NSString *)name2 Name3:(NSString *)name3 Name4:(NSString *)name4  Cid:(NSString*)cid PinYin:(NSString*)pinyin{
    
    HYPeople *p = [NSEntityDescription insertNewObjectForEntityForName:@"HYPeople" inManagedObjectContext:_context];
    p.namehy=name;
    p.ggcid= [NSString stringWithFormat:@"%@",cid];
    p.pinyin=pinyin;
    if (name1) {
        p.name1=name1;
    }
    if (name2) {
        p.name2=name2;
    }
  
//    p.name3=name3;
//    p.name4=name4;
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
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"HYPeople" inManagedObjectContext:_context];
    
    [req setEntity:entityDescription];
    
    
    NSArray * result = [_context executeFetchRequest:req error:nil];
    
    return result;
}

//更新
-(void)updateWithPeople:(HYPeople *)people
{
    NSError * error = nil;
    if (![_context save:&error]) {
        NSLog(@"更新数据失败");
    }
}
//删除
- (void)deleteWithPeople:(HYPeople *)p{
    
    [_context deleteObject:p];
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"nonono.....");
    }
    
}
//查找主表
-(NSMutableArray*)LookTableViewLeft{
    NSArray * ar =[self searchAllPeople];
    NSMutableArray * array=[NSMutableArray new];
    for (HYPeople * p in ar) {
        if (p.name1) {
            NSLog(@"p有值可以添加");
            [array addObject:p];
            
        }
    }
    return array;
}
-(NSMutableArray*)genJuPid:(NSString*)pid{
      NSArray * arr =[self searchAllPeople];
    NSMutableArray * array=[NSMutableArray new];
    for (int i = 0; i<arr.count; i++)
    {
        HYPeople * p = arr[i];
        if ([p.name2 isEqualToString:pid])
        {
            [array addObject:p];
            NSLog(@"我查出行业来了，并且加进去了");
        }
    }

    return array;
}
@end
