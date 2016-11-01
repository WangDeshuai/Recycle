//
//  Message.h
//  Recycle
//
//  Created by Macx on 16/6/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property ( nonatomic ,copy)NSString * info;
@property ( nonatomic ,assign)BOOL    isSelf;
@property ( nonatomic ,copy)NSString * headerImgName;
@property ( nonatomic ,copy)NSString * bubbleImgName;
@property ( nonatomic ,copy)NSString * date;
- (id)initWithInfo:(NSString *)info isSelf:(BOOL)isSelf headerImgName:(NSString *)headerImgName bubbleImgName:(NSString *)bubbleImgName date:(NSString *)date;
@end
