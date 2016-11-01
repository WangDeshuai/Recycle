//
//  PaiMaiPublicVC.h
//  Recycle
//
//  Created by Macx on 16/6/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GongQiuModel.h"
@interface PaiMaiPublicVC : UIViewController
//修改界面带值过来
@property(nonatomic,retain)GongQiuModel * model;
@property(nonatomic,copy)NSString*titleName;
/*
 修改界面过的时候会给这个赋值，提交的时候，可以通过这个值，来判断是修改的提交还是本身的提交
 */
@property(nonatomic,copy)NSString * xinXinID;
@end
