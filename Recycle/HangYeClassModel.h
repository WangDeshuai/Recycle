//
//  HangYeClassModel.h
//  Recycle
//
//  Created by Macx on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HangYeClassModel : NSObject
@property (nonatomic,copy)NSString * titleName;
@property (nonatomic,copy)NSString * cid;
//@property(nonatomic,retain)NSArray* listArr;
@property(nonatomic,copy)NSString * pinYin;
//资产，供应，求购
-(id)initWithOneDic:(NSDictionary*)dic;
//二级分类的
-(id)initWithTwoDic:(NSDictionary*)dic;
//三级分类
//拍卖
-(id)initWithPaiMaiDic:(NSDictionary*)dic;

@end
