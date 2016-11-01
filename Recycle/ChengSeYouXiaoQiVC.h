//
//  ChengSeYouXiaoQiVC.h
//  Recycle
//
//  Created by Macx on 16/6/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChengSeYouXiaoQiVC : UITableViewController
@property(nonatomic,copy)NSString* titleName;
@property(nonatomic,assign)int  tagg;
@property(nonatomic,copy)void(^nameBlock)(NSString*name,int tagg);
@end
