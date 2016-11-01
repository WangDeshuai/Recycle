//
//  HYPeople.h
//  Recycle
//
//  Created by Macx on 16/7/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYPeople : NSManagedObject

@property (nullable, nonatomic, retain) NSString *ggcid;
@property (nullable, nonatomic, retain) NSString *namehy;
@property (nullable, nonatomic, retain) NSString *pinyin;
@property (nullable, nonatomic, retain) NSString *name2;
@property (nullable, nonatomic, retain) NSString *name1;
@property (nullable, nonatomic, retain) NSString *name3;
@property (nullable, nonatomic, retain) NSString *name4;

@end

NS_ASSUME_NONNULL_END

#import "HYPeople+CoreDataProperties.h"
