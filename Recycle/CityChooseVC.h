//
//  CityChooseVC.h
//  Recycle
//
//  Created by Macx on 16/6/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface CityChooseVC : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager * _manager;
    //地理编码 反编码
    CLGeocoder * _coder;
}
@property(nonatomic,copy)void(^citynameBlock)(NSString*name,NSString*code,NSString*shengCode);
@end
