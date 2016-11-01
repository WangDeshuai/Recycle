//
//  MyInformation.m
//  Recycle
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyInformation.h"
#import "MyInformationCell.h"
#import "BianJiVC.h"
#import "ZYData.h"
#import "People.h"
#import "XiangXiVC1.h"
#import "PaiMaiVC.h"

@interface MyInformation ()<UITableViewDataSource,UITableViewDelegate>
{
    ZYData * dao;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSArray * dataArr;
@end

@implementation MyInformation
-(void)viewWillAppear:(BOOL)animated{
//    _dataArr = [dao searchAllPeople];
//    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"我的收藏"];
    //左按钮
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    //右按钮
    UIButton * right =[UIButton  buttonWithType:UIButtonTypeCustom];
    right.frame=CGRectMake(KUAN-30, 7, 50, 30);
    right.titleLabel.font=[UIFont systemFontOfSize:15];
    [right setTitle:@"编辑" forState:0];
    [right setTitle:@"完成" forState:UIControlStateSelected];
    [right setTitleColor:[UIColor whiteColor] forState:0];
    [right addTarget:self action:@selector(bianji:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:right];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=COLOR;
     _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
      [self shujuData];
    
}
-(void)shujuData{
    dao = [[ZYData alloc]init];
    [dao connectSqlite];
    _dataArr = [dao searchAllPeople];
      // NSLog(@"查询出来%@",p.titleName);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInformationCell* cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[MyInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    People * p =_dataArr[indexPath.row];
    cell.pp=p;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    People * p =_dataArr[indexPath.row];
    NSInteger  nmber ;
    if ([p.gongQiu isEqualToString:@"供求"]) {
        nmber=0;
    }else if ([p.gongQiu isEqualToString:@"供应"]){
        nmber=1;
    }else if ([p.gongQiu isEqualToString:@"拍卖"]){
        PaiMaiVC * vcc =[PaiMaiVC new];
        vcc.messageID=p.messID;
        [self.navigationController pushViewController:vcc animated:YES];
        return;
    }
    else{
        nmber=2;
    }
    
    XiangXiVC1 * vc =[XiangXiVC1 new];
    vc.number=nmber;
    vc.messageID=p.messID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)bianji:(UIButton*)btn
{
    btn.selected=!btn.selected;
    _tableView.editing = !_tableView.editing;
//    BianJiVC * vc =[BianJiVC new];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    People * p =_dataArr[indexPath.row];
    //删除数据之后再把这数据源 数组重新赋值一次
    [dao deleteWithPeople:p];
    _dataArr = [dao searchAllPeople];
    [_tableView reloadData];
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
