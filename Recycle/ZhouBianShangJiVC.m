//
//  ZhouBianShangJiVC.m
//  Recycle
//
//  Created by Macx on 16/5/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZhouBianShangJiVC.h"
#import "ZhouBianShangJiCell.h"
#import "LrdOutputView.h"
#import "GongQiuModel.h"
#import "GongableCell.h"
#import "XiangXiVC1.h"
@interface ZhouBianShangJiVC ()<UITableViewDelegate,UITableViewDataSource,LrdOutputViewDelegate>
{
    
}
@property(nonatomic,retain)UITableView * tableView;
@property (nonatomic, strong) LrdOutputView *outputView;
@property(nonatomic,retain)NSArray *dataArr;
@property(nonatomic,retain)NSMutableArray*popArr;
@property(nonatomic,retain)NSMutableArray*dataArray;
@end

@implementation ZhouBianShangJiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreatDaoHang];
    // Do any additional setup after loading the view.
    [self CreatTableView];
    [self CreatPopView];
    
    _dataArray=[NSMutableArray new];
    [self ShuJuDataType:@"1"];
    
    
}
-(void)CreatPopView{
    _popArr =[[NSMutableArray alloc]initWithObjects:@"供求商机",@"资产处置",@"拍卖招标", nil];
    LrdCellModel *one = [[LrdCellModel alloc] initWithTitle:@"供求商机" imageName:@"1111"];
    LrdCellModel *two = [[LrdCellModel alloc] initWithTitle:@"资产处置" imageName:@"1111"];
    LrdCellModel *three = [[LrdCellModel alloc] initWithTitle:@"拍卖招标" imageName:@"1111"];
    self.dataArr = @[one, two, three];
}
-(void)CreatTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=COLOR;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}


-(void)ShuJuDataType:(NSString*)type{
    [WINDOW showHUDWithText:@"数据加载中请稍后..." Type:ShowLoading Enabled:YES];
    
    NSString * code =[[NSUserDefaults standardUserDefaults]objectForKey:@"citycode"];
    NSLog(@">>>code=%@",code);//130100
//#pragma mark --获取附近商机(对应的周边商机)没有图片
    [Engine getFuJinShangJiCityCode:code Page:@"1" Type:type success:^(NSDictionary *dic) {
          NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
         [WINDOW showHUDWithText:@"数据加载成功" Type:ShowPhotoYes Enabled:YES];
        if ([item1 isEqualToString:@"1"])
        {
            
            NSArray * item3 =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in  item3)
        {
            if ([type intValue]==1)
            {
                GongQiuModel * md =[[GongQiuModel alloc]initWithDic:dicc];
                [_dataArray addObject:md];
            }else if ([type intValue]==2){
                //资产
            GongQiuModel * md =[[GongQiuModel alloc]initWithZiChan:dicc];
            [_dataArray addObject:md];
            }else if([type intValue]==3){
            //paimai
            GongQiuModel * md =[[GongQiuModel alloc]initWithPaiMai:dicc];
            [_dataArray addObject:md];
            }
                           
        }
            NSLog(@"输出数组个数%lu",_dataArray.count);
            [_tableView reloadData];
        }else
         {
           // NSLog(@"获取失败%@",[dic objectForKey:@"Item2"]);
             [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
        }
       
    } error:nil];
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    ZhouBianShangJiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    if (!cell) {
//        cell=[[ZhouBianShangJiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    }
    static NSString * idd =@"Cell";
    GongableCell * cell =[tableView dequeueReusableCellWithIdentifier:idd];
    if (!cell) {
        cell=[[GongableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
    }
    cell.gmodel=_dataArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GongQiuModel * mm =_dataArray[indexPath.row];
    XiangXiVC1 * vc =[XiangXiVC1 new];
    vc.messageID=mm.messageID;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)xiaxia:(UIButton*)btn{
    CGFloat x = btn.center.x+10;
    CGFloat y = 70;//btn.frame.origin.y + btn.bounds.size.height + 30;
    _outputView = [[LrdOutputView alloc] initWithDataArray:self.dataArr origin:CGPointMake(x, y) width:120 height:40 direction:kLrdOutputViewDirectionRight];
    _outputView.fount=18;
    _outputView.delegate = self;
    _outputView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        _outputView = nil;
    };
    [_outputView pop];
}
- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
   // [fangdajing setTitle:_popArr[indexPath.row] forState:0];
    [self.navigationItem setTitle:_popArr[indexPath.row]];
    [_tableView setContentOffset:CGPointZero animated:YES];
    [_dataArray removeAllObjects];
    [self ShuJuDataType:[self shujuMoXing:_popArr[indexPath.row]]];
}
-(NSString*)shujuMoXing:(NSString*)name{
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:@"1" forKey:@"供求商机"];
    [dic setObject:@"2" forKey:@"资产处置"];
    [dic setObject:@"3" forKey:@"拍卖招标"];
    NSString * key =[dic objectForKey:name] ;
    return key;
    
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
-(void)CreatDaoHang{
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"供求商机"];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIButton * fangdajing=[UIButton buttonWithType:UIButtonTypeCustom];
    [fangdajing setBackgroundImage:[UIImage imageNamed:@"xiajiantou"] forState:0];
    [fangdajing addTarget:self action:@selector(xiaxia:) forControlEvents:UIControlEventTouchUpInside];
    fangdajing.center=CGPointMake(self.view.center.x+10, 27);
    fangdajing.bounds=CGRectMake(0, 0, 30/2, 17/2);
    UIBarButtonItem * rightBtn2 =[[UIBarButtonItem alloc]initWithCustomView:fangdajing];
    self.navigationItem.leftBarButtonItems=@[leftBtn];
    //不知道为什么，就这么写他就会去中间
    self.navigationItem.rightBarButtonItems=@[rightBtn2,rightBtn2,rightBtn2,rightBtn2,rightBtn2,rightBtn2];
    self.navigationItem.leftBarButtonItem=leftBtn;

    
}
@end
