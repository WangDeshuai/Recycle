//
//  DingYueModel.h
//  Recycle
//
//  Created by Macx on 16/6/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DingYueModel : NSObject
//我的订阅
@property (nonatomic,copy)NSString*sTypename;
@property(nonatomic,copy)NSString*sid;
@property(nonatomic,copy)NSString * titleName;
@property(nonatomic,copy)NSString* diqu;
@property(nonatomic,copy)NSString * laiyuan;


-(id)initWithTitleDic:(NSDictionary*)dic;
@end
