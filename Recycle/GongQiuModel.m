//
//  GongQiuModel.m
//  Recycle
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GongQiuModel.h"

@implementation GongQiuModel
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _titleName= [self string:[dic objectForKey:@"gq_title"]];    ;
        
        _price=[self string:[dic objectForKey:@"gq_pro_price"]];
       // _vip=[dic objectForKey:@""];
        _vip=@"普通会员";
        NSString * sheng =[self string:[dic objectForKey:@"gq_prov_name"]];
        NSString * shi =[self string:[dic objectForKey:@"gq_city_name"]];//
        _diqu=[NSString stringWithFormat:@"%@-%@",sheng,shi];
        _time=[self string:[dic objectForKey:@"gq_addtime"]];
        _imageUrl=[self string:[dic objectForKey:@"gq_pro_pic"]];
        _shuliangLab=[self string:[dic objectForKey:@"gq_pro_count"]];
        _guigeLab=[self string:[dic objectForKey:@"gq_pro_size"]];
        _typeName=[self string:[dic objectForKey:@"gq_cname"]];
        _uidd=[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"us_id"]]];
        _comanyName=[self string:[dic objectForKey:@"us_company"]];
        _jianjieLab=[self string:[dic objectForKey:@"gq_content"]];
        _vipname=[self string:[dic objectForKey:@"us_vipname"]];
        _username=[self string:[dic objectForKey:@"us_user"]];
        _messageID=[self string:[dic objectForKey:@"gq_id"]];
          _hangYe=[self string:[dic objectForKey:@"gq_cname"]];
        NSMutableArray * imageArr =[dic objectForKey:@"listpic"];
        if (imageArr.count==0)
        {
            
        }else{
            _imageArr=imageArr;
        }
    }
    
    
    return self;
}

-(id)initWithZiChan:(NSDictionary*)dic{
    
    self = [super init];
    if (self)
    {
        
        _titleName= [self string:[dic objectForKey:@"zc_title"]];    ;
        
        _price=[self string:[dic objectForKey:@"zc_pro_price"]];
        // _vip=[dic objectForKey:@""];
        _vip=@"普通会员";
        NSString * sheng =[self string:[dic objectForKey:@"zc_prov_name"]];
        NSString * shi =[self string:[dic objectForKey:@"zc_city_name"]];//
        _diqu=[NSString stringWithFormat:@"%@-%@",sheng,shi];
        _time=[self string:[dic objectForKey:@"zc_htmltime"]];
        _imageUrl=[self string:[dic objectForKey:@"zc_pro_pic"]];
        _shuliangLab=[self string:[dic objectForKey:@"zc_pro_count"]];
        _guigeLab=[self string:[dic objectForKey:@"zc_pro_size"]];
         _typeName=[self string:[dic objectForKey:@"zc_cname"]];
        
        _comanyName=[self string:[dic objectForKey:@"zc_company"]];
        _jianjieLab=[self string:[dic objectForKey:@"zc_content"]];
        _vipname=[self string:[dic objectForKey:@"zc_vipname"]];
        _username=[self string:[dic objectForKey:@"zc_user"]];
        _messageID=[self string:[dic objectForKey:@"zc_id"]];
        _hangYe=[self string:[dic objectForKey:@"zc_cname"]];
        NSMutableArray * imageArr =[dic objectForKey:@"listpic"];
        if (imageArr.count==0)
        {
            
        }else{
            _imageArr=imageArr;
        }
        
        
    }
    
    
    return self;
    
    
}


//拍卖
-(id)initWithPaiMai:(NSDictionary*)dic{
    self = [super init];
    if (self)
    {
        
        NSString * sheng =[self string:[dic objectForKey:@"pm_prov_name"]];
        NSString * shi =[self string:[dic objectForKey:@"pm_city_name"]];//
        _diqu=[NSString stringWithFormat:@"%@-%@",sheng,shi];
        _titleName=[self string:[dic objectForKey:@"pm_title"]];
        _time=[self string:[dic objectForKey:@"pm_addtime"]];
        _price=[self string:[dic objectForKey:@"pm_deposit"]];
        _messageID=[self string:[dic objectForKey:@"pm_id"]];
         _typeName=[self string:[dic objectForKey:@"pm_cname"]];
        
        _comanyName=[self string:[dic objectForKey:@"pm_company"]];
        _jianjieLab=[self string:[dic objectForKey:@"pm_content"]];
        _vipname=[self string:[dic objectForKey:@"pm_vipname"]];
        _username=[self string:[dic objectForKey:@"pm_uname"]];//pm_user
        _messageID=[self string:[dic objectForKey:@"pm_id"]];
        _hangYe=[self string:[dic objectForKey:@"pm_cname"]];
        
        _phoneNumber=[self string:[dic objectForKey:@"pm_handtel"]];
        _starDate=[self string:[dic objectForKey:@"pm_begindate"]];
        _endDate=[self string:[dic objectForKey:@"pm_enddate"]];
        _address=[self string:[dic objectForKey:@"pm_address"]];
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
