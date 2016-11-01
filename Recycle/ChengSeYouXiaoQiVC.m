//
//  ChengSeYouXiaoQiVC.m
//  Recycle
//
//  Created by Macx on 16/6/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ChengSeYouXiaoQiVC.h"
#import "FirstModel.h"
#import "HangYeClassModel.h"
@interface ChengSeYouXiaoQiVC ()
@property(nonatomic,retain)NSMutableArray*dataArray;
@property(nonatomic,retain)NSMutableArray*codeID;
@end

@implementation ChengSeYouXiaoQiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self danghang];
    [self starArr];
    self.tableView.backgroundColor=COLOR;
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
}
-(void)starArr{
   // NSLog(@"wwww%d",_tagg);
    if (_tagg==1) {
        //成色
         _dataArray=[[NSMutableArray alloc]initWithObjects:@"不限",@"全新",@"9成新",@"8成新",@"7成新",@"6成新",@"5成新", nil];
    }else if(_tagg==2){
        //有效期
        _dataArray=[[NSMutableArray alloc]initWithObjects:@"一个月",@"三个月",@"半年",@"一年", nil];
    }else{
        //这是拍卖的界面
        _dataArray=[NSMutableArray new];
        _codeID=[NSMutableArray new];
        [self paiMaiHangYe];
    }
   
}
//所属行业解析
-(void)jiexiDataReMen{
    
    [Engine HuoQuFirstHangYeMessageType:@"0" success:^(NSDictionary *dic) {
        NSArray * array =[dic objectForKey:@"Item3"];
        for (NSDictionary * dicc in array ) {
        FirstModel * md =[[FirstModel alloc]initWithDic:dicc];
        [_dataArray addObject:md.Onename];
            NSLog(@"%@",md.Onename);
        }
        [self.tableView reloadData];
    } error:nil];
    
}
//供求分类
//-(void)gongqiuFenl{
//  [Engine  getGongQiuFenLeiClass:nil success:^(NSDictionary *dic) {
//      
//  } error:nil];
//}
//拍卖行业
-(void)paiMaiHangYe{
    [Engine getPaiMaiHangYesuccess:^(NSDictionary *dic) {
        NSString * item =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item isEqualToString:@"1"]) {
            NSArray * arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in arr ) {
                HangYeClassModel * model =[[HangYeClassModel alloc]initWithPaiMaiDic:dicc];
                [_dataArray addObject:model.titleName];
                [_codeID addObject:model.cid];
            }
        }
        [self.tableView reloadData];
    } error:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * idd =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idd ];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
    }
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (_tagg==3) {
        //给拍卖界面传的值
        self.nameBlock(_dataArray[indexPath.row],[_codeID[indexPath.row] intValue]);
    }else{
        //其他界面
        self.nameBlock(_dataArray[indexPath.row],_tagg);
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
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
-(void)danghang{
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:_titleName];
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
