//
//  LiuYanModel.m
//  Recycle
//
//  Created by Macx on 16/6/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LiuYanModel.h"

@implementation LiuYanModel

-(id)initWithLiuYanLieBiao:(NSDictionary*)dic{
    self=[super init];
    if (self) {
         _liuYanName=[self string:[dic objectForKey:@"mes_sname"]];
        _ruid=[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"mes_ruid"]]];
        _suid=[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"mes_suid"]]];
         _time=[self string:[dic objectForKey:@"mes_adddate"]];
         _liuYanContent=[self string:[dic objectForKey:@"mes_info"]];
        
        if (_isChaKan==NO) {
           _mesview=@"0";
        }else{
            _mesview=@"1";
        }
        //_mesview=[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"mes_view"]]];
        _sname=[self string:[dic objectForKey:@"mes_sname"]];
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
