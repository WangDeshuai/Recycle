//
//  People+CoreDataProperties.h
//  Recycle
//
//  Created by Macx on 16/6/13.
//  Copyright © 2016年 mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "People.h"

NS_ASSUME_NONNULL_BEGIN

@interface People (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *messID;
@property (nullable, nonatomic, retain) NSString *titleName;
@property (nullable, nonatomic, retain) NSString *gongQiu;
@property (nullable, nonatomic, retain) NSString *timeSc;

@end

NS_ASSUME_NONNULL_END
