//
//  FuWuXiangqingVC.m
//  Recycle
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FuWuXiangqingVC.h"
#import "VipQuanXianModel.h"
@interface FuWuXiangqingVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView* tableView;
@property(nonatomic,retain)NSArray * keyArr;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation FuWuXiangqingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohang];
    NSLog(@"number>>%lu",_number);
    _keyArr=@[@"GetHugebusiness",@"GetViolentVoice",@"GetPrivatesecretary"];
    _dataArray=[NSMutableArray new];
    [self tableViewData];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=COLOR;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView=[self headView];
    
    
}
//海量商机就调用这个接口
-(void)tableViewData{
    [Engine haiLiangShangJiVipClass:@"14" Key:_keyArr[_number] success:^(NSDictionary *dic) {
        if ([dic objectForKey:@"Item3"]==[NSNull null])
        {
            return ;
        }else{
            NSArray * arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in arr)
            {
                VipQuanXianModel * model =[[VipQuanXianModel alloc]initWithHaiLiangShangJiDic:dicc];
                [_dataArray addObject:model];
            }
           
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * label1 =[UILabel new];
        UILabel * label2=[UILabel new];
        label1.tag=1;
        label2.tag=2;
        [cell sd_addSubviews:@[label1,label2]];
    }
    VipQuanXianModel * model=_dataArray[indexPath.row];
    
    UILabel * label1 =[cell viewWithTag:1];
    UILabel * label2=[cell viewWithTag:2];
    label1.font=[UIFont systemFontOfSize:15];
    label2.font=[UIFont systemFontOfSize:15];
    label1.textAlignment=1;
    label2.textAlignment=0;
    label1.text=[NSString stringWithFormat:@"%@:",model.titleName];
    label2.text=model.valueName;
    label1.sd_layout
    .leftSpaceToView(cell,6)
    .topSpaceToView(cell,0)
    .bottomSpaceToView(cell,0);
    [label1 setSingleLineAutoResizeWithMaxWidth:KUAN-100];
    
    label2.sd_layout
    .leftSpaceToView(label1,5)
    .topSpaceToView(cell,0)
    .bottomSpaceToView(cell,0);
    [label2 setSingleLineAutoResizeWithMaxWidth:KUAN-100];
    
    
    
    
    return cell;
}
-(UIView*)headView{
    UIView * headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 200)];
    UIImageView * bgview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 160)];
    NSString * ss =[NSString stringWithFormat:@"fuwu%ld",(long)_number];
    bgview.image=[UIImage imageNamed:ss];
    [headView addSubview:bgview];
   UILabel * fuwuJianJie =[UILabel new];
    fuwuJianJie.text=@"   服务简介";
    fuwuJianJie.font=[UIFont systemFontOfSize:15];
    [headView sd_addSubviews:@[fuwuJianJie]];
    fuwuJianJie.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(bgview,0)
    .heightIs(40);
    
    
    return headView;
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
-(void)daohang{
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"升级权限"];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    
}
@end
