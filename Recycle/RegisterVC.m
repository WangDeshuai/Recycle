//
//  RegisterVC.m
//  Recycle
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
{
    UIImageView * imageView;
    UITextField * username;
    UITextField *password;
    UITextField * selepasw;
    UITextField * phonenumber;
    UITextField * yanzhengma;
    
    
}
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //背景图
    imageView =[UIImageView new];
    imageView.userInteractionEnabled=YES;
    imageView.frame=CGRectMake(0, 0, KUAN, GAO);
    imageView.image=[UIImage imageNamed:@"Loin"];
    [self.view addSubview:imageView];
    
    UILabel * titleLabel =[UILabel new];
    titleLabel.text=@"新用户注册";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=1;
    titleLabel.font=[UIFont systemFontOfSize:19];
    
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
   
    UIImageView * textView =[UIImageView new];
    textView.image=[UIImage imageNamed:@"1(7)"];
    textView.userInteractionEnabled=YES;
 
    
    UIButton * tiaojianbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [tiaojianbtn setTitle:@"我已阅读并接受《中国回收商网服务协议》" forState:0];
    [tiaojianbtn setTitleColor:[UIColor whiteColor] forState:0];
    tiaojianbtn.titleLabel.font=[UIFont systemFontOfSize:12];
    
    UIButton * bbb =[UIButton buttonWithType:UIButtonTypeCustom];
    [bbb setBackgroundImage:[UIImage imageNamed:@"组 1(1)"] forState:0];
    [bbb setBackgroundImage:[UIImage imageNamed:@"矩形1"] forState:UIControlStateSelected];
    [bbb addTarget:self action:@selector(bbb:) forControlEvents:UIControlEventTouchUpInside];
   
    UIButton * registerbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [registerbtn setTitle:@"同意协议立即注册" forState:0];
    [registerbtn addTarget:self action:@selector(registerbtn) forControlEvents:UIControlEventTouchUpInside];
    [registerbtn setBackgroundImage:[UIImage imageNamed:@"zhuce2"] forState:0];
    [imageView sd_addSubviews:@[titleLabel,backBtn,textView,tiaojianbtn,bbb,registerbtn]];
    
    
    titleLabel.sd_layout
    .centerXEqualToView(imageView)
    .topSpaceToView(imageView,20)
    .widthIs(150)
    .heightIs(30);
    
    backBtn.sd_layout
    .leftSpaceToView(imageView,20)
    .topSpaceToView(imageView,25)
    .widthIs(20)
    .heightIs(20);
    
    textView.sd_layout
    .topSpaceToView(titleLabel,35)
    .centerXEqualToView(imageView)
    .heightIs(520/2*GAO/667)
    .widthIs(584/2*KUAN/375);
    
    tiaojianbtn.sd_layout
    .topSpaceToView(textView,0)
    .centerXEqualToView(imageView)
    .widthIs(230*KUAN/375)
    .heightIs(25*GAO/667);
    
    
    
    bbb.sd_layout
    .topSpaceToView(textView,7)
    .rightSpaceToView(tiaojianbtn,2)
    .widthIs(12)
    .heightIs(12);
    
    registerbtn.sd_layout
    .topSpaceToView(tiaojianbtn,10)
    .leftEqualToView(textView)
    .rightEqualToView(textView)
    .heightIs(40);
    
    
    
    
    
    username=[UITextField new];
    username.placeholder=@"请填写真实姓名";
    password=[UITextField new];
    password.placeholder=@"6-16位数字、字母或符号";
    selepasw=[UITextField new];
    selepasw.placeholder=@"再次输入您的密码";
    phonenumber=[UITextField new];
    phonenumber.placeholder=@"请填写11位有效手机号";
    yanzhengma=[UITextField new];
    yanzhengma.placeholder=@"请输入验证码";
   
     yanzhengma.keyboardType=UIKeyboardTypeNumberPad;
     phonenumber.keyboardType=UIKeyboardTypeNumberPad;
    [username setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [selepasw setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [phonenumber setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [yanzhengma setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    username.font=[UIFont systemFontOfSize:13];
    password.font=[UIFont systemFontOfSize:13];
    selepasw.font=[UIFont systemFontOfSize:13];
    phonenumber.font=[UIFont systemFontOfSize:13];
    yanzhengma.font=[UIFont systemFontOfSize:13];
    
    username.textColor=[UIColor whiteColor];
    password.textColor=[UIColor whiteColor];
    selepasw.textColor=[UIColor whiteColor];
    phonenumber.textColor=[UIColor whiteColor];
    yanzhengma.textColor=[UIColor whiteColor];
    
    UIButton * yanzhengm =[UIButton buttonWithType:UIButtonTypeCustom];
    [yanzhengm setTitle:@"获取验证码" forState:0];
    [yanzhengm setBackgroundImage:[UIImage imageNamed:@"矢量智能对象"] forState:0];
    yanzhengm.titleLabel.font=[UIFont systemFontOfSize:13];
    [yanzhengm setTitleColor:[UIColor whiteColor] forState:0];
    [yanzhengm addTarget:self action:@selector(yanzhengma:) forControlEvents:UIControlEventTouchUpInside];
    [textView sd_addSubviews:@[username,password,selepasw,phonenumber,yanzhengma,yanzhengm]];
    
//    username.backgroundColor=[UIColor redColor];
//     password.backgroundColor=[UIColor greenColor];
//     selepasw.backgroundColor=[UIColor yellowColor];
//     phonenumber.backgroundColor=[UIColor magentaColor];
//     yanzhengma.backgroundColor=[UIColor lightGrayColor];
    
    if (KUAN==375&&GAO==667) {
        username.sd_layout
        .topSpaceToView(textView,22)
        .leftSpaceToView(textView,190/2)
        .rightSpaceToView(textView,10)
        .heightIs(30);
        
        password.sd_layout
        .topSpaceToView(username,20)
        .leftEqualToView(username)
        .rightEqualToView(username)
        .heightRatioToView(username,1);
        
        selepasw.sd_layout
        .topSpaceToView(password,20)
        .leftEqualToView(username)
        .rightEqualToView(username)
        .heightRatioToView(username,1);
        
        phonenumber.sd_layout
        .topSpaceToView(selepasw,18)
        .leftEqualToView(username)
        .rightEqualToView(username)
        .heightRatioToView(username,1);
        
        yanzhengma.sd_layout
        .topSpaceToView(phonenumber,15)
        .leftEqualToView(username)
        .rightSpaceToView(textView,100)
        .heightRatioToView(username,1);
        
        
        yanzhengm.sd_layout
        .leftSpaceToView(yanzhengma,0)
        .rightSpaceToView(textView,5)
        .topEqualToView(yanzhengma)
        .heightRatioToView(username,1);
        

    }
    else if (KUAN==320&&GAO==480)
    {
        username.sd_layout
        .leftSpaceToView(textView,160/2)
        .centerYIs(520/2*GAO/667/6.5)
        .rightSpaceToView(textView,10)
        .heightIs(25);
        
        password.sd_layout
        .topSpaceToView(username,10)
        .leftEqualToView(username)
        .rightEqualToView(username)
        .heightRatioToView(username,1);
        
        selepasw.sd_layout
        .topSpaceToView(password,10)
        .leftEqualToView(username)
        .rightEqualToView(username)
        .heightRatioToView(username,1);
        
        phonenumber.sd_layout
        .topSpaceToView(selepasw,8)
        .leftEqualToView(username)
        .rightEqualToView(username)
        .heightRatioToView(username,1);
        
        yanzhengma.sd_layout
        .topSpaceToView(phonenumber,7)
        .leftEqualToView(username)
        .rightSpaceToView(textView,100)
        .heightRatioToView(username,1);
        
        
        yanzhengm.sd_layout
        .leftSpaceToView(yanzhengma,0)
        .rightSpaceToView(textView,5)
        .topEqualToView(yanzhengma)
        .heightRatioToView(username,1);
 
    }
    else if (KUAN==320&&GAO==568)
    {
        username.sd_layout
        .leftSpaceToView(textView,150/2)
        .centerYIs(510/2*GAO/667/6.5)
        .rightSpaceToView(textView,10)
        .heightIs(30);
        
        password.sd_layout
        .topSpaceToView(username,10)
        .leftEqualToView(username)
        .rightEqualToView(username)
        .heightRatioToView(username,1);
        
        selepasw.sd_layout
        .topSpaceToView(password,14)
        .leftEqualToView(username)
        .rightEqualToView(username)
        .heightRatioToView(username,1);
        
        phonenumber.sd_layout
        .topSpaceToView(selepasw,10)
        .leftEqualToView(username)
        .rightEqualToView(username)
        .heightRatioToView(username,1);
        
        yanzhengma.sd_layout
        .topSpaceToView(phonenumber,11)
        .leftEqualToView(username)
        .rightSpaceToView(textView,100)
        .heightRatioToView(username,1);
        
        
        yanzhengm.sd_layout
        .leftSpaceToView(yanzhengma,0)
        .rightSpaceToView(textView,5)
        .topEqualToView(yanzhengma)
        .heightRatioToView(username,1);
    }
    else{
        username.sd_layout
        .leftSpaceToView(textView,190/2)
        .centerYIs(520/2*GAO/667/6.5)
        .rightSpaceToView(textView,10)
        .heightIs(40);
        
        password.sd_layout
        .topSpaceToView(username,15)
        .leftEqualToView(username)
        .rightEqualToView(username)
        .heightRatioToView(username,1);
        
        selepasw.sd_layout
        .topSpaceToView(password,15)
        .leftEqualToView(username)
        .rightEqualToView(username)
        .heightRatioToView(username,1);
        
        phonenumber.sd_layout
        .topSpaceToView(selepasw,12)
        .leftEqualToView(username)
        .rightEqualToView(username)
        .heightRatioToView(username,1);
        
        yanzhengma.sd_layout
        .topSpaceToView(phonenumber,10)
        .leftEqualToView(username)
        .rightSpaceToView(textView,100)
        .heightRatioToView(username,1);
        
        
        yanzhengm.sd_layout
        .leftSpaceToView(yanzhengma,0)
        .rightSpaceToView(textView,5)
        .topEqualToView(yanzhengma)
        .heightRatioToView(username,1);
    }
    
    
}

-(void)shipei{
    
    
    
    
    
    
    
    
}













//获取验证码
-(void)yanzhengma:(UIButton*)sender
{
    [Engine getHuoQuPhoneNumber:phonenumber.text  type:@"1"  success:^(NSDictionary *dic) {
        NSLog(@">>>%@",[dic objectForKey:@"Item2"]);
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
//阅读条款
-(void)bbb:(UIButton *)bbb
{
    bbb.selected=!bbb.selected;
}

//注册按钮
-(void)registerbtn
{
    
    NSLog(@"用户名>>>%@",username.text);
    NSLog(@"密码>>>%@",username.text);
    NSLog(@"确认密码>>>%@",selepasw.text);
    NSLog(@"手机号>>>%@",phonenumber.text);
    NSLog(@"验证码手机号>>>%@",yanzhengma.text);
    
    if ([username.text isEqualToString:@""] || [password.text isEqualToString:@""] ||[phonenumber.text isEqualToString:@""]|| [yanzhengma.text isEqualToString:@""] )
    {
        [WINDOW showHUDWithText:@"请填写完信息在提交" Type:ShowPhotoNo Enabled:YES];
        return;
    }
    
    
    [Engine Register:username.text Password:password.text Phone:phonenumber.text YanZheng:yanzhengma.text success:^(NSDictionary *dic) {
       
        NSString * falseture =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        
        if ([falseture isEqualToString:@"0"]) {
            NSLog(@"提示语:%@",[dic objectForKey:@"Item2"]);
            [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
        }else{
            self.pswNameBlock(phonenumber.text,password.text);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        
    } error:nil];
    
    
    
    

}




-(void)back
{
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
