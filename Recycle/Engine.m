//
//  Engine.m
//  Recycle
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Engine.h"

@implementation Engine

#pragma mark -- 首页轮播
+(void)GetFirstLunBosuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
  //http://api.yuike.com/beautymall/api/1.0/client/banner_list.php?yk_appid=1&sid=6b94d8ee8b05caffc4b7c361c0f979f5&yk_pid=1&yk_cbv=2.8.4.2
    NSString * urlStr =[NSString stringWithFormat:@"%@api/login/GetRotationPic",FUWU];
    NSLog(@">>>首页轮播图%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}


#pragma mark -- 登录POST
+(void)LoginName:(NSString*)name Password:(NSString*)mima success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Login/GetLogin",FUWU];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:name forKey:@"name"];
    [parameter setObject:mima forKey:@"password"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"登录的%@",str);
       
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
#pragma mark -- 登录第二步
+(void)LoginUid:(NSString*)uid Code:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
     NSString * urlStr =[NSString stringWithFormat:@"%@api/Login/GetLoginStep2",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:uid forKey:@"Uid"];
    [parameter setObject:code forKey:@"Code"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"登录的第二部%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    
    
}
#pragma mark -- 注册会员
+(void)Register:(NSString*)name Password:(NSString*)mima  Phone:(NSString*)phone YanZheng:(NSString*)yanzhengm success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Customer/Register",FUWU];
   //  NSLog(@"注册是%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:name forKey:@"us_user"];
    [parameter setObject:mima forKey:@"us_password"];
    [parameter setObject:phone forKey:@"us_handtel"];
    [parameter setObject:yanzhengm forKey:@"Verification"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData * data =[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"注册是%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误>>%@",error);
    }];
    
    
}
#pragma mark -- 获取手机验证码
+(void)getHuoQuPhoneNumber:(NSString*)phonenum type:(NSString*)ty success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
     NSString * urlStr =[NSString stringWithFormat:@"%@api/Customer/SendCode?phoneNum=%@&type=%@",FUWU,phonenum,ty];
   
    NSLog(@"获取的验证码手机号%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
    
    
}
#pragma mark -- 获取省份GET
+(void)getAllProvincesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"http://api2016.huishoushang.com/api/area/GetProvince"];
    NSLog(@"获取省份是%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"身份是%@",responseObject);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
#pragma mark -- 根据省份获取城市
+(void)getCityCode:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/area/GetCity?code=%@",FUWU,code];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
   NSLog(@"根据省获取市%@",urlStr);
    
//    NSLog(@">>>>>这里头的Code呢？ %@",code);
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"城市是%@",responseObject);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}



#pragma mark -- 前台供求列表
+(void)getQianTai:(NSString*)address MID:(NSString*)mid Page:(NSString*)page Category:(NSString*)cate  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    //api/Info/GQInfoList
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Info/GQInfoList?Address=%@&MID=%@&page=%@&Category=%@&GID=1",FUWU,address,mid,page,cate];
  NSLog(@"供应>>%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         aSuccess(responseObject);
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            }];
   
    
}
#pragma mark -- 前台供求详情
+(void)getQianTaiXiangQingID:(NSString*)messageID Uid:(NSString*)uid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Info/GetGQShow?Id=%@&Uid=%@",FUWU,messageID,uid];
    NSLog(@"前台详情%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        aError(error);
    }];
    
    
}
#pragma mark -- 供求分类
+(void)getGongQiuFenLeiClass:(NSString*)Category success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =nil;
    if (Category) {
        urlStr =[NSString stringWithFormat:@"%@api/GQClass/GetGQClassList?Category=%@",FUWU,Category];
    }
    else{
        urlStr =[NSString stringWithFormat:@"%@api/GQClass/GetGQClassList?",FUWU];
    }
    NSLog(@"供求分类接口%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"供求行业分类%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

    
    
    
    
}
#pragma mark -- 求购列表
+(void)getQiuGou:(NSString*)address MID:(NSString*)mid Page:(NSString*)page Category:(NSString*)cate success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Info/GQInfoList?Address=%@&MID=%@&page=%@&Category=%@&GID=2",FUWU,address,mid,page,cate];
    NSLog(@"求购>>%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    
    
    
}









