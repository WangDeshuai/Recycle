//
//  Information publishVC.m
//  Recycle
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Information publishVC.h"
#import "MyWeiZhi.h"//供应求购
#import "ZiChanFaBuVC.h"//资产发布
#import "PaiMaiPublicVC.h"//拍卖发布
#import "MyPublicVC.h"//我的发布
@interface Information_publishVC ()
@property(nonatomic,retain)NSMutableArray * buttonArr;
@end

@implementation Information_publishVC
-(void)viewWillAppear:(BOOL)animated
{
    
  [self fiveBtn];
}
-(void)viewWillDisappear:(BOOL)animated
{
    for (int i = 0; i<_buttonArr.count; i++) {
        UIButton * btn =_buttonArr[i];
        [btn removeFromSuperview];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
     [self.navigationItem setTitle:@"信息发布"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我的发布" style:UIBarButtonItemStylePlain target:self action:@selector(publish)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    _buttonArr=[NSMutableArray new];

    [self imageTupian];
    
    
}
-(void)imageTupian
{
    UIImageView * image1 =[UIImageView new];
    image1.frame=CGRectMake(KUAN/2-219/4, 80, 219/2, 105/2);
    image1.image=[UIImage imageNamed:@"随时随地"];
    [self.view addSubview:image1];
    
}



-(void)fiveBtn
{
    
 
        //大小
        CGFloat a =74;
        CGFloat b =92;
        //间隔
        CGFloat x =(KUAN-a*3)/4;
        CGFloat y =30;
        CGFloat g =200*GAO/667;
        for (int i =0 ; i<5; i++) {
            CGFloat c =i%3;
            CGFloat d =i/3;
            
            UIButton * btn;
            if (btn==nil) {
                btn =[UIButton buttonWithType:UIButtonTypeCustom];
            }
            //UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
            NSString * aa =[NSString stringWithFormat:@"信息发布%d",i];
            [btn setBackgroundImage:[UIImage imageNamed:aa] forState:0];
           
            btn.transform = CGAffineTransformMakeTranslation(0, 300);
            //usingSpringWithDamping的范围为 0.0f 到 1.0f ，数值越小「弹簧」的振动效果越明显。
            //initialSpringVelocity 则表示初始的速度，数值越大一开始移动越快，值得注意的是，初始速度取值较高而时间较短时，也会出现反弹情况
            [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:3 options:UIViewAnimationOptionCurveLinear animations:^{
                btn.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
            }];

             btn.frame=CGRectMake(x+(a+x)*c, g+(y+b)*d, a, b);
            btn.tag=i;
//            [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:0];
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn addTarget:self action:@selector(buttonClink:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonArr addObject:btn];
            [self.view addSubview:btn];
            
        }
  
    
    
    
    
    
}

-(void)buttonClink:(UIButton*)btn{
    if (![LoginModel isLogin]){
        LoginVC * vc = [LoginVC new];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    if (btn.tag==0) {
        MyWeiZhi * mvc =[MyWeiZhi new];
         mvc.titleName=@"供应信息发布";
         mvc.typee=@"1";
        mvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:mvc animated:YES];
    }else if (btn.tag==1){
        MyWeiZhi * gongying =[MyWeiZhi new];
        gongying.titleName=@"求购信息发布";
        gongying.typee=@"2";
         gongying.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:gongying animated:YES];
       
    }
    else if (btn.tag==2){
        ZiChanFaBuVC *vc =[ZiChanFaBuVC new];
          vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==3){
        PaiMaiPublicVC * paivc =[PaiMaiPublicVC new];
        paivc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:paivc animated:YES];

    }else
    {
        UIAlertController * alertView =[UIAlertController alertControllerWithTitle:@"是否拨打客服电话" message:@"4007079877" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [Engine tellPhone:@"4007079877"];
        }];
        UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
       [alertView addAction:action2];
       [alertView addAction:action1];
        [self presentViewController:alertView animated:YES completion:nil];
    }
    

     
     
     
    
    
}
-(void)publish
{
    if (![LoginModel isLogin]){
        LoginVC * vc = [LoginVC new];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    MyPublicVC * vc =[MyPublicVC new];
    [self.navigationController pushViewController:vc animated:YES];
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
