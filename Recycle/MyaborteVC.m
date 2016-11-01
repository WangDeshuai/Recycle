//
//  MyaborteVC.m
//  Recycle
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyaborteVC.h"

@interface MyaborteVC ()
{
    UIImageView * logoImage;
    UILabel * label;
}
@end

@implementation MyaborteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"关于"];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    [self huishoushang];
}

-(void)huishoushang
{
    logoImage =[UIImageView new];
    logoImage.image=[UIImage imageNamed:@"回收商"];
    label =[UILabel new];
    label.text=@"回收商网";
    label.font=[UIFont systemFontOfSize:15];
    UILabel * lab =[UILabel new];
    lab.alpha=.7;
    lab.font=[UIFont systemFontOfSize:15];
    lab.text=@"    中国回收商网是石家庄正和网络有限公司（原石家庄正和企业管理有限公司）旗下网站，公司是一家专业从事计算机信息技术领域研发、应用和服务的高新技术企业，专业提供网站运营,网站建设,网站优化,网站推广等服务，致力于为中国从事再生资源回收利用的企业提供全方位、多角度、网络信息和线下服务与一体的一站式服务。";
   
    
    UILabel * lab3 =[UILabel new];
    lab3.textAlignment=1;
    lab3.text=@"Copyright © 2008 HuiShouShang.Com Inc.All Rights Reserved";
    lab3.alpha=.7;
    lab3.adjustsFontSizeToFitWidth=YES;
    lab3.font=[UIFont systemFontOfSize:12];
    
    UILabel * lab2 =[UILabel new];
    lab2.textAlignment=1;
    lab2.text=@"版本：2.6.13";
    
    [self.view sd_addSubviews:@[logoImage,label,lab,lab3,lab2]];
    
    logoImage.sd_layout
    .topSpaceToView(self.view,20)
    .centerXEqualToView(self.view)
    .widthIs(87)
    .heightIs(87);
    
    label.sd_layout
    .topSpaceToView(logoImage,10)
    .centerXEqualToView(self.view)
    .heightIs(30);
    [label setSingleLineAutoResizeWithMaxWidth:120];
    
    lab.sd_layout
    .topSpaceToView(label,10)
    .leftSpaceToView(self.view,20)
    .rightSpaceToView(self.view,20)
    .autoHeightRatio(0);
    
    lab3.sd_layout
    .bottomSpaceToView(self.view,40)
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(self.view,15)
    .heightIs(10);
    
    lab2.sd_layout
    .bottomSpaceToView(lab3,20)
    .centerXEqualToView(self.view)
    .heightIs(30);
    [lab2 setSingleLineAutoResizeWithMaxWidth:120];
    
}
-(void)backWrite
{
    [self.navigationController popViewControllerAnimated:YES];
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
