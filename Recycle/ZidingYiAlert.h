//
//  ZidingYiAlert.h
//  Recycle
//
//  Created by Macx on 16/7/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GongQiuXiangXiModel.h"
@interface ZidingYiAlert : UIView

- (id)initWithTitle:(NSString*)title alerMessage:(GongQiuXiangXiModel*)message canCleBtn:(NSString*)btnName1;
-(void)show;
-(void)dissmiss;
@property (nonatomic,copy)void(^clickBlock)(int);
@end
