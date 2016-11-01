//
//  FirstVC.h
//  Recycle
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface FirstVC : UIViewController
{
    CLLocationManager * _manager;
    //地理编码 反编码
    CLGeocoder * _coder;
}
@end
