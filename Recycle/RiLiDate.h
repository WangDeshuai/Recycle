//
//  RiLiDate.h
//  RiLiFengZhuang
//
//  Created by Macx on 16/6/23.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RiLiDate : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, copy) void(^calendarBlock)(NSInteger day, NSInteger month, NSInteger year);
@property (nonatomic , strong) NSDate *date;
@property (nonatomic , strong) NSDate *today;
@property (nonatomic,copy)void(^dateBlock)(NSString*year,NSString*mone,NSString*daty,NSString*shi,NSString*fen,NSString*miao);
-(id)initWithFrame:(CGRect)frame;



@end
