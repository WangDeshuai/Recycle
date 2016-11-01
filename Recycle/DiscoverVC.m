//
//  DiscoverVC.m
//  Recycle
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DiscoverVC.h"
#import "DiscoverCell.h"
#import "ZhouBianShangJiVC.h"
#import "MySubscriptionVC.h"
#import "ShenBianDianPuVC.h"
@interface DiscoverVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString * _youZhi;
}
@property(nonatomic,retain)UITableView * tableView;
@end

@implementation DiscoverVC
-(void)viewWillAppear:(BOOL)animated{
    _youZhi=[[NSUserDefaults standardUserDefaults]objectForKey:@"youzhima"];
    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"发现"];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else{
      return 2;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
   
    
    if (!cell) {
        cell=[[DiscoverCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if (indexPath.section==0) {
        cell.image1.image=[UIImage imageNamed:@"发现1"];
        cell.lab.text=@"我的订阅";
        cell.image2.image=[UIImage imageNamed:@"点"];
        NSLog(@"有没有数就%@",_youZhi);
        if (_youZhi) {
             cell.image2.hidden=NO;
        }else{
              cell.image2.hidden=YES;
        }
      
    }else{
        if (indexPath.row==0) {
        cell.image1.image=[UIImage imageNamed:@"发现2"];
        cell.lab.text=@"身边店铺";
        }else{
        cell.image1.image=[UIImage imageNamed:@"发现3"];
        cell.lab.text=@"周边商机";
        }
    }
    
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (![LoginModel isLogin]){
            LoginVC * vc = [LoginVC new];
            [self presentViewController:vc animated:YES completion:nil];
            return;
        }
        //我的订阅
        MySubscriptionVC * vc =[MySubscriptionVC new];
       
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (indexPath.row==0) {
            //身边店铺
            ShenBianDianPuVC * vc =[ShenBianDianPuVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //周边商机
            ZhouBianShangJiVC * vc =[ZhouBianShangJiVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 20;
    }else{
        return 30;
    }
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
