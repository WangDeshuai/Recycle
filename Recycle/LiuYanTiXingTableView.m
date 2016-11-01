//
//  LiuYanTiXingTableView.m
//  Recycle
//
//  Created by Macx on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LiuYanTiXingTableView.h"
#import "LiuYanTiXingCell.h"
#import "LiuYanModel.h"
#import "ChatViewController.h"
@interface LiuYanTiXingTableView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation LiuYanTiXingTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self daohangtiao];
    [self StartArray];
    [self huoQuLiuYanData];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)StartArray{
    _dataArray=[NSMutableArray new];
}

-(void)huoQuLiuYanData{
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        [WINDOW showHUDWithText:@"您还没有登录" Type:ShowPhotoNo Enabled:YES];
        return;
    }
     [WINDOW showHUDWithText:@"数据加载中..." Type:0 Enabled:YES];
    //type: 0用户收到的 1用户发出的
    [Engine getYongHuLiuYanLieBiaoKey:token Page:@"1" Type:@"0" success:^(NSDictionary *dic) {
        [WINDOW showHUDWithText:@"加载成功" Type:ShowDismiss Enabled:YES];
        NSString * ss = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([ss isEqualToString:@"1"])
        {
            NSArray * item3 =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in item3) {
                LiuYanModel * md =[[LiuYanModel alloc]initWithLiuYanLieBiao:dicc];
                [_dataArray addObject:md];
            }
            
        }else{
            [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoYes Enabled:YES];
        }
        [self.tableView reloadData];
        
    } error:^(NSError *error) {
        [WINDOW showHUDWithText:@"获取失败网络超时" Type:ShowPhotoNo Enabled:YES];
    }];
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * idd =@"Cell";
    LiuYanTiXingCell *cell = [tableView dequeueReusableCellWithIdentifier:idd];
    if (!cell) {
        cell=[[LiuYanTiXingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
    }
    LiuYanModel * md =_dataArray[indexPath.row];
    cell.model=md;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return [self.tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row] keyPath:@"model" cellClass:[LiuYanTiXingCell class] contentViewWidth:[self  cellContentViewWith]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LiuYanModel * md =_dataArray[indexPath.row];
    md.isChaKan=YES;
    ChatViewController * vc =[ChatViewController new];
    vc.sendMessageID=md.suid;
    vc.receiveMessageID=md.ruid;
    [self.navigationController pushViewController:vc animated:YES];
    
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

-(void)huouquliuyen{
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    [Engine getLiuYanDuiHuaKey:token Ruid:@"272029" success:^(NSDictionary *dic) {
        
    } error:^(NSError *error) {
        
    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)daohangtiao{
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"留言提醒"];
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
