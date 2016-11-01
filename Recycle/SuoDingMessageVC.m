//
//  SuoDingMessageVC.m
//  Recycle
//
//  Created by Macx on 16/6/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SuoDingMessageVC.h"
#import "XiangXiVC1.h"
#import "MessageSuoDingModel.h"
#import "SuoDingMessageCell.h"
#import "SuoDingMessageXiangQingVC.h"

@interface SuoDingMessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int typeInt;
    
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation SuoDingMessageVC
-(void)viewWillAppear:(BOOL)animated{
    [_dataArray removeAllObjects];
    [self huoQuSuoDingMessageData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self danghao];
    _dataArray=[NSMutableArray new];
    [self CreatTableView];
    
}

-(void)CreatTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    self.tableView.backgroundColor=COLOR;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString * idd =@"Cell";
    SuoDingMessageCell * cell =[tableView dequeueReusableCellWithIdentifier:idd];
    if (!cell) {
        cell=[[SuoDingMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
    }
    MessageSuoDingModel * model =_dataArray[indexPath.row];
    cell.model=model;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageSuoDingModel * model =_dataArray[indexPath.row];
    SuoDingMessageXiangQingVC * vc =[SuoDingMessageXiangQingVC new];
    vc.messageID=model.messageID;
    vc.number=model.infoClass;
    [self.navigationController pushViewController:vc animated:YES];
    
}




-(void)huoQuSuoDingMessageData{
    NSString * ss =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    if (ss==nil) {
        return;
    }else{
        [WINDOW showHUDWithText:@"数据加载中..." Type:ShowLoading Enabled:YES];
        
        [Engine getSuoDiangMessageToken:ss success:^(NSDictionary *dic) {
            
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if([item1 isEqualToString:@"1"])
            {
                [WINDOW showHUDWithText:@"加载成功" Type:ShowPhotoYes Enabled:YES];
                NSArray * arr =[dic objectForKey:@"Item3"];
                for (NSDictionary * dicc in arr)
                {
                    MessageSuoDingModel*md =[[MessageSuoDingModel alloc]initWithMessageID:dicc];
                    [_dataArray addObject:md];
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
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageSuoDingModel *str = _dataArray[indexPath.row];
    
    return [_tableView cellHeightForIndexPath:indexPath model:str keyPath:@"model" cellClass:[SuoDingMessageCell class] contentViewWidth:[self  cellContentViewWith]];
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

-(void)danghao{
    
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"锁定信息"];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
}
-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
