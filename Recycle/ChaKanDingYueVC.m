//
//  ChaKanDingYueVC.m
//  Recycle
//
//  Created by Macx on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ChaKanDingYueVC.h"
#import "GongableCell.h"
#import "GongQiuModel.h"
#import "XiangXiVC1.h"
@interface ChaKanDingYueVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView* tableView;
@property(nonatomic,retain)NSMutableArray*dataArray;
@end

@implementation ChaKanDingYueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self danghang];
    // Do any additional setup after loading the view.
    [self starArr];
    [self.view addSubview:[self CreatTableView]];
    [self shuJuData];
}
-(void)starArr{
    _dataArray=[NSMutableArray new];
}

-(void)shuJuData{
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    [WINDOW showHUDWithText:@"数据加载中..." Type:ShowLoading Enabled:YES];
    [Engine getDingYueTiaoJianToke:token messageID:_dyModel.sid success:^(NSDictionary *dic) {
        
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            [WINDOW showHUDWithText:@"加载成功" Type:ShowPhotoYes Enabled:YES];
            NSMutableArray * item2Arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in item2Arr) {
                [self commJiemian:dicc];
            }

        }else{
            [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        [WINDOW showHUDWithText:@"网络超时" Type:ShowPhotoNo Enabled:YES];
    }];
}

//判断是哪个界面过来的
-(void)commJiemian:(NSDictionary*)dicc{
    if([_dyModel.sTypename isEqualToString:@"供应"]){
        GongQiuModel* gmodel1=[[GongQiuModel alloc]initWithDic:dicc];
        [_dataArray addObject:gmodel1];
    }else if ([_dyModel.sTypename isEqualToString:@"求购"]){
        GongQiuModel* gmodel1=[[GongQiuModel alloc]initWithDic:dicc];
        [_dataArray addObject:gmodel1];
    }else if ([_dyModel.sTypename isEqualToString:@"资产"]){
        GongQiuModel* gmodel2=[[GongQiuModel alloc]initWithZiChan:dicc];
        [_dataArray addObject:gmodel2];
    }else{
        GongQiuModel* gmodel3=[[GongQiuModel alloc]initWithPaiMai:dicc];
        [_dataArray addObject:gmodel3];
    }
}



-(UITableView*)CreatTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.backgroundColor=COLOR;
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    return self.tableView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * idd =@"Cell";
    GongableCell * cell =[tableView dequeueReusableCellWithIdentifier:idd];
    if (!cell) {
        cell=[[GongableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
    }
     cell.gmodel=_dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view =[UIView new];
    view.backgroundColor=COLOR;
    UILabel * label =[UILabel new];
    label.text=[NSString stringWithFormat:@"您订阅的%@有%lu条信息",_dyModel.sTypename,(unsigned long)_dataArray.count];
    [view sd_addSubviews:@[label]];
    label.font=[UIFont systemFontOfSize:15];
    label.sd_layout
    .leftSpaceToView(view,15)
    .centerYEqualToView(view)
    .heightIs(20);
    [label setSingleLineAutoResizeWithMaxWidth:KUAN];
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
-(void)backWrite
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)danghang{
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:_dyModel.sTypename];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
   // [backBtn setBackgroundImageForState:0 withURL:[NSURL URLWithString:@""]];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
}


@end