#pragma mark -- 资产列表
+(void)getZhiChanPage:(NSString*)page Pagesize:(NSString*)pagesize   Category:(NSString*)cate Adds:(NSString*)adds Date:(NSString*)time GuanJianZi:(NSString*)guanjian  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString *  urlStr;    //判断一下有没有关键字，如果有
    if(guanjian){
         NSString * urlstr;
        if (cate && !adds && !time) {
            urlstr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Category=%@&Sword=%@",FUWU,page,pagesize,cate,guanjian];
        }else if (adds && !time && !cate){
            urlstr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Address=%@&Sword=%@",FUWU,page,pagesize,adds,guanjian];
        }else if (time && !adds && !cate){
            urlstr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Date=%@&Sword=%@",FUWU,page,pagesize,time,guanjian];
        }else if(cate && adds && time){
            urlstr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Category=%@&Address=%@&Date=%@&Sword=%@",FUWU,page,pagesize,cate,adds,time,guanjian];
        }else if (cate && adds && !time){
            urlstr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Category=%@&Address=%@&Sword=%@",FUWU,page,pagesize,cate,adds,guanjian];
        }else if (cate && time &&!adds){
            urlstr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Category=%@&Date=%@&Sword=%@",FUWU,page,pagesize,cate,time,guanjian];
        }else if (time && adds && !cate){
            urlstr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Address=%@&Date=%@&Sword=%@",FUWU,page,pagesize,adds,time,guanjian];
        }
        else{
            urlstr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Sword=%@",FUWU,page,pagesize,guanjian];
        }
         urlStr= [urlstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }//没有关键字
    else{
        if (cate && !adds && !time) {
            urlStr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Category=%@",FUWU,page,pagesize,cate];
        }else if (adds && !time && !cate){
            urlStr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Address=%@",FUWU,page,pagesize,adds];
        }else if (time && !adds && !cate){
            urlStr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Date=%@",FUWU,page,pagesize,time];
        }else if(cate && adds && time){
            urlStr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Category=%@&Address=%@&Date=%@",FUWU,page,pagesize,cate,adds,time];
        }else if (cate && adds && !time){
            urlStr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Category=%@&Address=%@",FUWU,page,pagesize,cate,adds];
        }else if (cate && time &&!adds){
            urlStr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Category=%@&Date=%@",FUWU,page,pagesize,cate,time];
        }else if (time && adds && !cate){
            urlStr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@&Address=%@&Date=%@",FUWU,page,pagesize,adds,time];
        }
        else{
            urlStr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsList?page=%@&Pagesize=%@",FUWU,page,pagesize];
        }
        
    }
    
    
    NSLog(@"资产列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    

    
    
}




#pragma mark -- 资产详情
+(void)getZiChanXiangQingID:(NSString*)messageID Uid:(NSString*)uid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Assets/GetAssetsModel?id=%@&Uid=%@",FUWU,messageID,uid];
    NSLog(@"资产详情%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -- 资寻详情
+(void)getZiXunXiangQingMessageID:(NSString*)messageid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/news/GetNewsShow?id=%@",FUWU,messageid];
    NSLog(@"资寻详情%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

#pragma mark -- 资寻新闻(3个选填没有填)
+(void)getZiXunXinWenPage:(NSString*)page Pagesize:(NSString*)pagesize   classID:(NSString*)cid  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/News/GetNearNews?page=%@&pagesize=%@&classid=%@",FUWU,page,pagesize,cid];
    NSLog(@"资寻新闻%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}








#pragma mark -- 拍卖列表
+(void)getPaiMaicid:(NSString*)Cid Pid:(NSString*)pid Time:(NSString*)time Page:(NSString*)page Pagesize:(NSString*)pagesize GuanJian:(NSString*)gjz success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr;
    if (gjz) {
        NSString * str =[NSString stringWithFormat:@"%@api/info/GetSaleList?cid=%@&Address=%@&Time=%@&Page=%@&Pagesize=%@&Keyword=%@",FUWU,Cid,pid,time,page,pagesize,gjz];
         urlStr= [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }else{
      urlStr =[NSString stringWithFormat:@"%@api/info/GetSaleList?cid=%@&Address=%@&Time=%@&Page=%@&Pagesize=%@",FUWU,Cid,pid,time,page,pagesize];
    }
    
    
    NSLog(@"拍卖列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark --拍卖详细信息
+(void)getPaiMaiXiangXiId:(NSString*)idd Uid:(NSString*)uid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/info/GetSaleModel?Id=%@&Uid=%@",FUWU,idd,uid];
    NSLog(@"拍卖详细信息详情%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}






#pragma mark -- 资寻分类
+(void)getZiFenLeisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/news/GetNewsClass",FUWU];
    NSLog(@"资寻分类%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


#pragma mark -- 资寻列表
+(void)getZiXunLieBiaoPage:(NSString*)page Pagesize:(NSString*)pagesize uid:(NSString*)Uid pwd:(NSString*)Pwd Where:(NSString*)where Classid:(NSString*)classid  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/news/GetNewsList?Page=%@&Pagesize=%@&uid=%@&pwd=%@&Where=%@&Classid=%@",FUWU,page,pagesize,Uid,Pwd,where,classid];
  
    NSLog(@"资寻列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark -- 报价列表
+(void)getBaoJiaPage:(NSString*)page pagesize:(NSString*)Pagesize bgclass:(NSString*)Bjclass success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/offer/GetOfferList?page=%@&pagesize=%@&bjclass=%@",FUWU,page,Pagesize,Bjclass];
    
    NSLog(@"报价列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


#pragma mark -- 报价详情
+(void)getBaoJiaXiangQing:(NSString*)messageid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/offer/GetOfferModel?id=%@",FUWU,messageid];
    
    NSLog(@"报价详情%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -- 相关报价
+(void)getXiangGuanBaoJiapage:(NSString*)Page pagesize:(NSString*)Pagesize bjclass:(NSString*)Bjclass success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/offer/GetNearOffer?page=%@&pagesize=%@&bjclass=%@",FUWU,Page,Pagesize,Bjclass];
    
    NSLog(@"相关报价%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
#pragma mark --报价分类
+(void)baoJiaClassCid:(NSString*)cid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/offer/GetOfferClass?Cid=%@",FUWU,cid];
    
    NSLog(@"报价分类%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}


#pragma mark --首页行业信息
+(void)HuoQuFirstHangYeMessageType:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/GQClass/GetIndexHy?type=%@",FUWU,type];
    NSLog(@"首页行业信息%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        aError(error);
    }];
    
}
#pragma mark -- 新增接口首页行业 去掉的信息
+(void)HuoquFirstHangYesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
     NSString * urlStr =[NSString stringWithFormat:@"%@api/GQClass/GetSimpleHy",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        aError(error);
    }];
    
}
#pragma mark --留言功能
+(void)getLiuYanxxid:(NSString*)Xxid contact:(NSString*)Contact handtel:(NSString*)shoujihao content:(NSString*)neirong type:(NSString*)Type uid:(NSString*)Uid ruid:(NSString*)Ruid  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Message/LeaveMessage",FUWU];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    
    [dic setObject:shoujihao forKey:@"handtel"];
    [dic setObject:Contact forKey:@"contact"];
    [dic setObject:neirong forKey:@"content"];
    [dic setObject:Type forKey:@"type"];
    [dic setObject:Uid forKey:@"uid"];
    [dic setObject:Xxid forKey:@"xxid"];
    [dic setObject:Ruid forKey:@"ruid"];
    
     NSLog(@"handtel=%@",shoujihao);
     NSLog(@"contact=%@",Contact);
     NSLog(@"content=%@",neirong);
     NSLog(@"type=%@",Type);
     NSLog(@"uid=%@",Uid);
     NSLog(@"xxid=%@",Xxid);
     NSLog(@"ruid=%@",Ruid);
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData * data =[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"留言结果%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误%@",error);
    }];
    
    
    
}








#pragma mark --首页搜索关键字信息
+(void)HuoQuSearchYeMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/info/GetSoKeyWord",FUWU];
    NSLog(@"首页搜索关键字%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        aError(error);
    }];
    
}
#pragma mark --首页拍的分类
+(void)PaiMessage:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/info/GetSaleClass",FUWU];
  //  NSLog(@"首页拍卖分类%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

#pragma mark --首页拍卖详细信息
+(void)PaiMessageID:(NSString*)idd Uid:(NSString*)uid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/info/GetSaleModel?Id=%@&Uid=%@",FUWU,idd,uid];
      NSLog(@"首页拍卖信息%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark --首页猜你喜欢
+(void)getShouyeCainiLikeCid:(NSString*)cid Pagesize:(NSString*)pagesize Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/info/GuessYouLike?Cid=%@&Pagesize=%@&Page=%@",FUWU,cid,pagesize,page];
    NSLog(@"首页猜你喜欢%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


#pragma mark --根据登录ID去获取会员信息
+(void)getHuiYuanMessageUid:(NSString*)uid  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/login/GetUmodel?Uid=%@",FUWU,uid];
    NSLog(@"登录ID去获取会员信息%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}


#pragma mark --修改会员信息

+(void)xiuGaiMyMessageKey:(NSString*)token SuiJi:(NSString*)suiji Key:(NSString*)key ShengCode:(NSString*)code  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Customer/ModifyUser",FUWU];
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:token forKey:@"Key"];
    [dicc setObject:suiji forKey:key];
    if (code) {
        [dicc setObject:code forKey:@"Us_prov_id"];
    }
    //[dicc setObject:@"110000" forKey:@"Us_prov_id"];
     AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"tx会员信息修改结果%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
#pragma mark --上传图片得到图片地址后，再把地址给服务器
+(void)shangchuanTouXiang:(NSData*)touxiangData Key:(NSString*)token success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
   NSString * urlStr =[NSString stringWithFormat:@"%@api/uploadfile/UpLoadProcess",FUWU];
   
   //获得的data
    NSData *imageData=touxiangData;
    //base编码后
    NSString * endStr =[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:token forKey:@"Key"];
    [dicc setObject:endStr forKey:@"img"];
    //[dicc setObject:@"1" forKey:@"type"];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"上传图片后返回的地址%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
   
    
    
}
#pragma mark --上传图片得到图片地址后，再把地址给服务器
+(void)shangchuanImageArr:(NSMutableArray*)touxiangData Key:(NSString*)token success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/uploadfile/UpLoadProcess",FUWU];
    
    for (int i =0;i< touxiangData.count;i++){
        UIImage * imageurl=touxiangData[i];
        UIImage * newImage =[Engine compressImageWith:imageurl width:imageurl.size.width height:imageurl.size.height];
        CGSize size =CGSizeMake(KUAN, KUAN * newImage.size.height/newImage.size.width);
        NSData *imgData=[Engine imageWithImage:newImage scaledToSize:size];;
        //获得的data
        NSData *imageData=imgData;
        //base编码后
        NSString * endStr =[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        NSMutableDictionary * dicc =[NSMutableDictionary new];
        [dicc setObject:token forKey:@"Key"];
        [dicc setObject:endStr forKey:@"img"];
        //[dicc setObject:@"1" forKey:@"type"];
        AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
        [manager POST:urlStr parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"上传图片后返回的地址%@",str);
            NSString * key =[NSString stringWithFormat:@"key%d",i];
            NSMutableDictionary * dicc =[NSMutableDictionary new];
            [dicc setObject:[responseObject objectForKey:@"Item2"] forKey:key];
            
            aSuccess(dicc);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];

    }
    
    
    
    
    
}
#pragma mark --我的订阅
+(void)getMydingYueMessageToken:(NSString*)token TextFiled:(NSString*)textMessage Address:(NSString*)address MessageLaiyuan:(NSString*)laiyuan  Type:(NSString*)type success:(SuccessBlock)aSuccess  error:(ErrorBlock)aError{
    NSString *urlStr =[NSString stringWithFormat:@"%@api/Customer/InsertSubscription",FUWU];
    NSLog(@"我的订阅%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:token forKey:@"Key"];
    [parameter setObject:textMessage forKey:@"s_condition"];
    [parameter setObject:address forKey:@"S_Provice"];
    [parameter setObject:laiyuan forKey:@"S_Orgin"];
    [parameter setObject:type forKey:@"Type"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"我的订阅%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
#pragma mark --获取订阅信息
+(void)getDingYueXinXiToken:(NSString*)token Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString *urlStr =[NSString stringWithFormat:@"%@api/Customer/GetSubscription?Key=%@&Type=%@",FUWU,token,type];
    NSLog(@"获取订阅信息%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark --查看订阅条件下的信息
+(void)getDingYueTiaoJianToke:(NSString*)token messageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
    NSString *urlStr =[NSString stringWithFormat:@"%@api/Market/SubscriptionList?Key=%@&id=%@",FUWU,token,idd];
    NSLog(@"查看订阅条件下的信息%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        aError(error);
    }];
    
}
#pragma mark --删除订阅条件下的信息
+(void)getDeleteDingyueToken:(NSString*)token messageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString *urlStr =[NSString stringWithFormat:@"%@api/Customer/DeleteSubscription",FUWU];
    NSLog(@"删除订阅%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:token forKey:@"Key"];
    [parameter setObject:idd forKey:@"id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"删除订阅%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}
#pragma mark --发布供求信息
+(void)fabuGongQiuMessageToken:(NSString*)token BiaoTi:(NSString*)biaoti hangye:(NSString*)cid ShengFenCode:(NSString*)code MiaoShu:(NSString*)miaoshu chengse:(NSString*)chense Price:(NSString*)jiage Kucun:(NSString*)kucun YouxiaoQi:(NSString*)youxiaoq xingHao:(NSString*)xinghao Type:(NSString*)type picArr:(NSMutableArray*)imageArr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Info/FabuGQinfo",FUWU];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:token forKey:@"Key"];
    [parameter setObject:type forKey:@"gqtype"];//1供应2求购
    [parameter setObject:biaoti forKey:@"gq_title"];
    [parameter setObject:miaoshu forKey:@"gq_content"];
    
    [parameter setObject:jiage forKey:@"gq_pro_price"];
    [parameter setObject:kucun forKey:@"gq_pro_count"];
    
    [parameter setObject:chense forKey:@"gq_color"];
    [parameter setObject:xinghao forKey:@"gq_pro_size"];
    
    [parameter setObject:cid forKey:@"cid"];
    [parameter setObject:code forKey:@"gq_prov_id"];
    if (imageArr==nil || imageArr.count==0) {
        [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"供应求购发布结果%@",str);
            
            aSuccess(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }else
    {
        for(int i =0 ;i<imageArr.count;i++)
        {
            NSString * urlStr=imageArr[i];
            NSString * keyy =[NSString stringWithFormat:@"gq_pic%d",i];
            NSLog(@"看看参数名字%@",keyy);
            NSLog(@"看看图片的地址%@",urlStr);
           [parameter setObject:urlStr forKey:keyy];
        }
        NSLog(@"kank>>%lu",parameter.count);
        [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"供应求购带图片发布结果%@",str);
            
            aSuccess(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
    
    
    
    
    
    
    
}
#pragma mark --发布资产信息
+(void)fabuZiChaMessageToken:(NSString*)token BiaoTi:(NSString*)biaoti MiaoShu:(NSString*)miaoshu Price:(NSString*)jiage KuCun:(NSString*)kucun YouXiaoQi:(NSString*)youciaoq HangYeId:(NSString*)cid MyWeiZhi:(NSString*)weizhiCode imgaeArr:(NSMutableArray*)imageStr  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Assets/AddAssets",FUWU];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
     [parameter setObject:token forKey:@"Key"];
     [parameter setObject:biaoti forKey:@"Title"];
     [parameter setObject:miaoshu forKey:@"Content"];
     [parameter setObject:jiage forKey:@"Price"];
     [parameter setObject:kucun forKey:@"Count"];
     [parameter setObject:youciaoq forKey:@"Date"];//int 类型
     [parameter setObject:cid forKey:@"CidA"];
     [parameter setObject:weizhiCode forKey:@"Province"];
   
    if (imageStr==nil || imageStr.count==0) {
        [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"资产发布结果%@",str);
            
            aSuccess(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }]; 
    }else
    {
        for(int i =0 ;i<imageStr.count;i++)
        {
            NSString * urlStr=imageStr[i];
            NSString * keyy =[NSString stringWithFormat:@"Pics%d",i];
            NSLog(@"看看资产参数名字%@",keyy);
            NSLog(@"看看资产图片的地址%@",urlStr);
            [parameter setObject:urlStr forKey:keyy];
        }
    
        [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"资产带图片发布结果%@",str);
            
            aSuccess(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }
    
    
    
   
    
}


#pragma mark --发布拍卖
+(void)fabuPaiMaiToken:(NSString*)token BiaoTi:(NSString*)biaoti MiaoShu:(NSString*)miaoshu LianXiRen:(NSString*)lianxiren LianXiDianHua:(NSString*)dianhua BaoZhengjin:(NSString*)baozhengjin StarDate:(NSString*)stardate EndDate:(NSString*)endstar Address:(NSString*)dizhi ClassBie:(NSString*)leibie DiQu:(NSString*)diqu Commper:(NSString*)gongsi success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/info/AddSale",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
     [parameter setObject:token forKey:@"Key"];
     [parameter setObject:biaoti forKey:@"Title"];
     [parameter setObject:miaoshu forKey:@"content"];
     [parameter setObject:lianxiren forKey:@"linkman"];
     [parameter setObject:dianhua forKey:@"phone"];
     [parameter setObject:baozhengjin forKey:@"deposit"];
     [parameter setObject:stardate forKey:@"begindate"];
     [parameter setObject:endstar forKey:@"enddate"];
     [parameter setObject:dizhi forKey:@"Adds"];
     [parameter setObject:leibie forKey:@"Cid"];
     [parameter setObject:diqu forKey:@"province"];
     [parameter setObject:gongsi forKey:@"company"];
    
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"拍卖发布结果%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"拍卖错误输出%@",error);
    }];
    
    
    
}

#pragma mark -- 删除供求信息
+(void)deleteGongQiu:(NSString*)token MessageId:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Info/DeleteGqinfo",FUWU];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:token forKey:@"Key"];
    [parameter setObject:type forKey:@"Id"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"删除供求信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
#pragma mark --删除资产
+(void)deleteZiChanFabuKey:(NSString*)key MessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/assets/DelMessage",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:key forKey:@"Key"];
    [parameter setObject:idd forKey:@"id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"删除资产%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"删除资产错误输出%@",error);
    }];

}



#pragma mark --删除拍卖
+(void)deletePaiMaiFabuKey:(NSString*)key MessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/info/DelMessage",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:key forKey:@"Key"];
    [parameter setObject:idd forKey:@"id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"删除拍卖%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"删除拍卖错误输出%@",error);
    }];
    
    
    
}

