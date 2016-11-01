//
//  GongableCell.h
//  Recycle
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GongQiuModel.h"
@interface GongableCell : UITableViewCell
@property(nonatomic,retain)UIImageView *image1;
@property(nonatomic,retain)UILabel * titleLab;
@property(nonatomic,retain)UILabel *priceLab;
@property(nonatomic,retain)UILabel *VIPlab;
@property(nonatomic,retain)UILabel *diquLab;
@property(nonatomic,retain)UILabel * timeLab;


@property(nonatomic,retain)GongQiuModel * gmodel;
@end
