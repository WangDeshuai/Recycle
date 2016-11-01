//
//  vipIDModel.m
//  Recycle
//
//  Created by Macx on 16/6/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "vipIDModel.h"

@implementation vipIDModel


-(id)initWithDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
       
        _titleName=[self string:[dic objectForKey:@"us_contact"]];
        NSString * sheng =[self string:[self string:[dic objectForKey:@"us_prov_name"]]];
        NSString * shi =[self string:[self string:[dic objectForKey:@"us_city_name"]]];
        _diquName=[NSString stringWithFormat:@"%@-%@",sheng,shi];
        _zhuyingYewu=[self string:[dic objectForKey:@"us_area"]];
        NSString * url =[self string:[dic objectForKey:@"us_face"]];
        _headUrl=url;//他自己添加前缀
       //_headUrl=[NSString stringWithFormat:@"%@%@",FUWU,url];
        _commperName=[self string:[dic objectForKey:@"us_company"]];
        _vipName=[self string:[dic objectForKey:@"us_vipname"]];
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
