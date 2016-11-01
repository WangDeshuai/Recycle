//
//  ShenBianDianPuModel.h
//  Recycle
//
//  Created by Macx on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShenBianDianPuModel : NSObject
@property(nonatomic,copy)NSString * titleName;
@property(nonatomic,copy)NSString *zhuYingName;
@property(nonatomic,copy)NSString * yongHuID;
-(id)initWithShenBianDic:(NSDictionary*)dic;
@end
