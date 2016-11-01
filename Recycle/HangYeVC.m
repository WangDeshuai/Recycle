//
//  HangYeVC.m
//  Recycle
//
//  Created by Macx on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HangYeVC.h"
#import "LeftMyAdressCell.h"
#import "RightMyAddressCell.h"
#import "HangYeClassModel.h"
#import "HangYeCell.h"
#import "HYData.h"//存储行业
#import "HYPeople.h"//存储行业
@interface HangYeVC ()<UITableViewDelegate,UITableViewDataSource>
{
        HYData * hdao;
}
@property(nonatomic,retain)UITableView*leftTabelView;
@property(nonatomic,retain)UITableView*rightTabelView;
@property(nonatomic,retain)UITableView*mainTabelView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * erJiArray;
@property(nonatomic,retain)NSMutableArray * thiredArray;

@end

@implementation HangYeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self danghang];
    _dataArray=[NSMutableArray new];
    _erJiArray=[NSMutableArray new];
    _thiredArray=[NSMutableArray new];
    hdao=[[HYData alloc]init];
    [hdao connectSqlite];
    // Do any additional setup after loading the view.
    [self CreatLeftTableVeiw];
    [self shengShuJuData];
}
-(void)CreatLeftTableVeiw{
    _leftTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN/2.5, GAO-64) style:UITableViewStylePlain];
    _leftTabelView.dataSource=self;
    _leftTabelView.delegate=self;
    _leftTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
  
    [self.view addSubview:_leftTabelView];
    
}
-(void)CreatRightTableView{
    _rightTabelView=nil;
    if (_rightTabelView==nil) {
        _rightTabelView=[[UITableView alloc]initWithFrame:CGRectMake(KUAN/2.5, 0,KUAN- KUAN/2.5, GAO-64) style:UITableViewStylePlain];
    }
    _rightTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _rightTabelView.dataSource=self;
    _rightTabelView.delegate=self;
    [self.view addSubview:_rightTabelView];
}
-(void)CreatMainTableView{
    
//    _mainTabelView=nil;
//    if (_mainTabelView==nil) {
//        _mainTabelView=[[UITableView alloc]initWithFrame:CGRectMake(KUAN/1.5, 0,KUAN/3, GAO-64) style:UITableViewStylePlain];
//    }
//    _mainTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    _mainTabelView.dataSource=self;
//    _mainTabelView.delegate=self;
//    [self.view addSubview:_mainTabelView];
    
    
    
}
//一级菜单数据解析
#pragma mark -- 数据库提取leftTableView数据源
-(void)shengShuJuData{
    
    [_dataArray removeAllObjects];
    _dataArray=[hdao LookTableViewLeft];
    if (_dataArray.count!=0) {//不等于0说明数据库有内容
        _isFirst=NO;
        NSLog(@"从数据库提取的");
      [_leftTabelView reloadData];
        
    }else{
        _isFirst=YES;
        [Engine getGongQiuFenLeiClass:nil success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"]) {
                NSArray * item3 =[dic objectForKey:@"Item3"];
                for (NSDictionary * dicc in item3) {
                    HangYeClassModel * model =[[HangYeClassModel alloc]initWithOneDic:dicc];
                    [_dataArray addObject:model];
                }
                
            }else{
                
            }
            [_leftTabelView reloadData];
        } error:nil];
    }
    
   
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_leftTabelView) {
        return _dataArray.count;
    }else {
        return _erJiArray.count;
    }
}
#pragma mark --表的展示
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =nil;
    
    
    if (tableView==_leftTabelView) {
        cell =[LeftMyAdressCell cellWithTableView:tableView];
       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (_isFirst==YES) {
            HangYeClassModel * md =_dataArray[indexPath.row];
            cell.textLabel.text=md.titleName;
        }else
        {
            HYPeople * md =_dataArray[indexPath.row];
            cell.textLabel.text=md.namehy;
        }
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        cell.textLabel.textAlignment=0;
    }else {
        cell =[RightMyAddressCell cellWithTableView:tableView];
        if (_isCity==YES) {
            HangYeClassModel * md =_erJiArray[indexPath.row];
            cell.textLabel.text=md.titleName;
        }else{
             HYPeople * md=_erJiArray[indexPath.row];
             cell.textLabel.text=md.namehy;
        }
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        cell.textLabel.textAlignment=0;
    }

    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==_leftTabelView) {
        [_mainTabelView removeFromSuperview];
        [self CreatRightTableView];
         [_erJiArray removeAllObjects];
        if (_isFirst==YES) {
            HangYeClassModel * md =_dataArray[indexPath.row];
            [self erJiFenLei:md.pinYin indexPathe:indexPath];
        }else{
             HYPeople * md =_dataArray[indexPath.row];
             [self erJiFenLei:md.pinyin indexPathe:indexPath];
        }
       
        
    }else if(tableView==_rightTabelView){
        [self CreatMainTableView];
        if (_isCity==YES) {
            HangYeClassModel * md =_erJiArray[indexPath.row];
            self.hangYeNameCidBlock(md.titleName,md.cid);
        }else{
            HYPeople * md =_erJiArray[indexPath.row];
            self.hangYeNameCidBlock(md.namehy,md.ggcid);
        }
        [self.navigationController popViewControllerAnimated:YES];
      
    }
//    }else{
//         HangYeClassModel * mde =_thiredArray[indexPath.row];
//        self.hangYeNameCidBlock(mde.titleName,mde.cid);
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
}
#pragma mark -- 二级菜单数据源
//二级菜单数据解析
-(void)erJiFenLei:(NSString*)mdcode indexPathe:(NSIndexPath*)indexPath
{
    NSString * xuhao =[NSString stringWithFormat:@"hy%lu",indexPath.row];
    //根据xuhao去查某个省的城市
    _erJiArray =[hdao genJuPid:xuhao];
    if (_erJiArray.count!=0) {
        NSLog(@"二级菜单数据库");
        _isCity=NO;
        [_rightTabelView reloadData];
    }else{
         _isCity=YES;
        [Engine getGongQiuFenLeiClass:mdcode success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"]) {
                
                NSArray * item3 =[dic objectForKey:@"Item3"];
                for (NSDictionary * dicc in item3) {
                    HangYeClassModel * model =[[HangYeClassModel alloc]initWithTwoDic:dicc];
                    [_erJiArray addObject:model];
                }
            }else{
            }
            [_rightTabelView reloadData];
        } error:nil];
    }
    
    
    
}
////三级级菜单数据解析
//-(void)thiredData:(HangYeClassModel*)md{
//    [Engine getGongQiuFenLeiClass:md.pinYin success:^(NSDictionary *dic) {
//        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
//        if ([item1 isEqualToString:@"1"])
//        {
//            
//            if ([dic objectForKey:@"Item3"] ==[NSNull null])
//            {
//               
//            }else
//            {
//                NSArray * item3 =[dic objectForKey:@"Item3"];
//                for (NSDictionary * dicc in item3)
//                {
//                    HangYeClassModel * model =[[HangYeClassModel alloc]initWithThirdDic:dicc];
//                    [_thiredArray addObject:model];
//                }
//            }
//            
//        }
//        [_mainTabelView reloadData];
//    } error:nil];
//}
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
-(void)danghang{
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:@"所属行业"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems=@[leftBtn];
}
-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
