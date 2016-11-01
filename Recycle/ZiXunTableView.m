//
//  ZiXunTableView.m
//  Recycle
//
//  Created by Macx on 16/5/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZiXunTableView.h"
#import "ZiXunFenLeiModel.h"
#import "ZiXunXiangQingVC.h"
@interface ZiXunTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageYeshu;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation ZiXunTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // NSLog(@"我特殊是%d",_aaa);
    pageYeshu=1;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64-40) style:UITableViewStylePlain];
    _tableView.backgroundColor=COLOR;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    _dataArray=[NSMutableArray new];
    [self zixunDataPage:@"1"];
    [self CreatReashTableview];
}
//资讯数据解析
-(void)zixunDataPage:(NSString*)yeshu
{
    
    [Engine  getZiXunLieBiaoPage:yeshu Pagesize:@"10" uid:@"0" pwd:@"0" Where:@"0" Classid:_classID success:^(NSDictionary *dic) {
      //  NSLog(@">>>%@",dic);
        
        if ([dic objectForKey:@"Item3"]==[NSNull null]) {
           
            return ;
        }
        NSMutableArray * arra =[dic objectForKey:@"Item3"];
        for (NSDictionary * dicc in  arra ) {
            ZiXunFenLeiModel * model1 =[[ZiXunFenLeiModel alloc]initWithZiXunTableview:dicc];
            [_dataArray addObject:model1];
        }
        
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

-(void)CreatReashTableview{
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
}
-(void)footerRefresh{
    [_tableView.footer endRefreshing];
    pageYeshu++;
    NSString*pageYS =[NSString stringWithFormat:@"%d",pageYeshu];
   // [self baojiaData:pageYS bgClass:cidClass];
    [self zixunDataPage:pageYS];
    NSLog(@"page页数%d",pageYeshu);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    ZiXunFenLeiModel * md =_dataArray[indexPath.row];
    
    UILabel * lable =(UILabel*)[cell viewWithTag:11];
    lable.font=[UIFont systemFontOfSize:15];
    lable.text=md.titleName1;
    UILabel * timeLabe =(UILabel*)[cell viewWithTag:22];
    timeLabe.font=[UIFont systemFontOfSize:13];
    timeLabe.alpha=.5;
    timeLabe.text=[Engine nsdateToTime:md.publicTime];//md.publicTime;
   
    
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
    
    
    //cell.textLabel.text=md.titleName1;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZiXunFenLeiModel * md =_dataArray[indexPath.row];
    ZiXunXiangQingVC * vc =[ZiXunXiangQingVC new];
    vc.messageid=md.messageID;
    vc.classIdd=_classID;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
