//
//  LoginVC.m
//  Recycle
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "ForgetPasswordVC.h"
@interface LoginVC ()
{
    UIImageView * imageView;
    UITextField * username;
    UITextField * password;
    LoginModel * md ;
    UIImageView *textView;
}
@property(nonatomic,copy)NSString*textStr;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //背景图
    imageView =[UIImageView new];
    imageView.userInteractionEnabled=YES;
    imageView.frame=CGRectMake(0, 0, KUAN, GAO);
    imageView.image=[UIImage imageNamed:@"Loin"];
    [self.view addSubview:imageView];
   
    
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:backBtn];
    
    
    
    UIButton * registBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame=CGRectMake(KUAN-5-60, 25, 50, 30);
    [registBtn setTitle:@"注册" forState:0];
    [registBtn addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:registBtn];
    backBtn.sd_layout
    .leftSpaceToView(imageView,20)
    .topSpaceToView(imageView,30)
    .widthIs(20)
    .heightIs(20);
//    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame=CGRectMake(100, 100, 100, 100);
//    backBtn.backgroundColor=[UIColor redColor];
//    [backBtn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
//    [imageView addSubview:backBtn];
    
    //logo
    UIImageView *logoView =[UIImageView new];
    logoView.image=[UIImage imageNamed:@"logo"];
    //text
    textView=[UIImageView new];
    textView.image=[UIImage imageNamed:@"组1 1"];
    
    username=[UITextField new];
    username.placeholder=@"用户名/手机号";
    password=[UITextField new];
    password.placeholder=@"密码";
    password.tag=1;
    username.textColor=[UIColor whiteColor];
    password.textColor=[UIColor whiteColor];
    
    [username setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     password.secureTextEntry=YES;
    
    UIButton *  loginbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginbtn setBackgroundImage:[UIImage imageNamed:@"btn11"] forState:0];
    [loginbtn setTitle:@"登录" forState:0];
    loginbtn.tag=1;
    [loginbtn addTarget:self action:@selector(denglu:) forControlEvents:UIControlEventTouchUpInside];
    loginbtn.titleLabel.font=[UIFont systemFontOfSize:19];
    //忘记密码
    UIButton *  wangjiPsw = [UIButton buttonWithType:UIButtonTypeCustom];
    [wangjiPsw setTitle:@"忘记密码" forState:0];
    
    [wangjiPsw addTarget:self action:@selector(wangji) forControlEvents:UIControlEventTouchUpInside];
     wangjiPsw.titleLabel.font=[UIFont systemFontOfSize:13];
    
    
    
    [imageView sd_addSubviews:@[logoView,textView,username,password,loginbtn,wangjiPsw]];
    logoView.sd_layout
    .topSpaceToView(imageView,95*GAO/667)
    .centerXEqualToView(imageView)
    .widthIs(90)
    .heightIs(90);
    
//    username.backgroundColor=[UIColor redColor];
//    password.backgroundColor=[UIColor blueColor];
    
    textView.sd_layout
    .topSpaceToView(logoView,53)
    .centerXEqualToView(imageView)
    .heightIs(238/2*GAO/667)
    .widthIs(466/2*KUAN/375);
if (KUAN==375&&GAO==667) {
    username.sd_layout
    .topSpaceToView(logoView,68)
    .centerXEqualToView(textView)
    .widthIs(120)
    .heightIs(236/6);
    
    password.sd_layout
    .topSpaceToView(username,10)
    .leftEqualToView(username)
    .rightEqualToView(username)
    .heightRatioToView(username,1);
     }
else if (KUAN==320&&GAO==480)
     {
        
         textView.sd_layout
         .topSpaceToView(logoView,25)
         .centerXEqualToView(imageView)
         .heightIs(238/2*GAO/667)
         .widthIs(466/2*KUAN/375);
         
         username.sd_layout
         .topSpaceToView(logoView,33)
         .centerXEqualToView(textView)
         .widthIs(120)
         .heightIs(236/7);
         
         password.sd_layout
         .topSpaceToView(username,0)
         .leftEqualToView(username)
         .rightEqualToView(username)
         .heightRatioToView(username,1);
     }
