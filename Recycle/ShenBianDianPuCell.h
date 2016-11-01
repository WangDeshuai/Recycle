//
//  ShenBianDianPuCell.h
//  Recycle
//
//  Created by Macx on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShenBianDianPuModel.h"
@interface ShenBianDianPuCell : UITableViewCell
@property(nonatomic,retain)ShenBianDianPuModel * model;
@property(nonatomic,retain)UILabel * titleNameLabel;
@property(nonatomic,retain)UILabel * zhuYingLabel;
@property(nonatomic,retain)UIImageView * image1;
@end