#pragma mark -- 修改供求信息状态(上线还是下线)
+(void)xiuGaiShangXianXiaXianKey:(NSString*)key MessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Info/ChangeStateGQinfo",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:key forKey:@"Key"];
    [parameter setObject:idd forKey:@"id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"上线还是下线%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上线还是下线错误输出%@",error);
    }];
    
    
    
}

#pragma mark -- 刷新供求
+(void)shuaXinReashGongQiuKey:(NSString*)key MessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Info/RefreshGQinfo",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:key forKey:@"Key"];
    [parameter setObject:idd forKey:@"id"];
    
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"刷新供求%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"刷新供求错误输出%@",error);
    }];
    
    
}


#pragma mark -- 修改供求
+(void)xiuGaiGongYingKey:(NSString*)key XinXiID:(NSString*)messageID BiaoTi:(NSString*)biaoti GQName:(NSString*)name Cid:(NSString*)cid GQProvid:(NSString*)shengCode Content:(NSString*)content picArr:(NSMutableArray*)imageArr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Info/ModifyGQinfo",FUWU];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:key forKey:@"Key"];
    [parameter setObject:messageID forKey:@"Id"];
    [parameter setObject:biaoti forKey:@"gq_title"];
    [parameter setObject:name forKey:@"gq_pro_name"];
    [parameter setObject:cid forKey:@"cid"];
    [parameter setObject:shengCode forKey:@"gq_prov_id"];
    [parameter setObject:content forKey:@"gq_content"];
    
    
    if (imageArr==nil || imageArr.count==0) {
        [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"修改供求信息%@",str);
            
            aSuccess(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"修改供求信息%@",error);
        }];

    }
    
    else
    {
        for(int i =0 ;i<imageArr.count;i++)
        {
            NSString * urlStr=imageArr[i];
            NSString * keyy =[NSString stringWithFormat:@"gq_pic%d",i];
            NSLog(@"修改供求信息%@",keyy);
            NSLog(@"修改供求信息地址%@",urlStr);
            [parameter setObject:urlStr forKey:keyy];
        }
        NSLog(@"kank>>%lu",parameter.count);
        [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"修改供求信息图片发布结果%@",str);
            
            aSuccess(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
    
    
    
}
#pragma mark -- 修改资产
+(void)xiuGaiZiChanKey:(NSString*)key XinXiID:(NSString*)messageID BiaoTi:(NSString*)biaoti  Cid:(NSString*)cid GQProvid:(NSString*)shengCode Content:(NSString*)content YouXiaoQi:(NSString*)youxiaqi Price:(NSString*)price ShuLiang:(NSString*)shuliang imgaeArr:(NSMutableArray*)imageArr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Assets/EditAssets",FUWU];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:key forKey:@"Key"];
    [parameter setObject:messageID forKey:@"Id"];
    [parameter setObject:biaoti forKey:@"Title"];
    [parameter setObject:cid forKey:@"CidA"];
    [parameter setObject:shengCode forKey:@"Province"];
    [parameter setObject:content forKey:@"Content"];
    
    [parameter setObject:youxiaqi forKey:@"Date"];
    [parameter setObject:price forKey:@"Price"];
    [parameter setObject:shuliang forKey:@"Count"];

    if (imageArr==nil || imageArr.count==0) {
        [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"修改资产信息%@",str);
            
            aSuccess(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"修改资产信息%@",error);
        }];
    }
    else
    {
        for(int i =0 ;i<imageArr.count;i++)
        {
            NSString * urlStr=imageArr[i];
            NSString * keyy =[NSString stringWithFormat:@"gq_pic%d",i];
            NSLog(@"修改资产信息信息%@",keyy);
            NSLog(@"修改资产信息地址%@",urlStr);
            [parameter setObject:urlStr forKey:keyy];
        }
        NSLog(@"kank>>%lu",parameter.count);
        [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"修改资产信息发布结果%@",str);
            
            aSuccess(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }

    
    
    
    
}
#pragma mark -- 修改拍卖
+(void)xiuGaiPaiMaiKey:(NSString*)key XinXiID:(NSString*)messageID BiaoTi:(NSString*)biaoti  Cid:(NSString*)cid GQProvid:(NSString*)shengCode Content:(NSString*)content StarTime:(NSString*)time1 EndTime:(NSString*)endtime ComperName:(NSString*)gongSiName People:(NSString*)lianxiren Address:(NSString*)dizhi PhoneNumber:(NSString*)shoujiHao success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/info/EditSale",FUWU];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:key forKey:@"Key"];
    [parameter setObject:messageID forKey:@"Id"];
    [parameter setObject:biaoti forKey:@"Title"];
    [parameter setObject:cid forKey:@"Cid"];
    [parameter setObject:shengCode forKey:@"Province"];
    [parameter setObject:content forKey:@"Content"];
    
    [parameter setObject:time1 forKey:@"begindate"];
    [parameter setObject:endtime forKey:@"enddate"];
    [parameter setObject:gongSiName forKey:@"company"];
    [parameter setObject:lianxiren forKey:@"linkman"];
    [parameter setObject:dizhi forKey:@"adds"];
    [parameter setObject:shoujiHao forKey:@"Phone"];
    
    
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"修改拍卖信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"修改拍卖信息%@",error);
    }];
    
    

    
    
    
    
    
    
    
    
}

