//
//  MessageSuoDingModel.h
//  Recycle
//
//  Created by Macx on 16/6/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageSuoDingModel : NSObject
@property(nonatomic,copy)NSString * messageID;
@property(nonatomic,copy)NSString*titleName;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * infoClass;
@property(nonatomic,copy)NSString*addTime;
-(id)initWithMessageID:(NSDictionary*)dic;
@end
