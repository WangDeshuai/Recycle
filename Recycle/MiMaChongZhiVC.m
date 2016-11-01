//
//  MiMaChongZhiVC.m
//  Recycle
//
//  Created by Macx on 16/7/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MiMaChongZhiVC.h"

@interface MiMaChongZhiVC ()
{
    UIImageView * imageView;
    UITextField * Password;
    UITextField * PasswordTwo;
}
@end

@implementation MiMaChongZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CreatBgImageView];
}
-(void)CreatBgImageView{
    //背景图
    imageView =[UIImageView new];
    imageView.userInteractionEnabled=YES;
    imageView.frame=CGRectMake(0, 0, KUAN, GAO);
    imageView.image=[UIImage imageNamed:@"Loin"];
    [self.view addSubview:imageView];
    //标题
    UILabel * titleLabel =[UILabel new];
    titleLabel.text=@"密码重置";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=1;
    titleLabel.font=[UIFont systemFontOfSize:19];
    //返回
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
     [imageView sd_addSubviews:@[titleLabel,backBtn]];
    
    
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
    
    UIImageView * bgImageview =[UIImageView new];
    bgImageview.image=[UIImage imageNamed:@"bg(4)"];
    bgImageview.userInteractionEnabled=YES;
    [imageView sd_addSubviews:@[bgImageview]];
    bgImageview.sd_layout
    .topSpaceToView(titleLabel,70)
    .centerXEqualToView(imageView)
    .widthIs(601/2*KUAN/375)
    .heightIs(210/2*GAO/667);
    
    UILabel * newPass =[UILabel new];
    newPass.text=@"新密码";
    newPass.textColor=[UIColor whiteColor];
    UILabel * twoPass =[UILabel new];
    twoPass.text=@"重复密码";
    twoPass.textColor=[UIColor whiteColor];
    twoPass.font=[UIFont systemFontOfSize:15];
    newPass.font=[UIFont systemFontOfSize:15];
    [bgImageview sd_addSubviews:@[newPass,twoPass]];
   
    
    newPass.sd_layout
    .leftSpaceToView(bgImageview,10)
    .centerYIs(105/4*GAO/667)
    .widthIs(70)
    .heightIs(25);
   
    twoPass.sd_layout
    .leftEqualToView(newPass)
    .centerYIs(105/4*3*GAO/667)
    .widthRatioToView(newPass,1)
    .heightRatioToView(newPass,1);
    
    Password=[UITextField new];
    PasswordTwo=[UITextField new];
    Password.placeholder=@"6-16位数字、字母";
    PasswordTwo.placeholder=@"再次输入密码";
    [Password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [PasswordTwo setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    Password.textColor=[UIColor whiteColor];
    PasswordTwo.textColor=[UIColor whiteColor];
    Password.font=[UIFont systemFontOfSize:15];
    PasswordTwo.font=[UIFont systemFontOfSize:15];
    [bgImageview sd_addSubviews:@[Password,PasswordTwo]];
    
    Password.sd_layout
    .leftSpaceToView(newPass,10)
    .topEqualToView(newPass)
    .rightSpaceToView(bgImageview,10)
    .heightIs(25);
    
    PasswordTwo.sd_layout
    .leftEqualToView(Password)
    .topEqualToView(twoPass)
    .rightEqualToView(Password)
    .heightRatioToView(Password,1);
    
 //确定修改按钮
    UIButton * commitBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setTitle:@"确定" forState:0];
    [commitBtn addTarget:self action:@selector(commitBtnClink) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"确认"] forState:0];
    [imageView addSubview:commitBtn];
    
    commitBtn.sd_layout
    .centerXEqualToView(imageView)
    .topSpaceToView(bgImageview,20)
    .widthIs(383/2)
    .heightIs(79/2);
    
    
}
-(void)commitBtnClink{
//    Password
//    PasswordTwo
    if (Password.text.length==0||PasswordTwo.text.length==0)
    {
        
    }else{
        [self Xiugai];
    }
    
    
}

-(void)Xiugai{
     UIAlertController * action =[UIAlertController alertControllerWithTitle:nil message:@"请稍后正在修改中..." preferredStyle:UIAlertControllerStyleAlert];
     [self presentViewController:action animated:YES completion:nil];
    [Engine XiuGaiMiMaPhoneNumber:_phoneNumber Password:PasswordTwo.text PhoneCode:_phoneCode success:^(NSDictionary *dic) {
        [action dismissViewControllerAnimated:YES completion:nil];
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        [self jingGaoKuang:item1 message:[dic objectForKey:@"Item2"]];
    } error:^(NSError *error) {
        
    }];
    
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
    [self presentViewController:action animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
