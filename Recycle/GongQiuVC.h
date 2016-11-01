//
//  GongQiuVC.h
//  Recycle
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"
@interface GongQiuVC : UIViewController
{
    int shengTag;//通过这个值才能把河北省的城市，统一存成c2
    NSMutableArray * sCityCode;//用来单独存放citycode
    NSMutableArray * sShengArr;//用来存放数据库获取的省份
    BOOL isFirst;//判断是不是首次运行省份
    BOOL isCity;//判断是不是首次运行city
}
@property(nonatomic,copy)NSString * titleName;
/*判断是从哪个界面过来的,0代表供，1代表求，2代表资产依次类推*/
@property(nonatomic,assign)NSInteger number1;
//就是从搜索界面来的（资产求购）
@property(nonatomic,copy)NSString* guanjianzi;
/*如果这个model有值就代表点击的首页的6个大按钮，进来之后顶端的3个button直接显示数据
 其实也就是要model的拼音，就是根据拼音筛选的
 */
@property(nonatomic,retain)FirstModel *model;
@end
