//
//  LiuYanVC.m
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LiuYanVC.h"

@interface LiuYanVC ()
{
    UITextField * phoneNumber;
    UITextField * commberName;
    UITextView *liuyanName;
}
@end

@implementation LiuYanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:@"在线留言"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    UIImageView * view1 =[UIImageView new];
    view1.userInteractionEnabled=YES;
    view1.image=[UIImage imageNamed:@"留言信息"];
    
    UIButton * sendBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"留言的按钮"] forState:0];
    [sendBtn setTitle:@"发送" forState:0];
    [sendBtn addTarget:self action:@selector(sendbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[view1,sendBtn]];
    
    view1.sd_layout
    .topSpaceToView(self.view,40)
    .widthIs(584/2)
    .heightIs(580/2)
    .centerXEqualToView(self.view);
    
    sendBtn.sd_layout
    .topSpaceToView(view1,30)
    .centerXEqualToView(self.view)
    .widthIs(583/2)
    .heightIs(74/2);
    
    phoneNumber =[UITextField new];
    phoneNumber.placeholder=@"请填写11位有效手机号";
    phoneNumber.keyboardType=UIKeyboardTypeNumberPad;
   // phoneNumber.backgroundColor=[UIColor redColor];
    
    commberName =[UITextField new];
    commberName.placeholder=@"请输入您的公司名称";
    //commberName.backgroundColor=[UIColor redColor];
    
   liuyanName =[UITextView new];
    liuyanName.text=@"请输入您的想了解的信息";
   // liuyanName.backgroundColor=[UIColor redColor];
    
    phoneNumber.font=[UIFont systemFontOfSize:13];
    commberName.font=[UIFont systemFontOfSize:13];
    liuyanName.font=[UIFont systemFontOfSize:13];
    [view1 sd_addSubviews:@[phoneNumber,commberName,liuyanName]];
    
    phoneNumber.sd_layout
    .topSpaceToView(view1,12)
    .leftSpaceToView(view1,100)
    .rightSpaceToView(view1,5)
    .heightIs(30);
    
    commberName.sd_layout
    .topSpaceToView(phoneNumber,20)
    .leftEqualToView(phoneNumber)
    .rightEqualToView(phoneNumber)
    .heightRatioToView(phoneNumber,1);
    
    liuyanName.sd_layout
    .topSpaceToView(commberName,20)
    .leftEqualToView(commberName)
    .rightEqualToView(commberName)
    .heightIs(60);//高度改为自适应
    
    
}
//左按钮
-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
}
//发送
-(void)sendbtn
{
    
    NSString * phone= [self null:phoneNumber.text];
    NSString * commber=[self null:commberName.text];
    NSString *liuyan=[self null:liuyanName.text];
   
    UIAlertController * alerview = nil;
    if (alerview==nil) {
         alerview =[UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    }
  
    UIAlertAction *aaa =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
   
    
    if(phone==nil || commber==nil ||liuyan==nil){
        alerview.message=@"请填写完信息在提交";
        [self presentViewController:alerview animated:YES completion:nil];
         [alerview addAction:aaa];
        
    }else{
        NSLog(@">>>>>%@,>>>>%@>>>>%@",phone,commber,liuyan);
        
        [self  liuyanDataLianxiRen:commber Phone:phone NeiRong:liuyan alerview:alerview aleraction:aaa];
        
    }
    
    
    
}


-(void)liuyanDataLianxiRen:(NSString*)name Phone:(NSString*)phoneNumber1 NeiRong:(NSString*)content1 alerview:(UIAlertController*)aa  aleraction:(UIAlertAction*)b{
    aa.message=@"请稍后,正在提交";
    [self presentViewController:aa animated:YES completion:nil];
    
    NSString * ss =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    NSString * uidd;
    if (ss==nil) {
        //说明没有登录
        uidd=@"0";
    }else{
        uidd=ss;
    }
    
    [Engine getLiuYanxxid:_messageID contact:name handtel:phoneNumber1 content:content1 type:_typee uid:uidd  ruid:@"0" success:^(NSDictionary *dic) {
        
        NSString * Item =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([Item isEqualToString:@"0"]) {
            aa.message=[dic objectForKey:@"Item2"];
        }else{
            aa.message=[dic objectForKey:@"Item2"];
        }
          [aa addAction:b];
    } error:nil];
}

-(NSString*)null:(NSString*)aaa{
    if ([aaa isEqualToString:@""]) {
        return nil;
    }else{
        return aaa;
    }
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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

@end
