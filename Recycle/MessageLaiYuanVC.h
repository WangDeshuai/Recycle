//
//  MessageLaiYuanVC.h
//  Recycle
//
//  Created by Macx on 16/6/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageLaiYuanVC : UITableViewController
@property(nonatomic,copy)void (^nameBlock)(NSString* name);
@end
