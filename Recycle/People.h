//
//  People.h
//  Recycle
//
//  Created by Macx on 16/6/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface People : NSManagedObject

@property (nullable, nonatomic, retain) NSString *messID;
@property (nullable, nonatomic, retain) NSString *titleName;
@property (nullable, nonatomic, retain) NSString *gongQiu;
@property (nullable, nonatomic, retain) NSString *timeSc;
@end

NS_ASSUME_NONNULL_END

#import "People+CoreDataProperties.h"
