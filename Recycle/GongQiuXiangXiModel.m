//
//  GongQiuXiangXiModel.m
//  Recycle
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GongQiuXiangXiModel.h"

@implementation GongQiuXiangXiModel
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _titleName= [self string:[dic objectForKey:@"gq_title"]];
        
        _youHuID=[self string:[dic objectForKey:@"gq_uid"]];
        _companyName=[self string:[dic objectForKey:@"gq_company"]];
        
        NSString * s =[NSString stringWithFormat:@"%@-%@",[self string:[dic objectForKey:@"gq_prov_name"]],[self string:[dic objectForKey:@"gq_city_name"]]];
        _diQu=s;
        
        _price=[self string:[dic objectForKey:@"gq_pro_price"]];
         _publicTime=[self string:[dic objectForKey:@"gq_htmltime"]];
       
        
        _shuLiang=[self string:[dic objectForKey:@"gq_pro_count"]];

        _guiGe=[self string:[dic objectForKey:@"gq_pro_size"]];
        _chanpincontent=[self string:[dic objectForKey:@"gq_content"]];
//        us_Introduction公司简介 us_dealin主营 us_area经验范围
        _usercontent=[self string:[dic objectForKey:@"us_area"]];
         _vipname=[self string:[dic objectForKey:@"gq_vipclass"]];
        _username=[self string:[dic objectForKey:@"gq_contact"]];
        
        _handtel=[self string:[dic objectForKey:@"gq_handtel"]];
        _tell=[self string:[dic objectForKey:@"gq_tel"]];
        _piccc=[self string:[dic objectForKey:@"gq_pro_pic"]];
        _suozi=[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"islock"]]];
    }
    return self;
}
-(id)initWithZiChanXQ:(NSDictionary*)dic{
    self = [super init];
    if (self)
    {
        
        _titleName=[self string:[dic objectForKey:@"zc_title"]];
        _youHuID=[self string:[dic objectForKey:@"zc_uid"]];
        _companyName=[self string:[dic objectForKey:@"zc_company"]];
        NSString * sheng =[self string:[dic objectForKey:@"zc_prov_name"]];
        NSString * shi =[self string:[dic objectForKey:@"zc_city_name"]];
        NSString * diqu =[NSString stringWithFormat:@"%@-%@",sheng,shi];
        _diQu=diqu;
        _price= [self string:[dic objectForKey:@"zc_pro_price"]];
        _publicTime=[self string:[dic objectForKey:@"zc_htmltime"]];
        _shuLiang=[self string:[dic objectForKey:@"zc_pro_count"]];
        _guiGe=[self string:[dic objectForKey:@"zc_pro_size"]];
        
        _suozi=[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"islock"]]];
        _chanpincontent=[self string:[dic objectForKey:@"zc_content"]];
        _username=[self string:[dic objectForKey:@"zc_contact"]];
        _vipname=[self string:[dic objectForKey:@"zc_vipclass"]];
        _usercontent=[self string:[dic objectForKey:@"us_area"]];//主营业务gq_pro_name  zc_content us_area
        
        _handtel=[self string:[dic objectForKey:@"zc_handtel"]];
        _tell=[self string:[dic objectForKey:@"zc_tel"]];
         _piccc=[self string:[dic objectForKey:@"zc_pro_pic"]];
    }
    return self;
}

//解析图片的详情页的图片
-(id)initWithPicDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _picadd=[self string:[dic objectForKey:@"pic_add"]];
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
        a=[NSString stringWithFormat:@"%@",sss] ;
    }
    return a;
    
    
    
}
-(void)zidian{
    NSMutableDictionary * vipDic =[NSMutableDictionary new];
    [vipDic setObject:@"未审核" forKey:@"0"];
    [vipDic setObject:@"普通用户" forKey:@"1"];
    [vipDic setObject:@"申请中" forKey:@"2"];
    [vipDic setObject:@"临时会员" forKey:@"3"];
    [vipDic setObject:@"过期会员" forKey:@"4"];
    [vipDic setObject:@"采集会员" forKey:@"5"];
    [vipDic setObject:@"大企业会员" forKey:@"9"];
    [vipDic setObject:@"财富通(网站)" forKey:@"11"];
    
    [vipDic setObject:@"财富通(拍卖)" forKey:@"12"];
    [vipDic setObject:@"财富通(供求)" forKey:@"13"];
    [vipDic setObject:@"财富通至尊" forKey:@"14"];
    [vipDic setObject:@"资产VIP" forKey:@"15"];
    
    [vipDic setObject:@"钻石VIP" forKey:@"16"];
    [vipDic setObject:@"银钻" forKey:@"17"];
    
}
//过滤一下
//-(NSString*)string:(id)sss
//{
//    
//    NSString * a=@"";
//    if (sss==[NSNull null]) {
//        a=@"";
//    }else{
//        a=sss;
//    }
//    return a;
//    
//}
@end
