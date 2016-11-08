//
//  MyPublicVC.m
//  Recycle
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyPublicVC.h"
#import "LrdSuperMenu.h"
#import "MyPublicCell.h"
#import "GongQiuModel.h"
#import "XiangXiVC1.h"
#import "PaiMaiVC.h"
#import "MyWeiZhi.h"//供应求购
#import "ZiChanFaBuVC.h"//资产发布
#import "PaiMaiPublicVC.h"//拍卖发布
#import "MyPublicVC.h"//我的发布
@interface MyPublicVC ()<UITableViewDataSource,UITableViewDelegate,LrdSuperMenuDataSource,LrdSuperMenuDelegate>
{
    BOOL  _flag[1000];
    NSInteger  oneSceon;//判断当前是第几个（供应，求购，还是拍卖 资产）

}
//列表
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) LrdSuperMenu *menu;
@property(nonatomic,retain)NSMutableArray * array1;
@property(nonatomic,retain)NSMutableArray * array2;
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * imageArray;
@end

@implementation MyPublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray=[NSMutableArray new];
    _imageArray=[NSMutableArray new];
    [self Mydanghao];
    [self ArrayStar];
    [self SanFang];
    [self CreatTableView];
    [self jieXiShuJuDataType:@"1"];
}

-(void)ArrayStar{
    _array1=[[NSMutableArray alloc]initWithObjects:@"供应",@"求购",@"拍卖",@"处置", nil];
    _array2=[[NSMutableArray alloc]initWithObjects:@"审核中",@"审核通过",@"违规信息", nil];
}
-(void)SanFang{
    _menu = [[LrdSuperMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:44];
    _menu.delegate = self;
    _menu.dataSource = self;
    _menu.isClickHaveItemValid=YES;
    [self.view addSubview:_menu];
}
- (NSInteger)numberOfColumnsInMenu:(LrdSuperMenu *)menu {
    return 2;
}
//每个区返回多少个
- (NSInteger)menu:(LrdSuperMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    if (column == 0) {
        return _array1.count;
    }else  {
        return _array2.count;
    }
    
}
//返回区的内容
- (NSString *)menu:(LrdSuperMenu *)menu titleForRowAtIndexPath:(LrdIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return _array1[indexPath.row];
    }else  {
        return _array2[indexPath.row];
   }
}
- (void)menu:(LrdSuperMenu *)menu didSelectRowAtIndexPath:(LrdIndexPath *)indexPath {
    if (indexPath.item >= 0)
    {
       // NSLog(@"这是大于0的啊点击了 %ld - %ld - %ld 项目",(long)indexPath.column,(long)indexPath.row,(long)indexPath.item);
    }else
    {
      //  NSLog(@"这是小于0的啊点击了 %ld - %ld 项目",(long)indexPath.column,(long)indexPath.row);
        [_dataArray removeAllObjects];
        if (indexPath.column==1)
        {
            //审核资料
            NSString * type =[NSString stringWithFormat:@"%lu",indexPath.row+1];
            NSLog(@"看看是第几个%@",type);
            if (oneSceon==0||oneSceon==1) {
                  [_dataArray removeAllObjects];
                [self jieXiShuJuDataType:type];
            }else if (oneSceon==2){
                  [_dataArray removeAllObjects];
                 [self paiMaiDataType:type];
            }else if (oneSceon==3){
                  [_dataArray removeAllObjects];
                [self huoQuZiChanMessageDataType:type];
            }
           
        }else
        {
            oneSceon=indexPath.row;
            
            //供应求购
            if (indexPath.row==0||indexPath.row==1)
            {
                  [self jieXiShuJuDataType:@"1"];
            }else if (indexPath.row==2){
                //拍卖接口
                [self paiMaiDataType:@"1"];
            }else{
                //资产处置接口
                [self huoQuZiChanMessageDataType:@"1"];
            }
            
        }
        
       
    }

}
//获取资产信息
-(void)huoQuZiChanMessageDataType:(NSString*)type{
//    getMyPublicZiChanZhongXinKey
    
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        return;
    }
    [WINDOW showHUDWithText:@"加载中..." Type:0 Enabled:YES];
    [Engine getMyPublicZiChanZhongXinKey:token Type:type Page:@"1" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        
        if ([item1 isEqualToString:@"1"]) {
            [WINDOW showHUDWithText:@"加载成功" Type:ShowDismiss Enabled:YES];
            NSArray * array =[dic objectForKey:@"Item4"];
            for (NSDictionary * dicc in array)
            {
                GongQiuModel * md =[[GongQiuModel alloc]initWithZiChan:dicc];
                [_dataArray addObject:md];
            }
        }else{
            [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
         [WINDOW showHUDWithText:@"网络超时" Type:ShowPhotoNo Enabled:YES];
    }];
    
}
//供求的数据
-(void)jieXiShuJuDataType:(NSString*)type{
    
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        return;
    }
     [WINDOW showHUDWithText:@"加载中..." Type:0 Enabled:YES];
    [Engine getMyPublicGongQiuZhongXinKey:token Type:type Page:@"1" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
             [WINDOW showHUDWithText:@"加载成功" Type:ShowDismiss Enabled:YES];
            NSArray * array =[dic objectForKey:@"Item4"];
            for (NSDictionary * dicc in array)
            {
                GongQiuModel * md =[[GongQiuModel alloc]initWithDic:dicc];
                [_dataArray addObject:md];
            }
            
        }else{
            [WINDOW showHUDWithText:[dic  objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
        }
        
        [_tableView reloadData];
    } error:^(NSError *error) {
         [WINDOW showHUDWithText:@"加载失败" Type:ShowPhotoNo Enabled:YES];
    }];
    
    
    
    
    
    
    
    
    
    
}
//获取拍卖的数据
-(void)paiMaiDataType:(NSString*)type{
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        return;
    }
      [WINDOW showHUDWithText:@"加载中..." Type:0 Enabled:YES];
    [Engine getMyPublicPaiMaiKey:token Type:type Page:@"1" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
       [WINDOW showHUDWithText:@"加载成功" Type:ShowDismiss Enabled:YES];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * array =[dic objectForKey:@"Item4"];
            for (NSDictionary * dicc in array)
            {
                
                GongQiuModel * md =[[GongQiuModel alloc]initWithPaiMai:dicc];
                [_dataArray addObject:md];
            }
            
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
         [WINDOW showHUDWithText:@"网络超时" Type:ShowPhotoNo Enabled:YES];
    }];
    
    
    
    
    
    
    
}