else if (KUAN==320&&GAO==568){
    textView.sd_layout
    .topSpaceToView(logoView,25)
    .centerXEqualToView(imageView)
    .heightIs(238/2*GAO/667)
    .widthIs(466/2*KUAN/375);
    
    username.sd_layout
    .topSpaceToView(logoView,38)
    .centerXEqualToView(textView)
    .widthIs(120)
    .heightIs(236/7);
    
    password.sd_layout
    .topSpaceToView(username,5)
    .leftEqualToView(username)
    .rightEqualToView(username)
    .heightRatioToView(username,1);
}
else{
         username.sd_layout
         .topSpaceToView(logoView,75)
         .centerXEqualToView(textView)
         .widthIs(120)
         .heightIs(236/6);
         
         password.sd_layout
         .topSpaceToView(username,10)
         .leftEqualToView(username)
         .rightEqualToView(username)
         .heightRatioToView(username,1);
     }
    loginbtn.sd_layout
    .topSpaceToView(textView,0)
    .leftSpaceToView(imageView,170/2)
    .rightSpaceToView(imageView,170/2)
    .heightIs(35);
    
    wangjiPsw.sd_layout
    .topSpaceToView(loginbtn,5)
    .rightEqualToView(loginbtn)
    .heightIs(30)
    .widthIs(60);
    
  //此接口是用来骗苹果的
    [Engine kankanissuccess:^(NSDictionary *dic) {
        NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item2"]];
        if ([ss isEqualToString:@"0"]) {
            NSLog(@"隐藏");
            registBtn.hidden=YES;
        }else{
             NSLog(@"显示");
             registBtn.hidden=NO;
            [self btn3Label];
        }
        
    } error:nil];
    
    
   
    
}
-(void)btn3Label
{
     CGFloat jiange =(KUAN-40*3)/4;
    for (int i = 0; i<3; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(jiange+(40+jiange)*i, 481*GAO/667, 40, 40);
        NSString * ss =[NSString stringWithFormat:@"Loin%d",i+3];
        [btn setBackgroundImage:[UIImage imageNamed:ss] forState:0];
        [imageView addSubview:btn];
    }
    
    UILabel * otherLab =[UILabel new];
    if (KUAN==320&&GAO==480) {
        otherLab.bounds=CGRectMake(0, 10, 120, 35);
        otherLab.center=CGPointMake(imageView.center.x, (481+60+36)*GAO/667);
    }else{
        otherLab.bounds=CGRectMake(0, 10, 120, 35);
        otherLab.center=CGPointMake(imageView.center.x, (481+30+36)*GAO/667);
    }
    otherLab.text=@"其他登录方式";
    otherLab.textColor=[UIColor whiteColor];
    otherLab.textAlignment=1;
    [imageView addSubview:otherLab];
}




