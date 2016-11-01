//
//  MyWeiZhi.h
//  Recycle
//
//  Created by Macx on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//假如是从修改过来的界面，里面本身就应该有值，值就从这里面获取
#import "GongQiuModel.h"
@interface MyWeiZhi : UIViewController
{
    //存放相机照的相
    NSMutableArray * _photoArray;
    //存放相机照片上按钮的个数
    NSMutableArray * _photoBtnArr;
}
@property(nonatomic,copy)NSString*titleName;
@property(nonatomic,copy)NSString * typee;
//修改界面带值过来
@property(nonatomic,retain)GongQiuModel * model;
/*
 修改界面过的时候会给这个赋值，提交的时候，可以通过这个值，来判断是修改的提交还是本身的提交
 */
@property(nonatomic,copy)NSString * xinXinID;

@end
