//
//  CityPeople.h
//  Recycle
//
//  Created by Macx on 16/7/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityPeople : NSManagedObject
@property (nullable, nonatomic, retain) NSString *pid;
@property (nullable, nonatomic, retain) NSString *pcode;
@property (nullable, nonatomic, retain) NSString *pname;
@property (nullable, nonatomic, retain) NSString *psname;
@property (nullable, nonatomic, retain) NSString *ppinyin;
// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "CityPeople+CoreDataProperties.h"
