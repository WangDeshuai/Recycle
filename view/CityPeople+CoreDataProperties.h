//
//  CityPeople+CoreDataProperties.h
//  Recycle
//
//  Created by Macx on 16/7/14.
//  Copyright © 2016年 mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CityPeople.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityPeople (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *pid;
@property (nullable, nonatomic, retain) NSString *pcode;
@property (nullable, nonatomic, retain) NSString *pname;
@property (nullable, nonatomic, retain) NSString *psname;
@property (nullable, nonatomic, retain) NSString *ppinyin;

@end

NS_ASSUME_NONNULL_END
