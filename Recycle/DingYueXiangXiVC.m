//
//  DingYueXiangXiVC.m
//  Recycle
//
//  Created by Macx on 16/6/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DingYueXiangXiVC.h"
#import "CityChooseVC.h"
#import "MessageLaiYuanVC.h"
@interface DingYueXiangXiVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITextField * textfiled;
    NSString * nameLable1;
    NSString * cityName;
    NSString * cityCode;
    MessageLaiYuanVC * messvc;
    CityChooseVC * cityvc;
}
@property(nonatomic,retain)UITableView* tableView;
@end

@implementation DingYueXiangXiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self danghang];
    [self.view addSubview:[self CreatTableView]];
    messvc =[MessageLaiYuanVC new];
    __weak typeof(self) weakSelf =self;
    messvc.nameBlock=^(NSString*name){
        nameLable1=name;
        [weakSelf.tableView reloadData];
    };
    cityvc =[CityChooseVC new];
    cityvc.citynameBlock=^(NSString*name,NSString*code,NSString*shengCode){
        cityName=name;
        cityCode=code;
        [weakSelf.tableView reloadData];
    };



}

-(UITableView*)CreatTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _tableView.tableHeaderView=[self headView];
    [_tableView addSubview:[self CreatButton]];
    return _tableView;
}


-(UIButton*)CreatButton{
    UIButton * dingYueBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    dingYueBtn.center=CGPointMake(_tableView.center.x, 200);
    dingYueBtn.bounds=CGRectMake(0, 0, 286/2, 96/2);
    [dingYueBtn addTarget:self action:@selector(dingYueBtnClink:) forControlEvents:UIControlEventTouchUpInside];
    [dingYueBtn setBackgroundImage:[UIImage imageNamed:@"订阅详细"] forState:0];
    return dingYueBtn;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * idd =@"Cell";
    UITableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:idd];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
        UILabel * nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(60, 10, KUAN, 24)];
        nameLabel.tag=1;
        [cell addSubview:nameLabel];
    }
    
    UILabel * nameLable =[cell viewWithTag:1];
    nameLable.font=[UIFont systemFontOfSize:14];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.textLabel.alpha=.7;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row==0) {
        cell.textLabel.text=@"区域:";
        if (cityName) {
             nameLable.text=cityName;
        }else{
            nameLable.text=@"请选择地区";//可变到时候改为别的
        }
      
    }else{
        cell.textLabel.text=@"来源:";
        if (nameLable1) {
            nameLable.text=nameLable1;
        }else{
            nameLable.text=@"请选择来源";
        }
        //可变到时候改为别的
    }
    
    return cell;
}

-(UIView*)headView{
    UIView * bgView =[UIView new];
    bgView.frame=CGRectMake(0, 0, KUAN, 70);
    bgView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    
    UILabel * leftLabel =[UILabel new];
    textfiled =[UITextField new];
    textfiled.returnKeyType=UIReturnKeyDone;
    textfiled.delegate=self;
  
   
    
    leftLabel.text=@"订阅条件:";
    leftLabel.alpha=.7;
    leftLabel.font=[UIFont systemFontOfSize:15];
    textfiled.layer.borderWidth=1;
    textfiled.layer.borderColor=[[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]CGColor];
    textfiled.placeholder=@"   请输入订阅条件,如设备名称型号";
    textfiled.font=[UIFont systemFontOfSize:13];
    [bgView sd_addSubviews:@[leftLabel,textfiled]];
    
    leftLabel.sd_layout
    .leftSpaceToView(bgView,15)
    .topSpaceToView(bgView,20)
    .heightIs(20);
    [leftLabel setSingleLineAutoResizeWithMaxWidth:120];
    
    
    textfiled.sd_layout
    .leftSpaceToView(leftLabel,15)
    .rightSpaceToView(bgView,20)
    .heightIs(40)
    .centerYEqualToView(leftLabel);
    
    
    return bgView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        
        [self.navigationController pushViewController:cityvc animated:YES];
    }else{
        [self.navigationController pushViewController:messvc animated:YES];
    }
    
}
//提交
-(void)dingYueBtnClink:(UIButton*)btn{
    [self tijiao];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_tableView endEditing:YES];
}
-(void)tijiao
{
  
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    NSLog(@">>>token>>>%@",token);
//    UIAlertController * alerview =[UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * action =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//    [alerview addAction:action];
    
    if (token==nil) {
//        alerview.message=@"请先登录";
//        [self presentViewController:alerview animated:YES completion:nil];
        [WINDOW showHUDWithText:@"请登录" Type:ShowPhotoNo Enabled:YES];
        return;
    }
   else if (nameLable1==nil || cityCode==nil) {
       [WINDOW showHUDWithText:@"请选择来源或者地区" Type:ShowPhotoNo Enabled:YES];
//        alerview.message=@"请选择来源或者地区";
//        [self presentViewController:alerview animated:YES completion:nil];
    }
    else{
        NSString * ss =[NSString stringWithFormat:@"%ld",(long)_type];
        //NSLog(@"我看看是那个界面%@",ss);
        [WINDOW showHUDWithText:@"订阅中请稍后..." Type:0 Enabled:YES];
        [Engine getMydingYueMessageToken:token TextFiled:textfiled.text Address:cityCode MessageLaiyuan:nameLable1 Type:ss success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoYes Enabled:YES];
            if ([item1 isEqualToString:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
          
        } error:^(NSError *error) {
            
        }];

    }
    
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_tableView  endEditing:YES];
    return YES;
}

-(void)danghang{
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:_titleName];
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
