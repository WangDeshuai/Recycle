//
//  ForgetPasswordVC.m
//  Recycle
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ForgetPasswordVC.h"
#import "MiMaChongZhiVC.h"
@interface ForgetPasswordVC ()
{
    UIImageView * imageView;
    UITextField * phoneNumber;
    UITextField * passWord;
}
@end

@implementation ForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //背景图
    imageView =[UIImageView new];
    imageView.userInteractionEnabled=YES;
    imageView.frame=CGRectMake(0, 0, KUAN, GAO);
    imageView.image=[UIImage imageNamed:@"Loin"];
    [self.view addSubview:imageView];
    //标题
    UILabel * titleLabel =[UILabel new];
    titleLabel.text=@"密码找回";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=1;
    titleLabel.font=[UIFont systemFontOfSize:19];
    //返回
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //手机号验证码
    UIImageView * passWordZH =[UIImageView new];
    passWordZH.image=[UIImage imageNamed:@"验证码"];
    passWordZH.userInteractionEnabled=YES;
    
    //确定按钮
    UIButton * queBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [queBtn setBackgroundImage:[UIImage imageNamed:@"确认"] forState:0];
    [queBtn setTitle:@"确定" forState:0];
    [queBtn addTarget:self action:@selector(querenBtn) forControlEvents:UIControlEventTouchUpInside];
    [imageView sd_addSubviews:@[titleLabel,backBtn,passWordZH,queBtn]];
   
    titleLabel.sd_layout
    .centerXEqualToView(imageView)
    .topSpaceToView(imageView,20)
    .widthIs(150)
    .heightIs(30);
    
    backBtn.sd_layout
    .leftSpaceToView(imageView,15)
    .topSpaceToView(imageView,25)
    .widthIs(20)
    .heightIs(20);
    
    
    passWordZH.sd_layout
    .topSpaceToView(titleLabel,70)
    .centerXEqualToView(imageView)
    .widthIs(601/2)
    .heightIs(210/2);
    
    queBtn.sd_layout
    .centerXEqualToView(imageView)
    .topSpaceToView(passWordZH,20)
    .widthIs(383/2)
    .heightIs(79/2);
    
    
    //2个文本框
    phoneNumber =[UITextField new];
     passWord =[UITextField new];
    passWord.font=[UIFont systemFontOfSize:15];
    phoneNumber.font=[UIFont systemFontOfSize:15];
    passWord.textColor=[UIColor whiteColor];
    phoneNumber.textColor=[UIColor whiteColor];
   passWord.placeholder=@"验证码";
    passWord.keyboardType=UIKeyboardTypeNumberPad;
    phoneNumber.placeholder=@"请输入您的手机号";
    passWord.textColor=[UIColor whiteColor];
    phoneNumber.textColor=[UIColor whiteColor];
    [phoneNumber setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [passWord setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    //2个按钮
//    UIButton * button1 =[UIButton buttonWithType:UIButtonTypeCustom];
//    [button1 setTitle:@"获取验证码" forState:0];
//    [button1 setBackgroundImage:[UIImage imageNamed:@"获取验证码"] forState:0];
//    [button1 setTitleColor:[UIColor whiteColor] forState:0];
//    button1.titleLabel.font=[UIFont systemFontOfSize:13];
    UIButton * button2 =[UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"获取验证码" forState:0];
    [button2 setBackgroundImage:[UIImage imageNamed:@"获取验证码2"] forState:0];
    [button2 addTarget:self action:@selector(YanZhengMa:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitleColor:[UIColor whiteColor] forState:0];
    button2.titleLabel.font=[UIFont systemFontOfSize:13];
    
    [passWordZH sd_addSubviews:@[phoneNumber,passWord,button2]];
    
    phoneNumber.sd_layout
    .topSpaceToView(passWordZH,15)
    .leftSpaceToView(passWordZH,70)
    .widthIs(130)
    .heightIs(30);
    
    passWord.sd_layout
    .topSpaceToView(phoneNumber,20)
    .leftEqualToView(phoneNumber)
    .widthIs(70)
    .heightRatioToView(phoneNumber,1);
    
//    button1.sd_layout
//    .leftSpaceToView(phoneNumber,5)
//    .rightSpaceToView(passWordZH,5)
//    .heightIs(30)
//    .topEqualToView(phoneNumber);
    
    button2.sd_layout
    .topSpaceToView(phoneNumber,20)
    .rightSpaceToView(passWordZH,5)
    .heightIs(30)
    .leftSpaceToView(passWord,0);
    
    
}
-(void)YanZhengMa:(UIButton*)sender
{
   
     UIAlertController * action =[UIAlertController alertControllerWithTitle:nil message:@"正在获取验证码请稍后..." preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:action animated:YES completion:nil];
    [Engine getHuoQuPhoneNumber:phoneNumber.text  type:@"3"  success:^(NSDictionary *dic) {
        NSLog(@">>>%@",[dic objectForKey:@"Item2"]);
        [action dismissViewControllerAnimated:YES completion:nil];
        if ([[dic objectForKey:@"Item2"] isEqualToString:@"发送成功！"]) {
            //实现倒计时
            __block int timeout=60; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                        sender.userInteractionEnabled = YES;
                    });
                }
                else{
                    int seconds = timeout % 60;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        //NSLog(@"____%@",strTime);
                        [UIView beginAnimations:nil context:nil];
                        [UIView setAnimationDuration:1];
                        [sender setTitle:[NSString stringWithFormat:@"%@秒重新发送",strTime] forState:UIControlStateNormal];
                        [UIView commitAnimations];
                        sender.userInteractionEnabled = NO;
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
        
        
        
        
    } error:nil];
}
-(void)jingGaoKuang:(NSString*)item1 message:(NSString*)info{
    UIAlertController * action =[UIAlertController alertControllerWithTitle:@"温馨提示" message:info preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * act =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([item1 isEqualToString:@"1"])
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [action addAction:act];
    
}
-(void)querenBtn{
//    phoneNumber
//    passWord
    if (phoneNumber.text.length==0 || passWord.text.length==0) {
        NSLog(@"他们都是空的");
        
    }else{
        MiMaChongZhiVC * vc =[MiMaChongZhiVC new];
        vc.phoneNumber=phoneNumber.text;
        vc.phoneCode=passWord.text;
        [self presentViewController:vc animated:YES completion:nil];
    }
   
    
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
