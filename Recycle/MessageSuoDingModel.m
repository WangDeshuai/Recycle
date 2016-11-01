//
//  MessageSuoDingModel.m
//  Recycle
//
//  Created by Macx on 16/6/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MessageSuoDingModel.h"

@implementation MessageSuoDingModel
-(id)initWithMessageID:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _messageID=[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"id"]]];
        _titleName=[self string:[dic objectForKey:@"title"]];
        _type=[self string:[dic objectForKey:@"type"]];
        _infoClass=[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"Infoclass"]]];//[self string:[dic objectForKey:@"Infoclass"]];
        _addTime=[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"addtime"]]];
    }
    
    return self;
}

//过滤一下
-(NSString*)string:(id)sss
{
    
    NSString * a=@"";
    if (sss==[NSNull null]) {
        a=@"";
    }else{
        a=sss;
    }
    return a;
    
}
@end