-(void)zhuce
{
    RegisterVC * zhuce =[RegisterVC new];
    zhuce.pswNameBlock=^(NSString*name,NSString*psw){
        username.text=name;
        password.text=psw;
    };
    [self presentViewController:zhuce animated:YES completion:nil];
}
-(void)denglu:(UIButton*)button
{
    if (button.tag==1)
    {
        NSLog(@"点击了登录");
       
        [WINDOW showHUDWithText:@"登录中..." Type:ShowLoading Enabled:YES];
        NSString * mima;
        if (password.tag==1) {
            mima=password.text;
        }
        [Engine LoginName:username.text Password:mima success:^(NSDictionary *dic) {
            NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            
            if ([ss isEqualToString:@"0"]) {//如果是0，有可能密码错误，也有可能是短信登录
                //如果([dic objectForKey:@"Item3"]==[NSNull null])为null那么就是密码错误
                if ([dic objectForKey:@"Item3"]==[NSNull null])
                {
                    [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
                    
                }else{
                    //就是需要短信验证
                    [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoYes Enabled:YES];
                    button.tag=2;
                    [self yanzeng];
                   NSString * uid= [[dic objectForKey:@"Item3"]objectForKey:@"us_id"];
                    [[NSUserDefaults standardUserDefaults]setObject:uid forKey:@"uid"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    //                [self ActionViewUid:uid];
                    //            [WINDOW showHUDWithText:@"成功登录" Type:ShowDismiss Enabled:YES];
                }
                
            }else
            {
                [WINDOW showHUDWithText:@"成功登录" Type:ShowPhotoYes Enabled:YES];
                //登录成功,把Token转化字符串存到本地
                NSMutableDictionary * dicc =[dic objectForKey:@"Item3"];
                //存二维码
                [[NSUserDefaults standardUserDefaults]setObject:[dicc objectForKey:@"us_webhss"] forKey:@"二维码"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                md =[[LoginModel alloc]initWithDic:dicc];
                [[NSUserDefaults standardUserDefaults]setObject:md.messageID forKey:@"messageid"];
                [self saveMessagePlist];
                //把token缓存到本地
                NSString * token =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item2"]];
                [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        } error:^(NSError *error) {
            
        }];
    }else{//第二次点击登录的时候
        NSString * code;
        if (password.tag==2) {
            code=password.text;
        }
        NSString *uid =[[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
        NSLog(@"uid=%@",uid);
        NSLog(@"code=%@",code);
        [WINDOW showHUDWithText:@"登录中..." Type:ShowLoading Enabled:YES];
        [Engine LoginUid:uid Code:code success:^(NSDictionary *dic) {
            
            NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([ss isEqualToString:@"0"]) {
                [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
            }else
            {
                [WINDOW showHUDWithText:@"成功登录" Type:ShowPhotoYes Enabled:YES];
                //登录成功,把Token转化字符串存到本地
                NSMutableDictionary * dicc =[dic objectForKey:@"Item3"];
                md =[[LoginModel alloc]initWithDic:dicc];
                [[NSUserDefaults standardUserDefaults]setObject:md.messageID forKey:@"messageid"];
                [self saveMessagePlist];
                //把token缓存到本地
                NSString * token =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item2"]];
                [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        } error:^(NSError *error) {
            
        }];
        
    }
        
        
    
  
}
-(void)yanzeng{
    textView.image=[UIImage imageNamed:@"login"];
    password.tag=2;
    password.text=@"";
    password.placeholder=@"短信验证码";
    password.secureTextEntry=NO;
    [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    password.keyboardType=UIKeyboardTypeNumberPad;
    
    
}

-(void)ActionViewUid:(NSString*)uid{
    
   // NSString * textStr;
    UIAlertController * alerview =[UIAlertController alertControllerWithTitle:@"请输入短信验证码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alerview addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType=UIKeyboardTypeNumberPad;
    }];
    
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        LoginUid
        UITextField *userEmail = alerview.textFields.firstObject;
        NSLog(@">>>str=%@",userEmail.text);
        NSLog(@">>>uid=%@",uid);
        [Engine LoginUid:uid Code:userEmail.text success:^(NSDictionary *dic) {
            
            NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([ss isEqualToString:@"0"]) {
                [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
            }else
            {
                [WINDOW showHUDWithText:@"成功登录" Type:ShowPhotoYes Enabled:YES];
                //登录成功,把Token转化字符串存到本地
                NSMutableDictionary * dicc =[dic objectForKey:@"Item3"];
                md =[[LoginModel alloc]initWithDic:dicc];
                [[NSUserDefaults standardUserDefaults]setObject:md.messageID forKey:@"messageid"];
                [self saveMessagePlist];
                //把token缓存到本地
                NSString * token =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item2"]];
                [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self dismissViewControllerAnimated:YES completion:nil];
                
                
            }
            
            
        } error:^(NSError *error) {
            
        }];
        
    }];
    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
   
    [alerview addAction:action2];
     [alerview addAction:action];
    [self presentViewController:alerview animated:YES completion:nil];
    
    
}


//把个人信息存储到本地plist
-(void)saveMessagePlist{
    
    NSMutableDictionary * dictplist =[NSMutableDictionary new];
    
    [dictplist setObject:md.messageID forKey:@"messageID"];
    if (md.userName==nil || md.phoneNumber==nil|| md.picUrl==nil) {
        NSLog(@"手机号或者联系人是空的，plist没存上");
        return;
    }
    [dictplist setObject:md.userName forKey:@"lianxiren"];
    [dictplist setObject:md.phoneNumber forKey:@"shoujihao"];
    [dictplist setObject:md.companyName forKey:@"gongsi"];
    [dictplist setObject:md.picUrl forKey:@"touxianga"];
    
    
    
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"message.plist"];
   // NSLog(@"输出路径%@",plistPath);
    [dictplist writeToFile:plistPath atomically:YES];
//    //读取输出
//    //  NSMutableDictionary *writeData=[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
//    //NSLog(@"write data is :%@",writeData);
}


-(void)wangji
{
    NSLog(@"忘记");
    ForgetPasswordVC * vc =[ForgetPasswordVC new];
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)aaa
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
