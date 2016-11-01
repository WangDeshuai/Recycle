//
//  LiuYanModel.h
//  Recycle
//
//  Created by Macx on 16/6/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiuYanModel : NSObject
@property(nonatomic,copy)NSString * liuYanName;
@property(nonatomic,copy)NSString * time;
@property(nonatomic,copy)NSString *ruid;
@property(nonatomic,copy)NSString *suid;
@property(nonatomic,copy)NSString* liuYanContent;
@property(nonatomic,copy)NSString* mesview;//判断是否查看0没有1查看了
@property(nonatomic,assign)BOOL isChaKan;
@property(nonatomic,copy)NSString * sname;
-(id)initWithLiuYanLieBiao:(NSDictionary*)dic;
@end
