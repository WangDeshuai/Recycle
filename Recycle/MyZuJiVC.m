//
//  MyZuJiVC.m
//  Recycle
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyZuJiVC.h"
#import "MyInformationCell.h"
#import "XiangXiVC1.h"
#import "PaiMaiVC.h"
#import "MyZuJi.h"//记录浏览历史的
#import "ZJDao.h"//记录浏览历史的
@interface MyZuJiVC ()<UITableViewDelegate,UITableViewDataSource>
{
    ZJDao * dao;
}
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)UITableView * tableView;
@end

@implementation MyZuJiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self daohang];
    // Do any additional setup after loading the view.
    
   
    _dataArray=[NSMutableArray new];
     dao = [[ZJDao alloc]init];
    [dao connectSqlite];
   
    [self zhengLiData];
   
    [self CreatTableView];
   
}

-(void)zhengLiData{
    NSMutableArray * dataArr=nil;
    NSMutableArray * dataArr1=nil;
    NSMutableArray * dataArr2=nil;
    NSMutableArray * dataArr3=nil;
     [dataArr removeAllObjects];
     [dataArr1 removeAllObjects];
     [dataArr2 removeAllObjects];
     [dataArr3 removeAllObjects];
    dataArr =[dao searchWhoPeople:[self timeAgo:0]];
    dataArr1 =[dao searchWhoPeople:[self timeAgo:1]];
    dataArr2 =[dao searchWhoPeople:[self timeAgo:2]];
    dataArr3 =[dao searchWhoPeople:[self timeAgo:3]];
    [self addObjectArr:dataArr];
    [self addObjectArr:dataArr1];
    [self addObjectArr:dataArr2];
    [self addObjectArr:dataArr3];
    
}

-(void)addObjectArr:(NSMutableArray*)arr{
    
    if (arr==nil || arr.count==0) {
        
    }else{
       
         [_dataArray addObject:arr];
    }
   // NSLog(@"看看数组个数%lu",_dataArray.count);
}
-(NSString*)timeAgo:(int)i{
    NSDate *date = [NSDate date];//给定的时间
    int time = -24*i * 60 *60;
    NSDate *lastDay = [NSDate dateWithTimeInterval:time sinceDate:date];//前一天
   // NSDate *nextDat = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];//后一天
    NSDateFormatter *webformatter = [[NSDateFormatter alloc] init];
    [webformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *str = [webformatter stringFromDate:lastDay];
  //  NSLog(@"str -- %@",str);
    return str;
}
-(void)CreatTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    NSMutableArray * arr =_dataArray[section];
    return arr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyInformationCell* cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[MyInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
   NSMutableArray * arr =_dataArray[indexPath.section];
    NSEnumerator *enumerator = [arr reverseObjectEnumerator];
    arr =[[NSMutableArray alloc]initWithArray: [enumerator allObjects]];
    cell.zujiModel=arr[indexPath.row];
   
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray * array =_dataArray[indexPath.section];
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    array =[[NSMutableArray alloc]initWithArray: [enumerator allObjects]];
    MyZuJi * p =array[indexPath.row];
    if([p.gongqiu isEqualToString:@"3"]){
        PaiMaiVC * vcc =[PaiMaiVC new];
        vcc.messageID=p.messageid;
        [self.navigationController pushViewController:vcc animated:YES];
        return;
    }else{
        XiangXiVC1 * vc =[XiangXiVC1 new];
        vc.number=[p.gongqiu intValue];
        vc.messageID=p.messageid;
        [self.navigationController pushViewController:vc animated:YES];
    }
        
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 35;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSMutableArray * array =_dataArray[section];
    MyZuJi * p =array[0];
    UILabel * label =[UILabel new];
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment=1;
    label.text=[NSString stringWithFormat:@"-------%@-------",p.timell];
    label.backgroundColor=COLOR;
    
    return label;
}
-(void)bianji:(UIButton*)btn
{
    btn.selected=!btn.selected;
    _tableView.editing = !_tableView.editing;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray * array =_dataArray[indexPath.section];
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    array =[[NSMutableArray alloc]initWithArray: [enumerator allObjects]];
    MyZuJi * p =array[indexPath.row];
    [dao deleteWithPeople:p];
    [_dataArray removeAllObjects];
    [self zhengLiData];
    [_tableView reloadData];
   
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
    [self.navigationItem setTitle:@"我的足迹"];
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


}
-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
