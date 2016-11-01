//
//  MyAddressVC.m
//  Recycle
//
//  Created by Macx on 16/6/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyAddressVC.h"
#import "ProvinceModel.h"
#import "LeftMyAdressCell.h"
#import "RightMyAddressCell.h"
#import "CityData.h"//存储城市
#import "CityPeople.h"//存储城市
@interface MyAddressVC ()<UITableViewDelegate,UITableViewDataSource>
{
     CityData * cdao;
}
@property(nonatomic,retain)UITableView*leftTabelView;
@property(nonatomic,retain)UITableView*rightTabelView;
@property(nonatomic,retain)NSMutableArray * shengArr;
@property(nonatomic,retain)NSMutableArray * cityArr;
@end

@implementation MyAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self danghang];
    // Do any additional setup after loading the view.
    cdao =[[CityData alloc]init];
    [cdao connectSqlite];
    [self CreatLeftTableVeiw];
    [self shengShuJuData];
}
-(void)CreatLeftTableVeiw{
    _leftTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN/2.5, GAO-64) style:UITableViewStylePlain];
    _leftTabelView.dataSource=self;
    _leftTabelView.delegate=self;
    _leftTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _shengArr=[NSMutableArray new];
     _cityArr=[NSMutableArray new];
    [self.view addSubview:_leftTabelView];
    
}
-(void)CreatRightTableView{
    if (_rightTabelView==nil) {
        _rightTabelView=[[UITableView alloc]initWithFrame:CGRectMake(KUAN/2.5, 0,KUAN-KUAN/2.5, GAO-64) style:UITableViewStylePlain];
    }
    _rightTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _rightTabelView.dataSource=self;
    _rightTabelView.delegate=self;
    [self.view addSubview:_rightTabelView];
}
#pragma mark -- 数据库提取数据
-(void)shengShuJuData{
   
    [_shengArr removeAllObjects];
       _shengArr=[cdao shengFenChaXun];
    if (_shengArr.count!=0) {
        _isFirst=NO;
         [_leftTabelView reloadData];
    }else{
        _isFirst=YES;
        [Engine getAllProvincesuccess:^(NSDictionary *dic) {
            NSArray * array =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in array)
            {
                ProvinceModel* pmodel=[[ProvinceModel alloc]initWithDic:dicc];
                [_shengArr addObject:pmodel];
            }
            [_leftTabelView reloadData];
        } error:^(NSError *error) {
            
        }];
    }
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_leftTabelView) {
         return _shengArr.count;
    }else{
        return _cityArr.count;
    }
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =nil;
    

    if (tableView==_leftTabelView) {
        cell =[LeftMyAdressCell cellWithTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (_isFirst==YES) {
            ProvinceModel* pmodel=_shengArr[indexPath.row];
            cell.textLabel.text=pmodel.pName;
        }else{
            CityPeople * model =_shengArr[indexPath.row];
             cell.textLabel.text=model.pname;
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment=1;
    }else{
        cell =[RightMyAddressCell cellWithTableView:tableView];
       
        if (_isCity==YES) {
            ProvinceModel* pmodel=_cityArr[indexPath.row];
            cell.textLabel.text=pmodel.pName;

        }else{
            CityPeople * pmodel=_cityArr[indexPath.row];
            cell.textLabel.text=pmodel.pname;
        }
        cell.textLabel.font=[UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment=1;
    }
    

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==_leftTabelView) {
        [self CreatRightTableView];
        [_cityArr removeAllObjects];
        if (_isFirst==YES) {
            ProvinceModel* pmodel=_shengArr[indexPath.row];
            [self dataCity:pmodel.pCode indePathe:indexPath];
        }else{
             CityPeople * model =_shengArr[indexPath.row];
            [self dataCity:model.pcode indePathe:indexPath];
        }
       
        
      
    }else{
        if (_isCity==YES) {
            ProvinceModel* pmodel=_cityArr[indexPath.row];
            self.cityNameCodeBlock(pmodel.pName,pmodel.pID);
            //p.ID是s省份的code 也就是发布我的位置这是省份code
        }else{
              CityPeople * pmodel=_cityArr[indexPath.row];
            //这个psname就是对应的省的code
             self.cityNameCodeBlock(pmodel.pname,pmodel.psname);
        }
        
        
//        NSLog(@"输出的city是%@",pmodel.pName);
//        NSLog(@"输出的code是%@",pmodel.pCode);
      
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark --数据库提取数据
-(void)dataCity:(NSString*)modelcode indePathe:(NSIndexPath*)indexpath
{
    NSString * xuhao =[NSString stringWithFormat:@"c%lu",indexpath.row];
    //根据xuhao去查某个省的城市
   _cityArr =[cdao genJuPid:xuhao];
    if(_cityArr.count!=0){
        _isCity=NO;
        [_rightTabelView reloadData];
        
    }else{
        _isCity=YES;
        [Engine getCityCode:modelcode success:^(NSDictionary *dic) {
            NSArray * array =[dic objectForKey:@"Item3"];
            
            for (NSDictionary * dicc in array)
            {
                ProvinceModel* pmodel=[[ProvinceModel alloc]initWithCitydic:dicc];
                [_cityArr addObject:pmodel];
            }
            [_rightTabelView reloadData];
        } error:nil];
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
-(void)danghang{
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:@"我的位置"];
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
