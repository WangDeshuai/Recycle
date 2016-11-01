//
//  MyInformationCell.h
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "People.h"//我的收藏
#import "MyZuJi.h"//我的足迹
@interface MyInformationCell : UITableViewCell

@property(nonatomic,retain)People * pp;
@property(nonatomic,retain)MyZuJi * zujiModel;
@end