-(void)CreatTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, KUAN, GAO-44-54) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _tableView.rowHeight=60;
    UINib * nib =[UINib nibWithNibName:@"MyPublicCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"PublicCell"];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_flag[section]==NO)
    {
        return 0;
    }else{
        return 1;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPublicCell * cell =[tableView dequeueReusableCellWithIdentifier:@"PublicCell" forIndexPath:indexPath ];
    [self yueshu:cell];
    
    
    if(oneSceon==2||oneSceon==3){
        cell.shangXianBtn.enabled = NO;
        cell.shuaXinBtn.enabled=NO;
        cell.shuaXinBtn.alpha=.5;
        cell.shangXianBtn.alpha=.5;
    }
    
    cell.shanChuBtn.tag=indexPath.section;
    cell.xiuGaiBtn.tag=indexPath.section;
    cell.shangXianBtn.tag=indexPath.section;
    cell.shuaXinBtn.tag=indexPath.section;
    //删除
    [cell.shanChuBtn addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
    
    //修改
    [cell.xiuGaiBtn addTarget:self action:@selector(xiugai:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
   //刷新
    [cell.shuaXinBtn addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
    //上下线
    [cell.shangXianBtn addTarget:self action:@selector(shangxian:) forControlEvents:UIControlEventTouchUpInside];
    //联系客服
    [cell.lianXiKeFuBtn addTarget:self action:@selector(lianxikefu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}

//添加约束
-(void)yueshu:(MyPublicCell*)cell{
    
    [cell sd_addSubviews:@[cell.shuaXinBtn,cell.shangXianBtn,cell.xiuGaiBtn,cell.shanChuBtn,cell.lianXiKeFuBtn]];
   
    
    CGFloat a =(KUAN-(5*29+29))/6;
    
    cell.shuaXinBtn.sd_layout
    .leftSpaceToView(cell,a)
    .topSpaceToView(cell,10)
    .widthIs(29)
    .heightIs(46);
    
    cell.shangXianBtn.sd_layout
    .leftSpaceToView(cell.shuaXinBtn,a)
    .topEqualToView(cell.shuaXinBtn)
    .widthRatioToView(cell.shuaXinBtn,1)
    .heightRatioToView(cell.shuaXinBtn,1);
    
    cell.xiuGaiBtn.sd_layout
    .leftSpaceToView(cell.shangXianBtn,a)
    .topEqualToView(cell.shuaXinBtn)
    .widthRatioToView(cell.shuaXinBtn,1)
    .heightRatioToView(cell.shuaXinBtn,1);
    
    cell.shanChuBtn.sd_layout
    .leftSpaceToView(cell.xiuGaiBtn,a)
    .topEqualToView(cell.shuaXinBtn)
    .widthRatioToView(cell.shuaXinBtn,1)
    .heightRatioToView(cell.shuaXinBtn,1);
    
    cell.lianXiKeFuBtn.sd_layout
    .leftSpaceToView(cell.shanChuBtn,a)
    .topEqualToView(cell.shuaXinBtn)
    .widthIs(56)
    .heightRatioToView(cell.shuaXinBtn,1);
    
}

//刷新
-(void)shuaxin:(UIButton*)btn{
    //[_tableView reloadData];
    GongQiuModel * md=_dataArray[btn.tag];
    NSString*token= [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (token==nil) {
        return;
    }else{
        NSLog(@"信息ID>>>%@",md.messageID);
        [Engine shuaXinReashGongQiuKey:token MessageID:md.messageID success:^(NSDictionary *dic) {
             [WINDOW  showHUDWithText:@"刷新成功" Type:ShowPhotoYes Enabled:YES];
        } error:^(NSError *error) {
             [WINDOW  showHUDWithText:@"网络超时" Type:ShowPhotoNo Enabled:YES];
        }];
        
    }
    
}




//上线
-(void)shangxian:(UIButton*)shangBtn{
    shangBtn.selected=!shangBtn.selected;
     GongQiuModel * md=_dataArray[shangBtn.tag];
   NSString*token= [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (token==nil) {
        return;
    }else{
         // NSLog(@"信息ID>>>%@",md.messageID);
        [Engine xiuGaiShangXianXiaXianKey:token MessageID:md.messageID success:^(NSDictionary *dic) {
            [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoYes Enabled:YES];
        } error:^(NSError *error) {
             [WINDOW showHUDWithText:@"网络超时" Type:ShowPhotoNo Enabled:YES];
        }];
        
    }
}

//修改
-(void)xiugai:(UIButton*)btn{
    
    GongQiuModel * md=_dataArray[btn.tag];
    
    if(oneSceon==0)
    {
        MyWeiZhi * myweizhi =[MyWeiZhi new];
        myweizhi.titleName=@"修改发布信息";
        myweizhi.model=md;
        myweizhi.xinXinID=md.messageID;
        [self.navigationController pushViewController:myweizhi animated:YES];
    }else if (oneSceon==1){
        MyWeiZhi * myweizhi =[MyWeiZhi new];
         myweizhi.model=md;
         myweizhi.xinXinID=md.messageID;
        myweizhi.titleName=@"修改发布信息";
        [self.navigationController pushViewController:myweizhi animated:YES];
    }else if (oneSceon==2){
        PaiMaiPublicVC * paimai =[PaiMaiPublicVC new];
        paimai.xinXinID=md.messageID;
        paimai.model=md;
        [self.navigationController pushViewController:paimai animated:YES];
    }else{

        ZiChanFaBuVC * zichanvc =[ZiChanFaBuVC new];
         zichanvc.model=md;
        zichanvc.xinXinID=md.messageID;
        [self.navigationController pushViewController:zichanvc animated:YES];
    }
    
}
//删除
-(void)shanchu:(UIButton*)btn{
     GongQiuModel * md=_dataArray[btn.tag];
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        return;
    }
    if (oneSceon==0||oneSceon==1) {
        [Engine deleteGongQiu:token MessageId:md.messageID success:^(NSDictionary *dic)
         {
             NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
             if ([item1 isEqualToString:@"1"])
             {
                 [_dataArray removeObject:md];
                 [_tableView reloadData];
             }
         } error:nil];
    }else if(oneSceon==2){
            //拍卖
        //NSLog(@"拍卖>>>>>%@",md.messageID);
        [Engine deletePaiMaiFabuKey:token MessageID:md.messageID success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"])
            {
                [_dataArray removeObject:md];
                [_tableView reloadData];
            }
        } error:^(NSError *error) {
            
        }];
        
    }else{
        //资产
        // NSLog(@"资产>>>>>%@",md.messageID);
        [Engine deleteZiChanFabuKey:token MessageID:md.messageID success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"])
            {
                [_dataArray removeObject:md];
                [_tableView reloadData];
            }
        } error:^(NSError *error) {
            
        }];
        
    }
    
    
    
}
//联系客服
-(void)lianxikefu:(UIButton*)btn{
    
}
//设置区头按钮
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GongQiuModel * md =_dataArray[section];
    UIButton * bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bgBtn setBackgroundColor:[UIColor whiteColor]];
    [bgBtn setBackgroundImage:[UIImage imageNamed:@"bg-line"] forState:UIControlStateNormal];
    bgBtn.tag=section+100;
    [bgBtn addTarget:self action:@selector(bgBtn:) forControlEvents:UIControlEventTouchUpInside];
    UILabel * titleLabel =[UILabel new];
    UILabel * defiLabel =[UILabel new];
    UILabel * timeLabel =[UILabel new];
   
    UIButton * xiaLaBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    xiaLaBtn.tag=section;
   // xiaLaBtn.backgroundColor=[UIColor greenColor];
    [xiaLaBtn addTarget:self action:@selector(buttonClink:) forControlEvents:UIControlEventTouchUpInside];
    [xiaLaBtn setBackgroundImage:[UIImage imageNamed:@"上"] forState:UIControlStateNormal];
    [xiaLaBtn setBackgroundImage:[UIImage imageNamed:@"下"] forState:UIControlStateSelected];
    
    
    titleLabel.font=[UIFont systemFontOfSize:14];
    defiLabel.font=[UIFont systemFontOfSize:13];
    timeLabel.font=[UIFont systemFontOfSize:13];
    defiLabel.alpha=.5;
    timeLabel.alpha=.5;
    titleLabel.text=md.titleName;//@"出售机床";
    defiLabel.text=md.typeName;//@"二手机床设备";
    timeLabel.text=[Engine nsdateToTime:md.time];//md.time;//@"2016-05-05";
    [bgBtn sd_addSubviews:@[titleLabel,defiLabel,timeLabel,xiaLaBtn]];
    
    titleLabel.sd_layout
    .leftSpaceToView(bgBtn,20)
    .heightIs(20)
    .topSpaceToView(bgBtn,10);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    defiLabel.sd_layout
    .leftSpaceToView(bgBtn,20)
    .heightIs(20)
    .topSpaceToView(titleLabel,10);
    [defiLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    timeLabel.sd_layout
    .rightSpaceToView(bgBtn,20)
    .heightIs(20)
    .topEqualToView(defiLabel);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
   
    xiaLaBtn.sd_layout
    .rightSpaceToView(bgBtn,15)
    .centerYEqualToView(bgBtn)
    .widthIs(26/2)
    .heightIs(25/2);
    
    
    return bgBtn;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65;
}

-(void)buttonClink:(UIButton*)button
{
     button.selected=!button.selected;
    if (button.selected==YES) {
        
        _flag[button.tag]=!_flag[button.tag];
        //索引集合
        //把区号放到索引集合中,NSIndexSet代表索引集合
        NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:button.tag];
        //刷新某一个区
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        
       
    }else{
        
    }
    

}
//点击区头
-(void)bgBtn:(UIButton*)btn{
      GongQiuModel * md =_dataArray[btn.tag-100];
    if (oneSceon==2) {
        //拍卖
        PaiMaiVC * vc =[PaiMaiVC new];
        vc.jiemian=md.messageID;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        XiangXiVC1 * vc =[XiangXiVC1 new];
        vc.tagg=oneSceon;
        vc.jiemian=md.messageID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
   
    
}
-(void)Mydanghao
{
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"我的发布"];
    
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
