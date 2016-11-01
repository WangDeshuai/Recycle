//
//  GongQiuXiangXiModel.h
//  Recycle
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GongQiuXiangXiModel : NSObject


@property(nonatomic,copy)NSString*titleName;
@property(nonatomic,copy)NSString*diQu;
@property(nonatomic,copy)NSString*price;
@property(nonatomic,copy)NSString*publicTime;

@property(nonatomic,copy)NSString*shuLiang;
@property(nonatomic,copy)NSString*guiGe;


@property(nonatomic,copy)NSString*chanpincontent;

@property(nonatomic,copy)NSString*username;
@property(nonatomic,copy)NSString*vipname;
@property(nonatomic,copy)NSString*usercontent;
//2xiangxiData
@property(nonatomic,copy)NSString * youHuID;
@property(nonatomic,copy)NSString * companyName;
//电话
@property(nonatomic,copy)NSString * handtel;
@property(nonatomic,copy)NSString * tell;
/*注意啊我是解析图片的解析图片的是Item5和他们不一样啊*/
@property(nonatomic,copy)NSString*picadd;
@property(nonatomic,copy)NSString * piccc;
//那个锁子是否显示
@property(nonatomic,copy)NSString * suozi;


-(id)initWithPicDic:(NSDictionary*)dic;

//供应（求购）详情
-(id)initWithDic:(NSDictionary*)dic;
//资产详情
-(id)initWithZiChanXQ:(NSDictionary*)dic;
@end
