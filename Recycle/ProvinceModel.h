//
//  ProvinceModel.h
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject
@property(nonatomic,copy)NSString*pName;
@property(nonatomic,copy)NSString*pCode;
@property(nonatomic,copy)NSString*pSname;
@property(nonatomic,copy)NSString*pPinyin;
@property(nonatomic,copy)NSString* pID;
//省
- (id)initWithDic:(NSDictionary *)dic;


//市
//@property(nonatomic,copy)NSString*cName;
- (id)initWithCitydic:(NSDictionary *)Citydic;
@end
