//
//  MySubscriptionCell.h
//  Recycle
//
//  Created by Macx on 16/6/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DingYueModel.h"
@interface MySubscriptionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleteDingYue;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipLable;

@property (weak, nonatomic) IBOutlet UILabel *Ddiqu;
@property (weak, nonatomic) IBOutlet UIView *LineView;

@property (weak, nonatomic) IBOutlet UILabel *LaiYuan;


@property (nonatomic,retain)DingYueModel * model;
@end
