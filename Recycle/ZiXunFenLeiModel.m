//
//  ZiXunFenLeiModel.m
//  Recycle
//
//  Created by Macx on 16/5/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZiXunFenLeiModel.h"

@implementation ZiXunFenLeiModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _titleName= [self string:[dic objectForKey:@"n_cname"]];
        _classID=[self string:[dic objectForKey:@"n_cid"]];
        _nbcID=[self string:[dic objectForKey:@"n_bcid"]];
    }
    
    return self;
}


-(id)initWithZiXunTableview:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _titleName1=[self string:[dic objectForKey:@"n_title"]];
        _publicTime=[self string:[dic objectForKey:@"n_addtime"]];
        NSString * ss =[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"n_id"]]];
        _messageID=ss;
        
    }
    return self;
}

-(id)initWithZiXunXiangQing:(NSDictionary*)dic{
    self=[super init];
    if (self) {
         _ziTitleName=[self string:[dic objectForKey:@"n_title"]];
         _zipublicTime=[self string:[dic objectForKey:@"n_addtime"]];
         _ziContent=[self string:[dic objectForKey:@"n_content"]];
         _zimessageLaiyuan=[self string:[dic objectForKey:@"n_source"]];
         _zihtmlUrl=[self string:[dic objectForKey:@"n_htmlurl"]];
    }
    return self;
}
//新闻获取
-(id)initWithNewsXiangQing:(NSDictionary*)dic{
    
    self=[super init];
    if (self) {
        _newsTitle=[self string:[dic objectForKey:@"n_title"]];
        _newsCname=[self string:[dic objectForKey:@"n_cname"]];
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
