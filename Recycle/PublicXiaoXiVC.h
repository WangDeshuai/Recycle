//
//  PublicXiaoXiVC.h
//  Recycle
//
//  Created by Macx on 16/6/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublicXiaoXiVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *messageTF;
@property (weak, nonatomic) IBOutlet UIView *inPutView;
@property (weak, nonatomic) IBOutlet UIButton *yuYinSend;
@property (weak, nonatomic) IBOutlet UIImageView *bgimage;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property(nonatomic,copy)NSString * whoMessageID;
@property(nonatomic,copy)NSString * titleName;
@property(nonatomic,copy)NSString * headImage;
@end
