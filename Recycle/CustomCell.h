//
//  CustomCell.h
//  MyCollection2
//
//  Created by laoyu on 15/11/27.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"
@interface CustomCell : UICollectionViewCell
@property(nonatomic,retain)FirstModel * model;
@property (nonatomic,retain) UILabel *lab;
@property (nonatomic,retain) UIImageView *image1;
@end
