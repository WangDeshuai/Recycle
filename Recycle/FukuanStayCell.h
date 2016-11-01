//
//  FukuanStayCell.h
//  Recycle
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipQuanXianModel.h"
@interface FukuanStayCell : UITableViewCell
@property(nonatomic,retain)UIImageView * image1;
@property(nonatomic,retain)UILabel * userNmae;
@property(nonatomic,retain)UILabel * account;
@property(nonatomic,retain)UILabel * openHang;

@property(nonatomic,retain)VipQuanXianModel * model;
@end
