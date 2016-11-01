//
//  FuJinShangJiModel.m
//  Recycle
//
//  Created by Macx on 16/6/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FuJinShangJiModel.h"

@implementation FuJinShangJiModel
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
