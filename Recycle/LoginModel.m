//
//  LoginModel.m
//  Recycle
//
//  Created by Macx on 16/6/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
-(id)initWithDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * url=[self string:[dic objectForKey:@"us_face"]];
        _picUrl=url;
        
        NSLog(@">>>>> 网络获取的图片%@",_picUrl);
        _userName=[self string:[dic objectForKey:@"us_contact"]];
        _companyName=[self string:[dic objectForKey:@"us_company"]];
        NSString * sheng =[self string:[dic
                                        objectForKey:@"us_prov_name"]];
        
        _erweima=[dic objectForKey:@"us_webhss"];
           
        
      
        NSString * shi =[self string:[dic objectForKey:@"us_city_name"]];
        _diqu=[NSString stringWithFormat:@"%@-%@",sheng,shi];
        _phoneNumber=[self string:[dic objectForKey:@"us_handtel"]];
        _email=[self string:[dic objectForKey:@"us_email"]];
        _zhuyingYeWu=[self string:[dic objectForKey:@"us_area"]];//现在找不到参数
       // _vipClass=[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"us_vipclass"]]];
         NSMutableArray * array =[Engine plistDuquVipName];
        if (array) {
            _vipClass=[self vipClassName:[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"us_vipclass"]]]];
        }else{
            _vipClass=@"";
        }
       
       //登录的
        _messageID=[self string:[dic objectForKey:@"us_id"]];
        _endTime=[self string:[dic objectForKey:@"us_enddate"]];
        [[NSUserDefaults standardUserDefaults] setObject:_endTime forKey:@"endtime"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    return self;
}

-(NSString *)vipClassName:(NSString*)class{
    NSMutableArray * array =[Engine plistDuquVipName];
    NSString * vipName;
    for (NSDictionary * dic in array) {
        NSString * key =[NSString stringWithFormat:@"%@",[self string:[dic objectForKey:@"key"]]];//  ;
        if ([key isEqualToString:class]) {
            vipName=[dic objectForKey:@"name"];
        }
    }
    return vipName;
}


+(BOOL)isLogin{
    [self getVipNameData];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
//    NSString *nigei = [defaults objectForKey:@"endtime"];
//    NSLog(@"nigei>>>>%@",nigei);
////返回的时间转化类型
//    NSDateFormatter *formmater = [[NSDateFormatter alloc]init];
//    [formmater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSDate* data = [formmater dateFromString:nigei];
////系统的时间
//    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
// //判断登录是否到期 [NSDate date]=nowData
//    if (token==nil || [[NSDate date] compare:data]==NSOrderedDescending) {
//        return NO;
//    }
//
    
    if (token==nil) {
        return NO;
    }else{
        [Engine loginStye:token success:^(NSDictionary *dic) {
            
            NSString * item =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
             NSLog(@"输出啊啊啊啊啊啊%@",item);
            [[NSUserDefaults standardUserDefaults]setObject:item forKey:@"item1"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        } error:^(NSError *error) {
            
        }];
       NSString * item = [defaults objectForKey:@"item1"];
        if ([item isEqualToString:@"0"]) {
            //清楚uid（短信验证时候的uid）
//            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"uid"];
//            
//            //清除Token和日期
//            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"token"];
//            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"endtime"];
//            //清除登录的messageID
//            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"messageid"];
//            
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            //清楚plist文件
//            //获取路径对象
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//            //获取完整路径
//            NSString *documentsDirectory = [paths objectAtIndex:0];
//            NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"message.plist"];
//            DeleteSingleFile(plistPath);

            
            return NO;
        }
    }
    
   
    
    
   
    return YES;
}
//BOOL DeleteSingleFile(NSString *filePath){
//    NSError *err = nil;
//    
//    if (nil == filePath) {
//        return NO;
//    }
//    
//    NSFileManager *appFileManager = [NSFileManager defaultManager];
//    
//    if (![appFileManager fileExistsAtPath:filePath]) {
//        return YES;
//    }
//    
//    if (![appFileManager isDeletableFileAtPath:filePath]) {
//        return NO;
//    }
//    
//    return [appFileManager removeItemAtPath:filePath error:&err];
//}
//

//获取会员级别
+(void)getVipNameData{
    [Engine getVIPjiBiesuccess:^(NSDictionary *dic) {
        NSMutableArray * arr =[dic objectForKey:@"Item3"];
        NSMutableArray * array =[Engine plistDuquVipName];
        if (arr.count==0 || arr==nil || array!=nil || array.count!=0) {
            NSLog(@"我看看个数>>>%lu",array.count);
            
            return ;
        }else{
            [self saveMessagePlist:[dic objectForKey:@"Item3"]];
        }
        
        
        
    } error:^(NSError *error) {
        
    }];
}
//把个人信息存储到本地plist
+(void)saveMessagePlist:(NSMutableArray*)arr{
    NSLog(@"第几次调用");
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"vipName.plist"];
    //NSLog(@"输出路径%@",plistPath);
    [arr writeToFile:plistPath atomically:YES];
    //    //读取输出
    //    //  NSMutableDictionary *writeData=[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    //    //NSLog(@"write data is :%@",writeData);
    
    
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
