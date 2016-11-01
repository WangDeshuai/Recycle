//
//  HYPeople+CoreDataProperties.h
//  Recycle
//
//  Created by Macx on 16/7/14.
//  Copyright © 2016年 mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HYPeople.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYPeople (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *ggcid;
@property (nullable, nonatomic, retain) NSString *namehy;
@property (nullable, nonatomic, retain) NSString *pinyin;
@property (nullable, nonatomic, retain) NSString *name2;
@property (nullable, nonatomic, retain) NSString *name1;
@property (nullable, nonatomic, retain) NSString *name3;
@property (nullable, nonatomic, retain) NSString *name4;

@end

NS_ASSUME_NONNULL_END
