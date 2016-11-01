//
//  BaoJiaModel.m
//  Recycle
//
//  Created by Macx on 16/5/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaoJiaModel.h"

@implementation BaoJiaModel
//报价列表
-(id)initWithBaoJia:(NSDictionary*)dic{
    self=[super init];
    if (self) {
      
          _messageID=[self string:[dic objectForKey:@"bj_id"]];
          _titleName=[self string:[dic objectForKey:@"bj_title"]];
          _publicTime=[self string:[dic objectForKey:@"bj_addtime"]];
        
    }
    return self;
}


//报价详情
-(id)initWithBaoJiaXiangQing:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _btitleName=[self string:[dic objectForKey:@"bj_title"]];
        _bContent=[self string:[dic objectForKey:@"bj_content"]];
        _bpublicTime=[self string:[dic objectForKey:@"bj_addtime"]];
        _messageLaiYuan=[self string:[dic objectForKey:@""]];
        
    }
    
    return self;
}
//相关报价
-(id)initWithXiangGuanBaoJia:(NSDictionary*)dic{
    
    self=[super init];
    if (self) {
        _xtitleName=[self string:[dic objectForKey:@"bj_title"]];
        _xtcName=[self string:[dic objectForKey:@"bj_cname"]];
    }
    
    return self;
    
}
//报价分类
-(id)initWithBaoJiaClass:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _btnName=[self string:[dic objectForKey:@"bj_cname"]];
        _messageCid=[self string:[dic objectForKey:@"bj_cid"]];
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
