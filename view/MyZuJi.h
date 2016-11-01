//
//  MyZuJi.h
//  Recycle
//
//  Created by Macx on 16/7/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyZuJi : NSManagedObject

@property (nullable, nonatomic, retain) NSString *gongqiu;
@property (nullable, nonatomic, retain) NSString *messageid;
@property (nullable, nonatomic, retain) NSString *titlename;
@property (nullable, nonatomic, retain) NSString *timell;
@property (nullable, nonatomic, retain) NSString *publictime;

@end

NS_ASSUME_NONNULL_END

#import "MyZuJi+CoreDataProperties.h"
