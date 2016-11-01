//
//  MYViewController.m
//  Recycle
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MYViewController.h"
#import "MyTableViewCell.h"
#import "MyPublicVC.h"
#import "MyMessageVC.h"
#import "MyInformation.h"
#import "MessageBoxVC.h"
#import "MyStoreVC.h"
#import "VipQuanXianVC.h"
#import "MySubscriptionVC.h"
#import "MyZuJiVC.h"
#import "SuggestionFeedbackVC.h"
#import "MyaborteVC.h"
#import "SuoDingMessageVC.h"
@interface MYViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString* messageID;
    
}
@property(nonatomic,retain)UITableView * tableView;
@end

@implementation MYViewController
-(void)viewWillAppear:(BOOL)animated{
    
    messageID= [[NSUserDefaults standardUserDefaults] objectForKey:@"messageid"];
    if ([self isKong]) {
        [self getMessageData];
    }
        [_tableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"我"];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=COLOR;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
}
//判断是否是登录状态
-(BOOL)isKong{
    if(messageID==nil){
        NSLog(@"messageID=空");
      //  [_tableView reloadData];
        return NO;
    }
    return YES;
}
-(void)getMessageData
{
    [Engine getHuiYuanMessageUid:messageID success:^(NSDictionary *dic) {
       
        NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([ss isEqualToString:@"0"]) {
        NSLog(@"我的界面提示语:%@",[dic objectForKey:@"Item2"]);
            [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
        }else
         {
            LoginModel * md =[[LoginModel alloc]initWithDic:[dic objectForKey:@"Item3"]];
            _model=md;
        }
            [_tableView reloadData];
    } error:nil];


}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 4;
    }else{
        return 2;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
    
    MyTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if (indexPath.section==0) {
        if ([self isKong]) {
            cell.lab2.hidden=NO;
            cell.lab.text=_model.userName;
            cell.lab2.text=_model.companyName;
            CGFloat k =[Engine getWidthWithFontSize:14 height:20 string:_model.companyName];
            cell.lab2.frame=CGRectMake(125, 45, k, 34);
            cell.lab.frame=CGRectMake(125, 20, 100, 34);
            [cell.image1 sd_setImageWithURL:[NSURL URLWithString:_model.picUrl] placeholderImage:[UIImage imageNamed:@"头像占位图"]];
        }else{
            cell.lab.text=@"未登录";
            cell.lab2.hidden=YES;
            cell.lab.frame=CGRectMake(125, 35, 100, 34);
            cell.image1.image=[UIImage imageNamed:@"头像占位图"];
        }
      
        
        cell.image1.frame=CGRectMake(25, 25/2, 75, 75);
        cell.image1.layer.cornerRadius=75/2;
        cell.image1.clipsToBounds=YES;
        cell.image2.image=[UIImage imageNamed:@"上边按钮"];
        cell.image2.frame=CGRectMake(KUAN-25, (100-42/2)/2, 25/2, 42/2);
        
    }else if(indexPath.section==1){
        if (indexPath.row==0) {
            cell.lab.text=@"会员权限";
            cell.image1.image=[UIImage imageNamed:@"会员权限"];
        }else if (indexPath.row==1){
            cell.lab.text=@"我的订阅";
            cell.image1.image=[UIImage imageNamed:@"我的订阅"];
        }else if (indexPath.row==2){
            cell.lab.text=@"我的足迹";
            cell.image1.image=[UIImage imageNamed:@"我的足迹"];
        }else if (indexPath.row==3){
            cell.lab.text=@"锁定信息";
            cell.image1.image=[UIImage imageNamed:@"锁"];
        }
        
    }else{
        
        if (indexPath.row==0) {
            cell.lab.text=@"意见反馈";
            cell.image1.image=[UIImage imageNamed:@"意见反馈"];
        }else if (indexPath.row==1){
            cell.lab.text=@"关于回收商";
            cell.image1.image=[UIImage imageNamed:@"关于回收商"];
        }else if (indexPath.row==2){
//            cell.lab.text=@"检查更新";
//            cell.image1.image=[UIImage imageNamed:@"检查更新"];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        if ([LoginModel isLogin]) {
            //登录状态
            MyMessageVC *vc =[MyMessageVC new];
            vc.hidesBottomBarWhenPushed=YES;
            vc.model=_model;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //未登录
            LoginVC * vc = [LoginVC new];
            [self presentViewController:vc animated:YES completion:nil];
        }
        
        
    }else if (indexPath.section==1){
        
        if (![LoginModel isLogin]){
            LoginVC * vc = [LoginVC new];
            [self presentViewController:vc animated:YES completion:nil];
            return;
        }
        
        if (indexPath.row==0) {
            //会员权限
            VipQuanXianVC * vc =[VipQuanXianVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row==1){
            //我的订阅
            MySubscriptionVC * vc =[MySubscriptionVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==2){
            //我的足迹
            MyZuJiVC * vc =[MyZuJiVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            SuoDingMessageVC * vc =[SuoDingMessageVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else{
        
        if(indexPath.row==0){
            //意见反馈
            SuggestionFeedbackVC * vc =[SuggestionFeedbackVC new];
             vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //关于回收商
            MyaborteVC * vc =[MyaborteVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
          //检查更新
        }
        
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else if (section==1){
        return 0;
        
    }else{
        if (KUAN==320&&GAO==480) {
            return 15;
        }else{
          return 15;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 100*GAO/667;
    }else if (section==1){
        return 0;
        
    }else{
        return 0;
    }
}
//4个按钮
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
   
    UIView * bgview =[UIView new];
    bgview.backgroundColor=COLOR;
   // CGFloat k =(KUAN-15*5)/4;
    CGFloat k = 75*KUAN/375;
    CGFloat jiange = (KUAN -k*4)/5;
    for (int i =0; i<4; i++) {
         UIButton * btn;
        if (btn==nil) {
            btn =[UIButton buttonWithType:UIButtonTypeCustom];
        }
        btn.tag=i;
        NSString * ss =[NSString stringWithFormat:@"消息盒子%d",i];
        [btn setBackgroundImage:[UIImage imageNamed:ss] forState:0];
        btn.frame=CGRectMake(jiange+(jiange+k)*i, 7, k,k);
       
        [btn addTarget:self action:@selector(foveBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:btn];
    
    }
    
    if (section==0) {
        return bgview;
    }
    else{
        return nil;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100 ;
    }else{
        return 44;
    }
}

-(void)foveBtn:(UIButton*)btn
{
    if (![LoginModel isLogin]){
        LoginVC * vc = [LoginVC new];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    if(btn.tag==0){
        MyInformation * vc =[MyInformation new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
   else if (btn.tag==1) {
        MyPublicVC * vcp =[MyPublicVC new];
        vcp.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vcp animated:YES];
   }else if (btn.tag==2){
       
       MessageBoxVC *vc =[MessageBoxVC new];
       vc.hidesBottomBarWhenPushed=YES;
      [self.navigationController pushViewController:vc animated:YES];
   }else if(btn.tag==3){
       
       if ([self isKong]) {
           MyStoreVC *vc =[MyStoreVC new];
           vc.messageID=messageID;
           vc.hidesBottomBarWhenPushed=YES;
           [self.navigationController pushViewController:vc animated:YES];
       }else{
           NSLog(@"没有登录，请登录查看");
       }
       
      

   }
    
}
//-(void)btnClink{
//    
//    LoginVC * vc = [LoginVC new];
//    [self presentViewController:vc animated:YES completion:nil];
//}
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
