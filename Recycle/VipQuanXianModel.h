//
//  VipQuanXianModel.h
//  Recycle
//
//  Created by Macx on 16/7/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VipQuanXianModel : NSObject
@property(nonatomic,copy)NSString * opration;//操作权限
@property(nonatomic,copy)NSString * total;//总条数
@property(nonatomic,copy)NSString * leave;//剩余调数列
-(id)initWithVipDic:(NSDictionary*)dic;

//升级特权
@property(nonatomic,copy)NSString * sixpic;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString*vipClass;
@property(nonatomic,copy)NSString * Money;
@property(nonatomic,copy)NSString * year;
-(id)initWithShengJiTeQuanDic:(NSDictionary*)dic;


//海量商机,暴力宣传，私人秘书
@property(nonatomic,copy)NSString * titleName;
@property(nonatomic,copy)NSString * valueName;
-(id)initWithHaiLiangShangJiDic:(NSDictionary*)dic;


//支付方式
@property(nonatomic,copy)NSString * bankimg;
@property(nonatomic,copy)NSString * bankname;
@property(nonatomic,copy)NSString * kahao;
@property(nonatomic,copy)NSString * yinHangAddress;
-(id)initWithZhiFuPayDic:(NSDictionary*)dic;
@end
