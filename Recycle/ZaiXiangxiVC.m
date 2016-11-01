//
//  ZaiXiangxiVC.m
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZaiXiangxiVC.h"
#import "ZaiXiangxiCell.h"
#import "PublicXiaoXiVC.h"
@interface ZaiXiangxiVC ()<UITableViewDataSource,UITableViewDelegate>
{
    vipIDModel * vipmodel;
}
@property(nonatomic,retain)NSMutableArray * shangJiArray;

@property(nonatomic,retain)UITableView * tableView;
@end

@implementation ZaiXiangxiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
   
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
  //  _shangJiArray=[NSMutableArray new];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"五角星"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
     [self dataJiXi];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled=NO;
    _tableView.backgroundColor=COLOR;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];

    [self.view addSubview:_tableView];



    UIButton * publishBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setBackgroundImage:[UIImage imageNamed:@"publishBtn"] forState:0];
    publishBtn.center=CGPointMake(self.view.center.x, self.view.center.y+100);
    [publishBtn addTarget:self action:@selector(publishBtn:) forControlEvents:UIControlEventTouchUpInside];
    publishBtn.bounds=CGRectMake(0, 0, 680/2, 97/2);
    [publishBtn setTitle:@"发消息" forState:0];
    [_tableView addSubview:publishBtn];
   

}


-(void)dataJiXi{
    
    NSString * idd ;
    if (_yonghuID) {
        idd=_yonghuID;
    }else{
        idd=_gmodel.youHuID;
    }
    [Engine getHuiYuanMessageUid:idd success:^(NSDictionary *dic) {
        if ([dic objectForKey:@"Item3"]==[NSNull null]) {
            
        }else{
            //直接设置全局的不用添加到数组，就只有1条数据
           vipmodel=[[vipIDModel alloc]initWithDic:[dic objectForKey:@"Item3"]];
             [self.navigationItem setTitle:vipmodel.commperName];
        }
        if([dic objectForKey:@"Item4"]==[NSNull null]){
           
        }else{
            _shangJiArray =[dic objectForKey:@"Item4"];
        }
        [_tableView reloadData];
    } error:nil];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }else{
        return 1;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZaiXiangxiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[ZaiXiangxiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
   NSDictionary * dicc =_shangJiArray[0];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.lab1.text=@"地区";
            cell.contentLab.text=vipmodel.diquName;//_gmodel.diQu;
        }
    }if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.lab1.text=@"主营业务";
           cell.contentLab.text=vipmodel.zhuyingYewu;//_gmodel.usercontent;
        }
    }if (indexPath.section==2) {
        if (indexPath.row==0) {
            cell.image2.hidden=NO;
           [cell.image2 sd_setImageWithURL:[NSURL URLWithString:[dicc objectForKey:@"gq_pro_pic"]] placeholderImage:[UIImage imageNamed:@"图片站位图"]];
            cell.lab1.text=@"商机信息";
        }
    }
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        return 120;
    }else if (section==1){
        return 20;
    }else{
        return 20;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 120)];
    view1.backgroundColor=COLOR;
    UIButton * imagebtn =[UIButton buttonWithType:UIButtonTypeCustom];
    imagebtn.layer.cornerRadius=170/4;
    imagebtn.clipsToBounds=YES;
    [imagebtn setBackgroundImageForState:0 withURL:[NSURL URLWithString:vipmodel.headUrl] placeholderImage:[UIImage imageNamed:@"头像"]];
    //[imagebtn setBackgroundImage:[UIImage imageNamed:@"头像"] forState:0];
    UILabel * nameLab =[UILabel new];
    nameLab.text=vipmodel.titleName;//_gmodel.username;
    UILabel * contentLab=[UILabel new];
    contentLab.text=vipmodel.commperName;//_gmodel.companyName;
    contentLab.adjustsFontSizeToFitWidth=YES;
   // contentLab.backgroundColor=[UIColor redColor];
    contentLab.textColor=[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1];
    [view1 sd_addSubviews:@[imagebtn,nameLab,contentLab]];
    
    imagebtn.sd_layout
    .topSpaceToView(view1,20)
    .leftSpaceToView(view1,20)
    .widthIs(170/2)
    .heightIs(170/2);
    
    nameLab.sd_layout
    .topSpaceToView(view1,25)
    .leftSpaceToView(imagebtn,10)
    .heightIs(30);
    [nameLab setSingleLineAutoResizeWithMaxWidth:KUAN];
    contentLab.sd_layout
    .topSpaceToView(nameLab,5)
    .leftEqualToView(nameLab)
    .rightSpaceToView(view1,10)
    .heightIs(30);//高度改成自适应
    
    
    
    if (section==0) {
        return view1;
    }
    
    else{
        
        return nil;
    }
    
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 44;
        }
    }else if (indexPath.section==1){
        
        if (indexPath.row==0) {
            return 64;
        }
    }else{
        
        if (indexPath.row==0) {
            return 100;
        }
        
    }
    return 100;
}


//左按钮呢
-(void)backWrite
{
    [self.navigationController popViewControllerAnimated:YES];
}
//右按钮
//-(void)rightBtn{
//    
//}

//发送消息
-(void)publishBtn:(UIButton*)publishBtn
{
    
    
    if (![LoginModel isLogin]) {
        LoginVC * vc =[LoginVC new];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    //点击发消息，得把发给谁的ID传到下个界面（不用传所有的model了）
    PublicXiaoXiVC * vc =[PublicXiaoXiVC new];
    //_gmodel.youHuID是上个界面传过来的用户ID，不是_dataArray获得的
    vc.whoMessageID=_gmodel.youHuID;
    vc.titleName=_gmodel.username;
    vc.headImage=vipmodel.headUrl;
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
