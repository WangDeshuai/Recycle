//
//  GongQiuModel.h
//  Recycle
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
//列表页面
@interface GongQiuModel : NSObject
@property(nonatomic,copy)NSString*titleName;
@property(nonatomic,copy)NSString*price;
@property(nonatomic,copy)NSString*vip;
@property(nonatomic,copy)NSString*diqu;
@property(nonatomic,copy)NSString*time;
@property(nonatomic,copy)NSString*imageUrl;
@property(nonatomic,copy)NSString * shuliangLab;
@property(nonatomic,copy)NSString * guigeLab;
@property(nonatomic,copy)NSString * jianjieLab;
@property(nonatomic,copy)NSString * vipname;
@property(nonatomic,copy)NSString * username;
@property(nonatomic,copy)NSString * messageID;
@property(nonatomic,copy)NSString * comanyName;
@property(nonatomic,copy)NSString * hangYe;
@property(nonatomic,copy)NSString * typeName;
@property(nonatomic,copy)NSString * uidd;
//数组图片
@property(nonatomic,retain)NSMutableArray * imageArr;

//拍卖中新添加的
@property(nonatomic,copy)NSString * phoneNumber;
@property(nonatomic,copy)NSString * starDate;
@property(nonatomic,copy)NSString * endDate;
@property(nonatomic,copy)NSString * address;


//供应
-(id)initWithDic:(NSDictionary*)dic;
//资产
-(id)initWithZiChan:(NSDictionary*)dic;
//拍卖
-(id)initWithPaiMai:(NSDictionary*)dic;

@end
