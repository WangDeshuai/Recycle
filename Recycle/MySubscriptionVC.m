//
//  MySubscriptionVC.m
//  Recycle
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MySubscriptionVC.h"
#import "DingYueVC.h"
#import "MySubscriptionCell.h"
#import "DingYueModel.h"
#import "ChaKanDingYueVC.h"
@interface MySubscriptionVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    BOOL            _flag[3];
    NSInteger inSecon;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * qiuGouArr;
@property(nonatomic,retain)NSMutableArray * gongYingArr;
@property(nonatomic,retain)NSMutableArray * ziChanArr;
@property(nonatomic,retain)NSMutableArray * paiMaiArr;
@property(nonatomic,retain)NSMutableArray * dataBigArr;
@end

@implementation MySubscriptionVC
-(void)viewWillAppear:(BOOL)animated{
    [self deleteAllArr];
    [self getDingYueData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"我的订阅"];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(KUAN-47,27, 37/2, 37/2);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"sub_add(1)"] forState:0];
    [rightBtn addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems=@[right];
    _gongYingArr=[NSMutableArray new];
    _qiuGouArr=[NSMutableArray new];
    _ziChanArr=[NSMutableArray new];
    _paiMaiArr=[NSMutableArray new];
    _dataBigArr=[NSMutableArray new];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _tableView.rowHeight=60;
    // 创建nib对象
    UINib * nib = [UINib nibWithNibName:@"MySubscriptionCell" bundle:[NSBundle mainBundle]];
     [_tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    [self.view  addSubview:_tableView];
    //[self getDingYueData];
}
-(void)getDingYueData{
    
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    [WINDOW showHUDWithText:@"数据加载中..." Type:ShowLoading Enabled:YES];
    [Engine getDingYueXinXiToken:token Type:@"0" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if([item1 isEqualToString:@"0"]){
            [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
        if ([dic objectForKey:@"Item3"]==[NSNull null]) {
            return;
        }
        NSArray * itm3 =[dic objectForKey:@"Item3"];
          [WINDOW showHUDWithText:@"加载成功" Type:ShowDismiss Enabled:YES];
        for (NSDictionary * dicc in itm3) {
          
        DingYueModel * dvc =[[DingYueModel alloc]initWithTitleDic:dicc];
            //NSLog(@">>>%@",dvc.sTypename);
            if ([dvc.sTypename isEqualToString:@"供应"]) {
                [_gongYingArr addObject:dvc];
            }
            if ([dvc.sTypename isEqualToString:@"求购"]){
                [_qiuGouArr addObject:dvc];
            }
            if ([dvc.sTypename isEqualToString:@"资产"]){
                [_ziChanArr addObject:dvc];
            }
            if ([dvc.sTypename isEqualToString:@"拍卖"]){
                [_paiMaiArr addObject:dvc];
            }
           
        }
        
        [self addBigArr];
        if (_gongYingArr.count==0) {
            
        }else{
            [[NSUserDefaults standardUserDefaults]setObject:@"youzhi" forKey:@"youzhima"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        [_tableView reloadData];
        
    } error:^(NSError *error) {
        [WINDOW showHUDWithText:@"网络超时" Type:ShowPhotoNo Enabled:YES];
    }];
}
-(void)addBigArr{
   // [_dataBigArr removeAllObjects];
    if (_gongYingArr.count!=0) {
        [_dataBigArr addObject:_gongYingArr];
    }
    if (_qiuGouArr.count!=0) {
       [_dataBigArr addObject:_qiuGouArr];
    }
    if (_ziChanArr.count!=0) {
      [_dataBigArr addObject:_ziChanArr];
    }
    if (_paiMaiArr.count!=0 ) {
      [_dataBigArr addObject:_paiMaiArr];
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataBigArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_flag[section]==NO)
    {
        return 0;
    }else{
        NSArray * arr =_dataBigArr[section];
        return arr.count;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MySubscriptionCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath ];
    inSecon=indexPath.section;
    NSArray * array =_dataBigArr[indexPath.section];
    DingYueModel * dvc =array[indexPath.row];
    cell.model=dvc;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell.deleteDingYue addTarget:self action:@selector(dingYueClink:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteDingYue.tag=indexPath.row;
    return cell;
}
-(void)dingYueClink:(UIButton*)btn{
      NSMutableArray * array =_dataBigArr[inSecon];
   
     DingYueModel * dvc =array[btn.tag];
    NSLog(@">>>%@",dvc.titleName);
    [self deleteData:dvc arr:array];
    
}
-(void)deleteData:(DingYueModel*)mesID arr:(NSMutableArray*)ar{
    NSString* token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    UIAlertController * alerview =[UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alerview addAction:action];
    [Engine getDeleteDingyueToken:token messageID:mesID.sid success:^(NSDictionary *dic) {
        NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([ss isEqualToString:@"1"]) {
            [ar removeObject:mesID];
            if (ar.count==0) {
                [_dataBigArr removeObject:ar];
                if (_dataBigArr.count==0 || _dataBigArr==nil) {
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"youzhima"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
            }
            [_tableView reloadData];
        }else{
            alerview.message=[dic objectForKey:@"Item2"];
        }
    } error:nil];
    
    
}


-(void)deleteAllArr{
    [_qiuGouArr removeAllObjects];
    [_gongYingArr removeAllObjects];
    [_ziChanArr removeAllObjects];
    [_paiMaiArr removeAllObjects];
    [_dataBigArr removeAllObjects];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChaKanDingYueVC * vc =[ChaKanDingYueVC new];
    NSArray * array =_dataBigArr[indexPath.section];
    DingYueModel * dvc =array[indexPath.row];
    vc.dyModel=dvc;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//设置区头按钮
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray * arr1 =_dataBigArr[section];
    DingYueModel * dvc =arr1[0];//随意取出一个，主要是获取titleName
    UIView * lineView =[UIView new];
    lineView.backgroundColor=[UIColor grayColor];
    lineView.alpha=.15;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    button.frame = CGRectMake(0, 0,KUAN, 40);
    [button setTitle:dvc.sTypename forState:0];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.tag = section;
    [button addTarget:self action:@selector(buttonClink:) forControlEvents:UIControlEventTouchUpInside];
    lineView.frame=CGRectMake(0, 38, KUAN, 1);
    [button addSubview:lineView];
    return button;
}
-(void)buttonClink:(UIButton*)button
{
      _flag[button.tag]=!_flag[button.tag];
    //索引集合
    //把区号放到索引集合中,NSIndexSet代表索引集合
    NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:button.tag];
    //刷新某一个区
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
   //  NSArray * arr1 =_dataBigArr[button.tag];
    
    
    
    
}


//设置区头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(void)backWrite
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtn{
    DingYueVC * vc =[DingYueVC new];
    [self.navigationController pushViewController:vc animated:YES];
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
