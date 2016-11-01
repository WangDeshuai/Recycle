//
//  VipQuanXianModel.m
//  Recycle
//
//  Created by Macx on 16/7/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "VipQuanXianModel.h"

@implementation VipQuanXianModel
-(id)initWithVipDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _opration=[self string:[dic objectForKey:@"opration"]];
           _leave=[self string:[dic objectForKey:@"leave"]];
           _total=[self string:[dic objectForKey:@"total"]];
        
    }
    
    return self;
}
//升级特权
-(id)initWithShengJiTeQuanDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _sixpic=[self string:[dic objectForKey:@"pic"]];
        _name=[self string:[dic objectForKey:@"name"]];
        _vipClass=[self string:[dic objectForKey:@"viplevel"]];
        _Money=[self string:[dic objectForKey:@"Money"]];
        _year=[self string:[dic objectForKey:@"year"]];

    }
    return self;
}
//海量商机,暴力宣传，私人秘书
-(id)initWithHaiLiangShangJiDic:(NSDictionary*)dic;
{
    self=[super init];
    if (self) {
        _titleName=[self string:[dic objectForKey:@"title"]];
        _valueName=[self string:[dic objectForKey:@"value"]];

    }
    
    return self;
}
//支付方式
-(id)initWithZhiFuPayDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _bankimg=[self string:[dic objectForKey:@"bankimg"]];
        _bankname=[self string:[dic objectForKey:@"bankname"]];
        _kahao=[self string:[dic objectForKey:@"bankaccount"]];
        _yinHangAddress=[self string:[dic objectForKey:@"openbank"]];
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
