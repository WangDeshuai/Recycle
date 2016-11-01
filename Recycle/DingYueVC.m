//
//  DingYueVC.m
//  Recycle
//
//  Created by Macx on 16/6/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DingYueVC.h"
#import "DingYueXiangXiVC.h"
@interface DingYueVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArr;
@property(nonatomic,retain)NSMutableArray * imageArr;
@end

@implementation DingYueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self danghang];
    _dataArr=[[NSMutableArray alloc]initWithObjects:@"供应",@"求购",@"资产",@"拍卖", nil];
    _imageArr=[[NSMutableArray alloc]initWithObjects:@"订阅0",@"订阅1",@"订阅2",@"订阅3", nil];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view  addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text=_dataArr[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:_imageArr[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"选择信息类型";
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DingYueXiangXiVC * vc =[DingYueXiangXiVC new];
    vc.titleName=_dataArr[indexPath.row];
    vc.type=indexPath.row+1;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)backWrite
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)danghang{
   self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"订阅"];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
}

@end
