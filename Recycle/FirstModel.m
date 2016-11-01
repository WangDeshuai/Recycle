//
//  FirstModel.m
//  Recycle
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FirstModel.h"

@implementation FirstModel
//热门行业*综合行业
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _Onename =[self string:[dic objectForKey:@"gq_cname"]];
        _chirdArr=[dic objectForKey:@"children"];
        _Cid=[self string:[dic objectForKey:@"gq_cid"]];
        _pinYin=[self string:[dic objectForKey:@"gq_pinyin"]];
    }
    
    return self;
}







-(id)initWithLike:(NSDictionary*)dic{
    self = [super init];
    if (self)
    {
        _picUrl =[self string:[dic objectForKey:@"gq_pro_pic"]];
        _titleLabel=[self string:[dic objectForKey:@"gq_title"]];
        _messageID=[self string:[dic objectForKey:@"gq_id"]];
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
