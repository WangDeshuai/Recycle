//
//  HangYeVC.h
//  Recycle
//
//  Created by Macx on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HangYeVC : UIViewController
{
    BOOL  _isFirst;
    BOOL  _isCity;
}
@property(nonatomic,copy)void(^hangYeNameCidBlock)(NSString*name,NSString*code);
@end
