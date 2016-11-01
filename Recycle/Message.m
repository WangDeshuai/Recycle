//
//  Message.m
//  Recycle
//
//  Created by Macx on 16/6/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Message.h"

@implementation Message
- (id)initWithInfo:(NSString *)info isSelf:(BOOL)isSelf headerImgName:(NSString *)headerImgName bubbleImgName:(NSString *)bubbleImgName  date:(NSString *)date
{
    self = [super init];
    
    if (self) {
        _info=info;
        _isSelf=isSelf;
        _headerImgName=headerImgName;
        _bubbleImgName=bubbleImgName;
        _date=date;
    
    }

    return self;
}
@end
