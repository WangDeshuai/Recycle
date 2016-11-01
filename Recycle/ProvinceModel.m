//
//  ProvinceModel.m
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel
- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
        _pName=[dic objectForKey:@"p_name"];
        _pCode= [NSString stringWithFormat:@"%@",[dic objectForKey:@"p_code"]];
        _pSname=[dic objectForKey:@"p_sname"];
        _pPinyin=[dic objectForKey:@"p_pinyin"];
        _pID=[dic objectForKey:@"p_id"];
    }
    
    
    return self;
}


//市
-(id)initWithCitydic:(NSDictionary *)Citydic
{ self = [super init];
    if (self)
    {
        _pName=[Citydic objectForKey:@"c_name"];
        _pCode= [NSString stringWithFormat:@"%@",[Citydic objectForKey:@"c_code"]];
        _pSname=[Citydic objectForKey:@"c_sname"];
        _pPinyin=[Citydic objectForKey:@"c_pinyin"];
        _pID=[NSString stringWithFormat:@"%@",[Citydic objectForKey:@"c_pid"]];//   [Citydic objectForKey:@"c_pid"];
    
    
    }
  return self;
}
@end
