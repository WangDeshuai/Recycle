//
//  ZiXunClassVC.h
//  Recycle
//
//  Created by Macx on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZiXunFenLeiModel.h"
@interface ZiXunClassVC : UIViewController
@property(nonatomic,retain)ZiXunFenLeiModel * model;
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,copy)void(^classidBlock)(NSInteger classidd);
@end
