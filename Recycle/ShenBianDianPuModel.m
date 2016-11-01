//
//  ShenBianDianPuModel.m
//  Recycle
//
//  Created by Macx on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShenBianDianPuModel.h"

@implementation ShenBianDianPuModel
-(id)initWithShenBianDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _titleName=[self string:[dic objectForKey:@"us_company"]];
        NSString * s =[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"us_id"]]];
        _yongHuID=s;
        _zhuYingName=[self string:[dic objectForKey:@"us_dealin"]];
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
