//
//  HangYeClassModel.m
//  Recycle
//
//  Created by Macx on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HangYeClassModel.h"

@implementation HangYeClassModel
-(id)initWithOneDic:(NSDictionary*)dic{
    
    self=[super init];
    if (self) {
        
        _titleName=[self string:[dic objectForKey:@"gq_cname"]];
        NSString * cid =[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"gq_cid"]]];
        _cid=cid;
        _pinYin=[self string:[dic objectForKey:@"gq_pinyin"]];
        
    }
    
    return self;
}
//二级分类的
-(id)initWithTwoDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _titleName=[self string:[dic objectForKey:@"gq_cname"]];
        NSString * cid =[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"gq_cid"]]];
        _cid=cid;
        _pinYin=[self string:[dic objectForKey:@"gq_pinyin"]];
//        if ([dic objectForKey:@"list"] ==[NSNull null]) {
//            _listArr=nil;
//        }else{
//            _listArr=[dic objectForKey:@"list"];
//        }
        
    }
    
    return self;
    
}
////三级分类
//-(id)initWithThirdDic:(NSDictionary*)dic{
//    self=[super init];
//    if (self) {
//        _titleName=[self string:[dic objectForKey:@"gq_cname"]];
//        NSString * cid =[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"gq_cid"]]];
//        _cid=cid;
//        _pinYin=[self string:[dic objectForKey:@"gq_pinyin"]];
//        
//    }
//    
//    return self;
//}
//拍卖
-(id)initWithPaiMaiDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _titleName=[self string:[dic objectForKey:@"pm_cname"]];
        NSString * cid =[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"pm_cid"]]];
        _cid=cid;
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
