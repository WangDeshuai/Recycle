//
//  vipIDModel.h
//  Recycle
//
//  Created by Macx on 16/6/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface vipIDModel : NSObject
@property(nonatomic,copy)NSString * titleName;
@property(nonatomic,copy)NSString * diquName;
@property(nonatomic,copy)NSString * zhuyingYewu;
@property(nonatomic,copy)NSString * headUrl;
@property(nonatomic,copy)NSString * commperName;
@property(nonatomic,copy)NSString * vipName;
-(id)initWithDic:(NSDictionary*)dic;
@end
