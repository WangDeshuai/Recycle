//
//  MyWeiZhiCell.h
//  Recycle
//
//  Created by Macx on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWeiZhiCell : UITableViewCell
@property(nonatomic,retain)UILabel * label;//系统的字
@property(nonatomic,retain)UILabel * taiLabel;//系统的字(元台)
@property(nonatomic,retain)UILabel * yuanLabel;//系统的字(元台)
@property(nonatomic,retain)UITextField * textFiled;
@property(nonatomic,retain)UIImageView * image1;//向右的箭头
@property(nonatomic,retain)UILabel * titleNameLabel;
@end