#pragma mark --拍卖行业
+(void)getPaiMaiHangYesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
      NSString * urlStr =[NSString stringWithFormat:@"%@api/info/GetSaleClass",FUWU];
    NSLog(@"拍卖分类url%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject); 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark --获取附近商机(对应的周边商机)
+(void)getFuJinShangJiCityCode:(NSString*)code Page:(NSString*)page  Type:(NSString*)type  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
     NSString *urlStr =[NSString stringWithFormat:@"%@api/market/GetNearBusiness?City=%@&Page=%@&Type=%@",FUWU,code,page,type];
    NSLog(@"附近商机%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
#pragma mark -- 获取附近商户(发现当中的身边店铺)
+(void)getShenBianDianPuCityCode:(NSString*)cityCode success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString *urlStr =[NSString stringWithFormat:@"%@/api/login/GetNearUser?City=%@",FUWU,cityCode];
    NSLog(@"附近身边店铺商户%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark --锁定信息
+(void)getSuoDingMessageKey:(NSString*)token messageID:(NSString*)idd Infoclass:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/info/LockInfo",FUWU];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:token forKey:@"Key"];
    [dic setObject:idd forKey:@"id"];
    [dic setObject:type forKey:@"Infoclass"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        //        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@",str);
        
        NSData * data =[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString * str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"锁定信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark --解锁信息
+(void)getJieSuoMessageKey:(NSString*)token messageID:(NSString*)idd Infoclass:(NSString*)classinfo success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/info/UnLockInfo",FUWU];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:token forKey:@"Key"];
    [dic setObject:idd forKey:@"id"];
    [dic setObject:classinfo forKey:@"Infoclass"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"%@",str);
        
        NSData * data =[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString * str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"解锁信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}

#pragma mark -- 获取锁定信息列表
+(void)getSuoDiangMessageToken:(NSString*)token success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    NSString * urlStr =[NSString stringWithFormat:@"%@/api/info/GetLockList?Key=%@",FUWU,token];
    NSLog(@"获取锁定信息列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
#pragma mark -- 获取锁定信息展示页面
+(void)getSuoDingXiangQingYeMianKey:(NSString*)token MessageID:(NSString*)idd Infoclass:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
     NSString * urlStr =[NSString stringWithFormat:@"%@api/info/GetLockShow?Key=%@&Id=%@&Infoclass=%@",FUWU,token,idd,type];
     NSLog(@"获取锁定信息展示页面%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -- 会员中心供求列表（我的发布供应）
+(void)getMyPublicGongQiuZhongXinKey:(NSString*)token Type:(NSString*)type Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Info/GetUserGQList?Key=%@&type=%@&Page=%@",FUWU,token,type,page];
    NSLog(@"会员中心供求列表（我的发布供应）%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
         aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark -- 会员中心获取资产信息（我的发布资产）
+(void)getMyPublicZiChanZhongXinKey:(NSString*)token Type:(NSString*)type Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Assets/GetUserAssetsList?Key=%@&state=%@&Page=%@",FUWU,token,type,page];
    NSLog(@"我的发布资产%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];
    
}

#pragma mark -- 用户中心获取拍卖信息（我的拍卖）
+(void)getMyPublicPaiMaiKey:(NSString*)token Type:(NSString*)type Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/info/GetUserSaleView?Key=%@&state=%@&page=%@",FUWU,token,type,page];
    NSLog(@"我的发布资产%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];

}
#pragma mark -- 会员中心展示界面（我的发布）
+(void)getMyPublicPaiMaiKey:(NSString*)token MessageId:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Info/GetUserGQShow?Key=%@&Id=%@",FUWU,token,type];
    NSLog(@"会员中心展示界面%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];
    
}
#pragma mark -- 会员中心展示界面（我的发布获取资产信息）
+(void)getMyPublicZiChanMessageKey:(NSString*)token MessageId:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Assets/GetUserAssetsModel?Key=%@&Id=%@",FUWU,token,type];
    NSLog(@"我的发布获取资产信息%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];
    
}

#pragma mark -- 会员中心展示界面（我的发布拍卖信息）
+(void)getMyPublicPaiMaiMessageKey:(NSString*)token MessageId:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/info/GetUserSaleModel?Key=%@&Id=%@",FUWU,token,type];
    NSLog(@"我的发布拍卖信息%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];
}

#pragma mark --前台搜索列表
+(void)geQianTaiSearchLieBiaoSWord:(NSString*)sword GID:(NSString*)gid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Info/SoGQinfoList?SWord=%@&GID=%@",FUWU,sword,gid];
   // NSLog(@"前台搜索列表%@",urlStr);
    //编码处理
   NSString *str1 = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:str1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
//         NSData * data =[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//         NSString * str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//         NSLog(@"前台搜索列表%@",str);
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
         
         aError(error);
     }];
    
}
#pragma mark --前台搜索列表详细(同一个接口)
+(void)geQianTaiSearchLieBiaoSWord:(NSString*)sword  Address:(NSString*)address VipJibie:(NSString*)vip Page:(NSString*)page GID:(NSString*)gid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Info/SoGQinfoList?SWord=%@&GID=%@&Address=%@&Page=%@&MID=%@",FUWU,sword,gid,address,page,vip];
    // NSLog(@"前台搜索列表%@",urlStr);
    //编码处理
    NSString *str1 = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:str1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //         NSData * data =[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
         //         NSString * str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
         //         NSLog(@"前台搜索列表%@",str);
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
         
         aError(error);
     }];
    
}


#pragma mark --用户留言列表
+(void)getYongHuLiuYanLieBiaoKey:(NSString*)token Page:(NSString*)page Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Message/GetMessagelist?Key=%@&Page=%@&Type=%@",FUWU,token,page,type];
    NSLog(@"用户留言列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];
    
    
}
#pragma mark -- 获取留言提醒对话
+(void)getLiuYanDuiHuaKey:(NSString*)key Ruid:(NSString*)ruid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/message/getMessage?key=%@&ruid=%@",FUWU,key,ruid];
    NSLog(@"获取留言提醒对话%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"获取留言提醒对话%@",error);
     }];

    
    
}
#pragma mark -- 获取会员权限
+(void)getVipQuanXianKey:(NSString*)token success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/other/GetUserPower?key=%@",FUWU,token];
    NSLog(@"获取会员权限%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"获取会员权限%@",error);
     }];
}
#pragma mark -- 升级特权页面
+(void)shengJiTeQuanYeMiansuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/other/GetVipclass",FUWU];
    NSLog(@"升级特权页面%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"升级特权页面%@",error);
     }];
    
}

