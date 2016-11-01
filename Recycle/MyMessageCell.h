//
//  MyMessageCell.h
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModel.h"
@interface MyMessageCell : UITableViewCell
@property(nonatomic,retain)UILabel * lab1;
@property(nonatomic,retain)UIImageView * image1;//头像或者二维码
@property(nonatomic,retain)UIImageView * image2;//箭头

@property(nonatomic,retain)LoginModel * model;
@property(nonatomic,retain)UILabel * titleNameLabel;
@property(nonatomic,copy)NSString*text;
@end
