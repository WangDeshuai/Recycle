//
//  ZuiJinSearch.h
//  Recycle
//
//  Created by Macx on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZuiJinSearch : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
@property (nullable, nonatomic, retain) NSString *name;
@end

NS_ASSUME_NONNULL_END

#import "ZuiJinSearch+CoreDataProperties.h"
