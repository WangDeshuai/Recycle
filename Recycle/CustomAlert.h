//
//  CustomAlert.h
//  AlertBlock
//
//  Created by laoyu on 15/11/24.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomAlertDelegate;
@interface CustomAlert : UIView
//遵循协议的代理
@property(nonatomic,strong)id<CustomAlertDelegate>delegate1;
//不用遵循，block传值
@property (nonatomic,assign) id delegate;
//不遵循协议就他了
@property (nonatomic,copy)void(^clickBlock)(int);


- (id)initWithTitle:(NSString*)title alerMessage:(NSString*)message canCleBtn:(NSString*)btnName1 otheBtn:(NSString*)btnName2;

-(void)show;
-(void)dissmiss;
@end
//遵循协议的话 就是它了
@protocol CustomAlertDelegate <NSObject>

- (void)clickBtnWithIndex:(int)index;

@end




