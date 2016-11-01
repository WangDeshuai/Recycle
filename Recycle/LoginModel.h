//
//  LoginModel.h
//  Recycle
//
//  Created by Macx on 16/6/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

/*因为根据ID获取的信息与登录获取的信息一样，用同一个Model得了*/
//根据ID获取个人信息
@property(nonatomic,copy)NSString * picUrl;
@property(nonatomic,copy)NSString * userName;
@property(nonatomic,copy)NSString * companyName;
@property(nonatomic,copy)NSString * diqu;
@property(nonatomic,copy)NSString * phoneNumber;
@property(nonatomic,copy)NSString * email;
@property(nonatomic,copy)NSString * zhuyingYeWu;
@property(nonatomic,copy)NSString * vipClass;
//登录的时候获取的
@property(nonatomic,copy)NSString * endTime;
@property(nonatomic,copy)NSString * messageID;//自己信息ID




-(id)initWithDic:(NSDictionary*)dic;


+(BOOL)isLogin;
@end
