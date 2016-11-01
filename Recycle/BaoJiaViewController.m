//
//  BaoJiaViewController.m
//  Recycle
//
//  Created by Macx on 16/5/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaoJiaViewController.h"
#import "BaoJiaModel.h"
#import "BaoJiaXiangQing.h"
#import "BaoJiaClassVC.h"
@interface BaoJiaViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageYeshu;
    NSString * cidClass;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation BaoJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangView];
    pageYeshu=1;
    _dataArray=[NSMutableArray new];
    
   
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=COLOR;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    [self baojiaData:@"1" bgClass:@"0"];
    [self CreatReashTableview];
    
}

-(void)CreatReashTableview{
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
}
-(void)footerRefresh{
    [_tableView.footer endRefreshing];
    pageYeshu++;
    NSString*pageYS =[NSString stringWithFormat:@"%d",pageYeshu];
     [self baojiaData:pageYS bgClass:cidClass];
    NSLog(@"page页数%d",pageYeshu);
}
//报价数据解析
-(void)baojiaData:(NSString*)yeshu bgClass:(NSString*)cid
{
    [WINDOW showHUDWithText:@"数据加载中请稍后..." Type:0 Enabled:YES];
    [Engine getBaoJiaPage:yeshu pagesize:@"10" bgclass:cid success:^(NSDictionary *dic) {
        NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([ss isEqualToString:@"1"]) {
            NSArray * arr =[dic objectForKey:@"Item3"];
            [WINDOW showHUDWithText:@"" Type:ShowDismiss Enabled:YES];
            for (NSDictionary  * dicc in arr) {
                BaoJiaModel * model1 =[[BaoJiaModel alloc]initWithBaoJia:dicc];
                [_dataArray addObject:model1];
            }

        }else{
            
        }
               [_tableView reloadData];
        
    } error:^(NSError *error) {
        [WINDOW showHUDWithText:@"网络超时请重新尝试" Type:ShowPhotoNo Enabled:YES];
    }] ;
}

-(void)daohangView
{
    self.view.backgroundColor=COLOR;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:@"报价"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems=@[leftBtn];
    
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(KUAN-47,27, 37/2, 37/2);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"sub_add(1)"] forState:0];
    [rightBtn addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItems=@[right];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * lable =[UILabel new];
        lable.tag=11;
        UILabel * timeLabe =[UILabel new];
        timeLabe.tag=22;
        
        [cell sd_addSubviews:@[lable,timeLabe]];
    }
    BaoJiaModel * model =_dataArray[indexPath.row];
    UILabel * lable =(UILabel*)[cell viewWithTag:11];
    lable.font=[UIFont systemFontOfSize:15];
    lable.text=model.titleName;
    UILabel * timeLabe =(UILabel*)[cell viewWithTag:22];
    timeLabe.font=[UIFont systemFontOfSize:13];
    timeLabe.alpha=.5;
    timeLabe.text=[Engine nsdateToTime:model.publicTime];
    
    
    lable.sd_layout
    .leftSpaceToView(cell,10)
    .topSpaceToView(cell,10)
    .heightIs(20);
    [lable setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    timeLabe.sd_layout
    .rightSpaceToView(cell,20)
    .bottomSpaceToView(cell,5)
    .heightIs(20);
    [timeLabe setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaoJiaModel * model =_dataArray[indexPath.row];
    BaoJiaXiangQing * vc =[BaoJiaXiangQing new];
    vc.cidClass=cidClass;
    vc.messageID=model.messageID;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)rightBtn{
    BaoJiaClassVC * vc =[BaoJiaClassVC new];
    vc.CidBlock=^(NSString*cidd){
        [_dataArray removeAllObjects];
        [self baojiaData:@"1" bgClass:cidd];
        cidClass=cidd;
        
    };
    [self.navigationController pushViewController:vc animated:YES];
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
