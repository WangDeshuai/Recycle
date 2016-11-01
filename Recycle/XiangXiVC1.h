//
//  XiangXiVC1.h
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XiangXiVC1 : UIViewController
@property(nonatomic,assign)NSInteger number;
//messageID,哪条信息就是哪条信息的ID(全程都是靠这个信息ID来获取数据的)
@property(nonatomic,copy)NSString * messageID;
@property(nonatomic,copy)NSString * uidd;
//判断一下是哪个界面过来的，如果有值说明从我的发布来的
@property(nonatomic,copy)NSString * jiemian;
//判断一下是资产进来的还是拍卖还是供求
@property(nonatomic,assign)NSInteger  tagg;


@end
