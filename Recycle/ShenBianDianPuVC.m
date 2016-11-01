//
//  ShenBianDianPuVC.m
//  Recycle
//
//  Created by Macx on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShenBianDianPuVC.h"
#import "ShenBianDianPuCell.h"
#import "ZaiXiangxiVC.h"
#import "ShenBianDianPuModel.h"
@interface ShenBianDianPuVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray*dataArray;
@end

@implementation ShenBianDianPuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self daohangtiao];
    _dataArray=[NSMutableArray new];
    // Do any additional setup after loading the view.
    [self CreatTableView];
    [self jieXiShenBianData];
}
-(void)CreatTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.backgroundColor=COLOR;
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
}
-(void)jieXiShenBianData{
    NSString * code =[[NSUserDefaults standardUserDefaults]objectForKey:@"citycode"];
    
    [Engine getShenBianDianPuCityCode:code success:^(NSDictionary *dic) {
        
        NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([ss isEqualToString:@"1"])
        {
            NSArray * item3 =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in  item3)
            {
                ShenBianDianPuModel * md =[[ShenBianDianPuModel alloc]initWithShenBianDic:dicc];
                [_dataArray addObject:md];
            }
            [_tableView reloadData];
        }else{
            
            NSLog(@"%@",[dic objectForKey:@"Item2"]);
            
        }
        
        
    } error:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * idd =@"Cell";
    ShenBianDianPuCell* cell =[tableView dequeueReusableCellWithIdentifier:idd];
    if (!cell) {
        cell=[[ShenBianDianPuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
    }
    ShenBianDianPuModel * md =_dataArray[indexPath.row];
    cell.model=md;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShenBianDianPuModel * md =_dataArray[indexPath.row];
    ZaiXiangxiVC * vc =[ZaiXiangxiVC new];
    vc.yonghuID=md.yongHuID;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
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
-(void)daohangtiao{
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
  
    NSString* name=[[NSUserDefaults standardUserDefaults]objectForKey:@"cityname"];
    [self.navigationItem setTitle:name];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    UIButton * backBtn2 =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn2.frame=CGRectMake(5,27, 32/2, 40/2);
    [backBtn2 setBackgroundImage:[UIImage imageNamed:@"dinwei"] forState:0];
     UIBarButtonItem * leftBtn2 =[[UIBarButtonItem alloc]initWithCustomView:backBtn2];
    
    self.navigationItem.leftBarButtonItems=@[leftBtn,leftBtn2,leftBtn2,leftBtn2,leftBtn2,leftBtn2,leftBtn2];
    
    
    
}
-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
