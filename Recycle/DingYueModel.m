//
//  DingYueModel.m
//  Recycle
//
//  Created by Macx on 16/6/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DingYueModel.h"

@implementation DingYueModel
-(id)initWithTitleDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _sid=[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"S_Id"]]];
        _titleName=[self string:[dic objectForKey:@"S_Condition"]];
        _diqu=[self string:[dic objectForKey:@"S_Name"]];
        NSString * type =[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"S_Type"]]];
        NSString * laiyuan =[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"S_Orgin"]]];
        if ([type isEqualToString:@"1"] || [type isEqualToString:@"2"] ||[type isEqualToString:@"3"] ||[type isEqualToString:@"4"] ) {
             _sTypename=[[self typeDic] objectForKey:type];
        }else{
            _sTypename=@"其它";
        }
        if ([laiyuan isEqualToString:@"1"] || [laiyuan isEqualToString:@"2"] ||[laiyuan isEqualToString:@"3"] ) {
              _laiyuan=[[self layYuanDic] objectForKey:laiyuan];
        }else{
            _laiyuan=@"不限";
        }
        
        
        
      
        
        
    }
    
    return self;
}

-(NSMutableDictionary*)typeDic{
    NSMutableDictionary * dicType =[NSMutableDictionary new];
     [dicType setObject:@"供应" forKey:@"1"];
     [dicType setObject:@"求购" forKey:@"2"];
     [dicType setObject:@"资产" forKey:@"3"];
     [dicType setObject:@"拍卖" forKey:@"4"];
    return dicType;
}

-(NSMutableDictionary*)layYuanDic{
    NSMutableDictionary * dicType =[NSMutableDictionary new];
    [dicType setObject:@"普通会员" forKey:@"1"];
    [dicType setObject:@"企业会员" forKey:@"2"];
    [dicType setObject:@"高级会员" forKey:@"3"];
    //[dicType setObject:@"拍卖" forKey:@"4"];
    return dicType;
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
