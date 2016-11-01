//
//  BaoJiaModel.h
//  Recycle
//
//  Created by Macx on 16/5/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaoJiaModel : NSObject
//报价列表
@property(nonatomic,copy)NSString * messageID;
@property(nonatomic,copy)NSString * titleName;
@property(nonatomic,copy)NSString * publicTime;
-(id)initWithBaoJia:(NSDictionary*)dic;

//报价详情
@property(nonatomic,copy)NSString * btitleName;
@property(nonatomic,copy)NSString * bpublicTime;
@property(nonatomic,copy)NSString * bContent;
@property(nonatomic,copy)NSString * messageLaiYuan;
-(id)initWithBaoJiaXiangQing:(NSDictionary*)dic;

//获取相关报价
@property(nonatomic,copy)NSString * xtitleName;
@property(nonatomic,copy)NSString * xtcName;
-(id)initWithXiangGuanBaoJia:(NSDictionary*)dic;

//报价分类
@property(nonatomic,copy)NSString*btnName;
@property(nonatomic,copy)NSString * messageCid;
-(id)initWithBaoJiaClass:(NSDictionary*)dic;
@end




