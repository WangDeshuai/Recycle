//
//  MyAddressVC.h
//  Recycle
//
//  Created by Macx on 16/6/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAddressVC : UIViewController
{
    BOOL _isFirst;//判断是不是首次运行省份
    BOOL _isCity;//判断是不是首次运行city
}
@property(nonatomic,copy)NSString * titleName;
@property(nonatomic,assign)NSInteger number;
@property (nonatomic,copy)void(^cityNameCodeBlock)(NSString*Cityname,NSString*code);
@end
