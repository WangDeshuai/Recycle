//
//  FirstModel.h
//  Recycle
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstModel : NSObject
//首页热门行业 * 综合
@property(nonatomic,copy)NSString*Onename;
//@property(nonatomic,copy)NSString*Twoname;
@property(nonatomic,copy)NSString*Cid;
@property(nonatomic,retain)NSMutableArray * chirdArr;
@property(nonatomic,copy)NSString * pinYin;
-(id)initWithDic:(NSDictionary*)dic;

//首页猜你喜欢
@property(nonatomic,copy)NSString* picUrl;
@property(nonatomic,copy)NSString* titleLabel;
@property(nonatomic,copy)NSString*messageID;
-(id)initWithLike:(NSDictionary*)dic;

@end