#pragma mark -- 海量商机,暴力宣传，私人秘书
+(void)haiLiangShangJiVipClass:(NSString*)vipclass Key:(NSString*)key  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/other/%@?vipclass=%@",FUWU,key,vipclass];//GetHugebusiness%@
    NSLog(@"海量商机%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"海量商机%@",error);
     }];
}

#pragma mark -- 支付方式
+(void)zhiFuPaysuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/other/GetPayWay",FUWU];//GetHugebusiness%@
    NSLog(@"支付方式%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"支付方式%@",error);
     }];
}
#pragma mark --手机修改密码
+(void)XiuGaiMiMaPhoneNumber:(NSString*)number Password:(NSString*)mima PhoneCode:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Login/FindPWD",FUWU];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:number forKey:@"handtel"];
    [parameter setObject:mima forKey:@"password"];
    [parameter setObject:code forKey:@"code"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"修改密码结果%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}
#pragma mark --Lable宽度自适应
+ (CGFloat)getWidthWithFontSize:(CGFloat)size height:(CGFloat)height string:(NSString *)string{
    
    if (![string isKindOfClass:[NSString class]]) {
        return 0;
    }
    //    NSDictionary *dict = @{NSFontAttributeName : [UIFont fontWithName:@"FZLTXHK--GBK1-0" size:size]};
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:size]};
    
    CGSize textSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dict context:nil].size;
    return textSize.width;
}
#pragma mark --将时间戳按指定格式时间输出,spString为毫秒
+ (NSString*)nsdateToTime:(NSString*)string
{
    NSString * ss ;
    if (string==nil || string.length==0 || [string isEqualToString:@""]) {
          ss = @"";
    }else{
         ss = [string substringToIndex:10];
    }
    
   // NSString*string =@"sdfsfsfsAdfsdf";
    //截取下标7之前的字符串
   // NSLog(@"截取的值为：%@",string);
 // NSString * ss=  [string substringFromIndex:11];//截取下标2之后的字符串
    //NSLog(@"截取的值为：%@",string);
    
    return ss;
}
#pragma mark -- 拨打电话
+(void)tellPhone:(NSString*)tell{
    //联系我们
    NSString *allString = [NSString stringWithFormat:@"tel:%@",tell];
    NSString*telUrl =[allString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];
}


