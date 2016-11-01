//
//  ZiXunFenLeiModel.h
//  Recycle
//
//  Created by Macx on 16/5/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZiXunFenLeiModel : NSObject
//资讯分类，头顶滚动视图的数据
@property(nonatomic,copy)NSString*titleName;
@property(nonatomic,copy)NSString*classID;
@property(nonatomic,copy)NSString*nbcID;
-(id)initWithDic:(NSDictionary*)dic;
//资讯列表的数据
@property(nonatomic,copy)NSString*titleName1;
@property(nonatomic,copy)NSString*publicTime;
@property(nonatomic,copy)NSString * messageID;
-(id)initWithZiXunTableview:(NSDictionary*)dic;
//资讯详情
@property(nonatomic,copy)NSString * ziTitleName;
@property(nonatomic,copy)NSString * zipublicTime;

@property(nonatomic,copy)NSString * ziContent;
@property(nonatomic,copy)NSString * zimessageLaiyuan;
@property(nonatomic,copy)NSString * zihtmlUrl;

-(id)initWithZiXunXiangQing:(NSDictionary*)dic;

//资讯新闻
@property(nonatomic,copy)NSString * newsTitle;
@property(nonatomic,copy)NSString* newsCname;
-(id)initWithNewsXiangQing:(NSDictionary*)dic;



@end
