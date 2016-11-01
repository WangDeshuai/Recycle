//
//  ChatViewController.h
//  Recycle
//
//  Created by Macx on 16/6/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *inPutView;
@property (weak, nonatomic) IBOutlet UIImageView *bgimage;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *messageTF;
@property (weak, nonatomic) IBOutlet UIButton *yuYinSend;
@property(nonatomic,copy)NSString * sendMessageID;//receive
@property(nonatomic,copy)NSString * receiveMessageID;
@end