#pragma mark --图片压缩问题
+(UIImage *)compressImageWith:(UIImage *)image width:(float)width height:(float)height
{
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //[newImage retain];
    [newImage copy];
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -- 图片上传前的压缩
+(NSData *)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 1);
}
#pragma mark -- 获取会员级别
+(void)getVIPjiBiesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Dictionary/GetUserVipClass",FUWU];//GetHugebusiness%@
    NSLog(@"获取会员级别%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"获取会员级别%@",error);
     }];
    
}

#pragma mark --更新缓存
+(void)GengXinHuanCunsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/other/GetGQClassFlagTime",FUWU];//GetHugebusiness%@
  //  NSLog(@"更新缓存%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSLog(@"更新缓存%@",error);
     }];
}
#pragma mark -- 是否更新缓存
+(BOOL)isUpdate:(NSString*)time{
    //后台的时间
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
     NSDate* time1 = [formatter dateFromString:time];
   //现在的时间格式化后的
    NSString * dateStr = [formatter stringFromDate:[NSDate date]];
    NSDate * nowDate = [formatter dateFromString:dateStr];
    //时间差//NSOrderedAscending NSOrderedDescending
    if ([nowDate compare:time1]==NSOrderedAscending) {
        //现在的时间小于后台的时间为更新缓存
        //NSLog(@"更新缓存%@",time1);
        return YES;
    }else{
      //  NSLog(@"不更新%@",nowDate);
       return NO;
    }
}
+(NSMutableDictionary*)plistDuqu22{
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"message.plist"];
    NSMutableDictionary *writeData=[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    // NSLog(@"write data is :%@",writeData);
    
    return writeData;
    
}
#pragma mark --0 1
+(void)kankanissuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/login/forapple",FUWU];
    NSLog(@"网址是%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         aSuccess(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];
}
+(NSMutableArray*)plistDuquVipName{
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"vipName.plist"];
    NSMutableArray * array=[[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    return array;
    
}

#pragma mark --登录状态
+(void)loginStye:(NSString*)toke success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@api/Login/RefreshLogTime?token=%@",FUWU,toke];
    NSLog(@"登录状态%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
@end
