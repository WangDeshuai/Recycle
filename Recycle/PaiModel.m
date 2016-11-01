//
//  PaiModel.m
//  Recycle
//
//  Created by Macx on 16/5/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PaiModel.h"

@implementation PaiModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
         _titleName=[self string:[dic objectForKey:@"pm_title"]];
        NSString * sheng =[self string:[dic objectForKey:@"pm_prov_name"]];
        NSString * shi =[self string:[dic objectForKey:@"pm_city_name"]];
        _diqu=[NSString stringWithFormat:@"%@-%@",sheng,shi];
        _publicTime=[self string:[dic objectForKey:@"pm_addtime"]];
        //拍卖时间与发布时间目前用的一个参数，找不到拍卖时间
         _baomingTime=[self string:[dic objectForKey:@"pm_addtime"]];
         _baozhengPrice=[self string:[dic objectForKey:@"pm_deposit"]];
         _commName=[self string:[dic objectForKey:@"pm_company"]];
         _fuzePeople=[self string:[dic objectForKey:@"pm_contact"]];
         _callNumber=[self string:[dic objectForKey:@"pm_tel"]];
         _phoneNumber=[self string:[dic objectForKey:@"pm_handtel"]];
         _chuanZhen=[self string:[dic objectForKey:@"pm_fax"]];
         _email=[self string:[dic objectForKey:@"pm_email"]];
        
         _content=[self string:[dic objectForKey:@"pm_content"]];
        
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
