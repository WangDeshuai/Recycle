//
//  ZaiXiangxiVC.h
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GongQiuXiangXiModel.h"
#import "vipIDModel.h"
@interface ZaiXiangxiVC : UIViewController
/*
 这条数据是从上个界面传过来的，vipIDModel是根据传过来的用户ID，获取的这一家的所有信息
 2条数据都可以用，目前
 */
@property(nonatomic,retain)GongQiuXiangXiModel * gmodel;
/*
 是判断从哪个界面进的来的，如果yonghuID有值代表是从发现>身边店铺进入的
 如果没有值则代表从详情页面进入
 
 */
@property(nonatomic,copy)NSString * yonghuID;
@end
