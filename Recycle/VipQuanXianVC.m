//
//  VipQuanXianVC.m
//  Recycle
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "VipQuanXianVC.h"
#import "VipTeQuanCell.h"
#import "ShengJiTeQuanVC.h"
#import "VipQuanXianModel.h"
@interface VipQuanXianVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * imageview;
    UIButton * button1;
    UIButton * button2;
}
@property(nonatomic,retain)UIScrollView * bgScroller;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArrr;
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)UIButton * lastBtn;
@end

@implementation VipQuanXianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"会员权限"];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    _dataArray=[NSMutableArray new];
    _bgScroller=[UIScrollView new];//initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    _bgScroller.contentSize=CGSizeMake(KUAN, GAO+100);
    _bgScroller.backgroundColor=COLOR;
    [self.view sd_addSubviews:@[_bgScroller]];
    _bgScroller.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(GAO);
   
    _dataArrr=[[NSMutableArray alloc]initWithObjects:@"信息发布",@"商机锁定",@"信息重发(/天)",@"商铺布置(/周)",@"外圈宣传(/周)", nil];
    
    [self HeaderImageView];
    
    
    
}
-(NSMutableDictionary*)plistDuqu{
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"message.plist"];
    NSMutableDictionary *writeData=[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    // NSLog(@"write data is :%@",writeData);
//    NSString *messageID=[writeData objectForKey:@"messageID"];
//    NSString* userName =[writeData objectForKey:@"lianxiren"];
//    NSString*phoneNumber  =[writeData objectForKey:@"shoujihao"];

    return writeData;
    
}
-(void)HeaderImageView
{
   
    NSDictionary * dicc = [self plistDuqu];
    NSString * picUrl =[dicc objectForKey:@"touxianga"];
    NSString * name =[dicc objectForKey:@"lianxiren"];
    NSString * comname =[dicc objectForKey:@"gongsi"];
    
    
    imageview =[UIImageView new];
    imageview.image=[UIImage imageNamed:@"背景图"];
    UIButton * headBtn =[UIButton new];
    headBtn.layer.cornerRadius=85/2*KUAN/375;
    headBtn.clipsToBounds=YES;
    //可以更换头像
//    [headBtn setBackgroundImage:[UIImage imageNamed:@"头像"] forState:0];
    [headBtn sd_setImageWithURL:[NSURL URLWithString:picUrl] forState:0 placeholderImage:[UIImage imageNamed:@"头像"]];
    UILabel * nameLab =[UILabel new];
    UILabel * dextLab =[UILabel new];
    dextLab.alpha=.7;
    nameLab.font=[UIFont systemFontOfSize:15];
    dextLab.font=[UIFont systemFontOfSize:13];
    nameLab.text=name;//@"邱总";
    dextLab.text=comname;//@"江苏鸿达废旧物资回收有限公司";
   
    nameLab.textAlignment=NSTextAlignmentCenter;
    dextLab.textAlignment=1;
    
    [_bgScroller sd_addSubviews:@[imageview]];
    [imageview sd_addSubviews:@[headBtn,nameLab,dextLab]];
  
    UIView * view =_bgScroller;
    
    imageview.sd_layout
    .leftSpaceToView(view,0)
    .rightSpaceToView(view,0)
    .topSpaceToView(view,0)
    .heightIs(222);
    
    headBtn.sd_layout
    .centerXEqualToView(imageview)
    .centerYIs(75)
    .widthIs(85*KUAN/375)
    .heightIs(85*KUAN/375);
    
    nameLab.sd_layout
    .topSpaceToView(headBtn,5)
    .centerYEqualToView(headBtn)
    .heightIs(30)
    .centerXEqualToView(headBtn);
    
    dextLab.sd_layout
    .topSpaceToView(nameLab,5)
    .centerYEqualToView(nameLab)
    .heightIs(30)
    .centerXEqualToView(nameLab);
    [nameLab setSingleLineAutoResizeWithMaxWidth:KUAN];
    [dextLab setSingleLineAutoResizeWithMaxWidth:KUAN];
    [self TowBtn];
}

