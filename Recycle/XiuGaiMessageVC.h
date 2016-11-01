//
//  XiuGaiMessageVC.h
//  Recycle
//
//  Created by Macx on 16/6/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModel.h"
@interface XiuGaiMessageVC : UIViewController
@property(nonatomic,assign)id delegate;
@property(nonatomic,copy)NSString*titleName;
@property(nonatomic,assign)int indexRow;
//下面这个model主要是用来获取messID 和classVip的，用来生成二维码的
@property(nonatomic,retain)LoginModel * model;
@end

@protocol XiuGaiModelDelegate <NSObject>
-(void)refresh:(LoginModel*)model;

@end