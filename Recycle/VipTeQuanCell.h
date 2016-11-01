//
//  VipTeQuanCell.h
//  Recycle
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipQuanXianModel.h"
@interface VipTeQuanCell : UITableViewCell
@property(nonatomic,retain)UILabel * label1;
@property(nonatomic,retain)UILabel * label2;
@property(nonatomic,retain)UIButton * btn;
@property(nonatomic,copy)VipQuanXianModel * model;
@end
