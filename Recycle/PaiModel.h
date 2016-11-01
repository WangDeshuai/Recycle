//
//  PaiModel.h
//  Recycle
//
//  Created by Macx on 16/5/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaiModel : NSObject
@property(nonatomic,copy)NSString * titleName;
@property(nonatomic,copy)NSString * diqu;
@property(nonatomic,copy)NSString * publicTime;

@property(nonatomic,copy)NSString * baomingTime;
@property(nonatomic,copy)NSString * baozhengPrice;
@property(nonatomic,copy)NSString * commName;
@property(nonatomic,copy)NSString * fuzePeople;
@property(nonatomic,copy)NSString * callNumber;
@property(nonatomic,copy)NSString * phoneNumber;
@property(nonatomic,copy)NSString * chuanZhen;
@property(nonatomic,copy)NSString * email;

@property(nonatomic,copy)NSString * content;


-(id)initWithDic:(NSDictionary*)dic;
@end