-(void)TowBtn
{
    
    button1 =[UIButton new];
    button2 =[UIButton new];
    button1.tag=10;
    button2.tag=11;
    [button1 setTitle:@"会员特权" forState:0];
    [button2 setTitle:@"勋章墙" forState:0];
    [button1 setBackgroundImage:[UIImage imageNamed:@"灰色"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"白色"] forState:UIControlStateSelected];
    [button2 setBackgroundImage:[UIImage imageNamed:@"灰色"] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"白色"] forState:UIControlStateSelected];
    button1.selected=YES;
    button2.selected=NO;
    
    _lastBtn=button1;
    [button1 addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor blackColor] forState:0];
    [button2 setTitleColor:[UIColor blackColor] forState:0];
    [_bgScroller sd_addSubviews:@[button1,button2]];
    
    UIView * view =_bgScroller;
    button1.sd_layout
    .topSpaceToView(imageview,0)
    .leftSpaceToView(view,0)
    .heightIs(60)
    .widthIs(KUAN/2);
    button2.sd_layout
    .topSpaceToView(imageview,0)
    .rightSpaceToView(view,0)
    .heightIs(60)
    .widthIs(KUAN/2);
    
//
    
    
     [self  tableViewData];
}
-(void)tableViewData{
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        return;
    }
    
    [Engine getVipQuanXianKey:token success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"])
        {
            if ([dic objectForKey:@"Item3"]==[NSNull null])
            {
                return ;
            }
            NSArray * arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in arr )
            {
                VipQuanXianModel * model =[[VipQuanXianModel alloc]initWithVipDic:dicc];
                [_dataArray addObject:model];
            }
            
        }
        
        // [_tableView reloadData];
        [self Twotableview];
    } error:^(NSError *error) {
        
    }];
}

-(void)Twotableview{
    
   
   _tableView =[UITableView new];
    _tableView.backgroundColor=COLOR;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.scrollEnabled=NO;
    [_bgScroller sd_addSubviews:@[_tableView]];
   
    UIView * view =_bgScroller;
    _tableView.sd_layout
    .leftSpaceToView(view,0)
    .rightSpaceToView(view,0)
    .topSpaceToView(button1,0)
    .heightIs(44*_dataArray.count+1);
    
    [self ShengJiTeQuan];
}
//升级特权
-(void)ShengJiTeQuan
{
    UIButton * tequanBtn =[UIButton new];
    tequanBtn.backgroundColor=[UIColor whiteColor];
    [tequanBtn setTitle:@"升级特权" forState:0];
    [tequanBtn setTitleColor:[UIColor redColor] forState:0];
    [tequanBtn addTarget:self action:@selector(shengjitequan) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[tequanBtn]];
    UIView * view =self.view;
    tequanBtn.sd_layout
    .bottomSpaceToView(view,0)
    .heightIs(50)
    .leftSpaceToView(view,0)
    .rightSpaceToView(view,0);
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VipTeQuanCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[VipTeQuanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    VipQuanXianModel * model=_dataArray[indexPath.row];
    if (indexPath.row==0) {
        cell.label1.alpha=.7;
        cell.label2.alpha=.7;
        cell.btn.alpha=.7;
        cell.label1.text=@"操作权限";
        cell.label2.text=@"总条数";
        [cell.btn setTitle:@"剩余条数" forState:0];
    }else{
        cell.model=model;
//        cell.label1.text=_dataArrr[indexPath.row];
//        cell.label2.text=@"wafa";
//        [cell.btn setTitle:@"button" forState:0];
    }
    
    
    return cell;
}

-(void)button:(UIButton*)btn
{
    _lastBtn.selected=NO;
    btn.selected=YES;
    _lastBtn=btn;
    
}


//升级特权的连接
-(void)shengjitequan
{
    ShengJiTeQuanVC * vc =[ShengJiTeQuanVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)backWrite
{
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
