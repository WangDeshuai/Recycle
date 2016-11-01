//
//  BianJiVC.m
//  Recycle
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BianJiVC.h"
#import "MyInformationCell.h"
#import "ZYData.h"
#import "People.h"
@interface BianJiVC ()<UITableViewDataSource,UITableViewDelegate>
{
    ZYData * dao;
    NSInteger row;
}

@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)UIButton * lastBtn;
@property(nonatomic,retain)NSArray * dataArr;
@property(nonatomic,retain)NSMutableArray * btnArr;
@end

@implementation BianJiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"我的收藏"];
    _btnArr=[NSMutableArray new];
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
    [right setTitle:@"取消" forState:0];
    [right setTitleColor:[UIColor whiteColor] forState:0];
    [right addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:right];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
     _tableView.backgroundColor=COLOR;
     //[self.tableView setEditing:YES animated:YES];
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    [self shujuData];
    NSArray * aa =@[@"全选",@"删除"];
    for (int i = 0; i<2; i++) {
        UIButton * bttn =[UIButton buttonWithType:UIButtonTypeCustom];
        bttn.tag=i;
        [bttn addTarget:self action:@selector(buttonClink:) forControlEvents:UIControlEventTouchUpInside];
        bttn.frame=CGRectMake(0+(KUAN/2)*i, GAO-64-40, KUAN/2, 40);
        [bttn setTitle:aa[i] forState:0];
        if (i==0) {
            bttn.backgroundColor=[UIColor grayColor];
        }else{
            bttn.backgroundColor=[UIColor redColor];
        }
        [self.view addSubview:bttn];
    }
    
    
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
    MyInformationCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[MyInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UIButton * deleatBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        deleatBtn.center=CGPointMake(15, cell.center.y+10);
        deleatBtn.bounds=CGRectMake(0, 0, 20, 20);
        deleatBtn.tag=10;
      //  [_btnArr removeAllObjects];
        [_btnArr addObject:deleatBtn];
        
       [cell addSubview:deleatBtn];
        
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIButton * btn =(UIButton*)[cell viewWithTag:10];
    btn.tag=indexPath.row;
    [btn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:0];
    [btn setBackgroundImage:[UIImage imageNamed:@"seledeleat"] forState:UIControlStateSelected];
    
    _lastBtn=btn;
    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    
    People * p =_dataArr[indexPath.row];
    cell.pp=p;
    
    return cell;
}
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
//}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//      //  [_dataSourceArray removeObject:_dataSourceArray[indexPath.row]];
//       // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }else if (editingStyle == UITableViewCellEditingStyleInsert){
//        
//    }
//}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

-(void)btn:(UIButton*)btn
{
    UIButton * bb =_btnArr[btn.tag];
    _lastBtn.selected=NO;
    //bb.selected=YES;
    bb.selected=!bb.selected;
    _lastBtn=btn;
   
    row=btn.tag;

    
    
}
-(void)buttonClink:(UIButton*)btn{
   //  NSLog(@">>%ld",(long)row);
    if(btn.tag==0){
//        //全选
//        for (UIButton * btn in _btnArr) {
//            btn.selected=YES;
//        }
        
    }else{
        //删除
        if (_dataArr==nil || _dataArr.count==0) {
            [WINDOW showHUDWithText:@"没有数据" Type:ShowPhotoNo Enabled:
             YES];
            return;
        }
        
        People * p =_dataArr[row];
        //删除数据之后再把这数据源 数组重新赋值一次
        [dao deleteWithPeople:p];
        _dataArr = [dao searchAllPeople];
        [_tableView reloadData];
    }
    
}
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//
//    return UITableViewCellEditingStyleDelete;
//}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//
//    
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
