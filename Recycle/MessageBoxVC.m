//
//  MessageBoxVC.m
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MessageBoxVC.h"
#import "LiuYanTiXingTableView.h"
@interface MessageBoxVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView* tableView;
@property(nonatomic,retain)NSMutableArray*labelArray;
@property(nonatomic,retain)NSMutableArray*imageArray;

@end

@implementation MessageBoxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"消息盒子"];
    _labelArray=[[NSMutableArray alloc]initWithObjects:@"申请通知",@"审核通知",@"会员提醒",@"留言提醒", nil];
    _imageArray=[[NSMutableArray alloc]initWithObjects:@"my_mes_apply",@"my_mes_audit",@"my_mes_remind",@"my_mes_leave", nil];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled=NO;
    _tableView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    [self.view addSubview:_tableView];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return _labelArray.count;
    }else
    {
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * label =[UILabel new];
        label.frame=CGRectMake(64, 2, 160, 40);
        label.tag=2;
        UIImageView * image1 =[[UIImageView alloc]init];
        image1.tag=1;
        [cell addSubview:image1];
        [cell addSubview:label];
    }
    UILabel * labe =[cell viewWithTag:2];
    labe.font=[UIFont systemFontOfSize:15];
    UIImageView * image1 =[cell viewWithTag:1];
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            labe.text=@"申请通知";
            image1.image=[UIImage imageNamed:@"my_mes_apply"];
            image1.frame=CGRectMake(20, 10, 25, 16);
        }else if (indexPath.row==1){
            labe.text=@"审核通知";
            image1.image=[UIImage imageNamed:@"my_mes_audit"];
            image1.frame=CGRectMake(20, 10, 24, 24);
        }else if (indexPath.row==2){
             labe.text=@"会员提醒";
            image1.image=[UIImage imageNamed:@"my_mes_remind"];
            image1.frame=CGRectMake(20, 13,17, 26);
        }else{
             labe.text=@"留言提醒";
            image1.image=[UIImage imageNamed:@"my_mes_leave"];
            image1.frame=CGRectMake(18, 10,55/2, 42/2);
        }
        
        
        
    }else{
        labe.text=@"回收商活动";
        image1.image=[UIImage imageNamed:@"my_mes_activity"];
        image1.frame=CGRectMake(20, 10, 24, 24);
    }
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0)
    {
        if (indexPath.row==3)
        {
            //留言提醒
            LiuYanTiXingTableView * vc =[LiuYanTiXingTableView new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else{
        return 15;
    }
}
-(void)backWrite{
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
