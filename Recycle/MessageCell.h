//
//  MessageCell.h
//  Recycle
//
//  Created by Macx on 16/6/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *BubbleView;
@property (weak, nonatomic) IBOutlet UILabel *MessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;

@end
