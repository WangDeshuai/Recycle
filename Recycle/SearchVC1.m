//
//  SearchVC1.m
//  Recycle
//
//  Created by mac on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SearchVC1.h"
#import "LrdOutputView.h"
#import "GongQiuModel.h"
#import "XiangXiVC1.h"
#import "SearchDao.h"
#import "SearchTableView.h"//搜索列表页面
#import "ZuiJinSearch.h"
#import "GongQiuVC.h"
@interface SearchVC1 ()<LrdOutputViewDelegate>
{
    UIButton * gongYingBtn;
    UITextField * textfield;
    NSInteger indexMenu;
    NSInteger buttonTagg;
    SearchDao * _dao;
}
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) LrdOutputView *outputView;
@property(nonatomic,retain)UIButton *lastBtn;
@property(nonatomic,assign)NSInteger seleNumber;
@property(nonatomic,retain)NSMutableArray*popArr;
@property(nonatomic,retain)NSMutableArray*dataArray;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray*btnArray;

@end

@implementation SearchVC1
-(void)viewWillAppear:(BOOL)animated{
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航1"] forBarMetrics:3];
    [self.tableView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航1"] forBarMetrics:3];
    _dataArray=[NSMutableArray new];
    _btnArray=[NSMutableArray new];
    buttonTagg=0;
    //返回
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
   
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame=CGRectMake(5,27, 19/2, 29/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:0];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    //供应
    gongYingBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    gongYingBtn.frame=CGRectMake(4+19/2, 39, 98/2, 30/2);
    gongYingBtn.backgroundColor=[UIColor redColor];
    [gongYingBtn setBackgroundImage:[UIImage imageNamed:@"搜索菜单"] forState:0];
    gongYingBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [gongYingBtn setTitle:@"供应" forState:0];
    [gongYingBtn addTarget:self action:@selector(gongying:) forControlEvents:UIControlEventTouchUpInside];
    [gongYingBtn setTitleColor:[UIColor blackColor] forState:0];
    UIBarButtonItem * leftBtn2 =[[UIBarButtonItem alloc]initWithCustomView:gongYingBtn];
    //搜索框
    textfield=[UITextField new];
    textfield.layer.cornerRadius=5;
    textfield.clipsToBounds=YES;
    textfield.layer.borderWidth=1;
    textfield.layer.borderColor=[[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1]CGColor];
    textfield.center=CGPointMake(self.view.center.x, 27);
    textfield.bounds=CGRectMake(0, 0, KUAN-170, 30);
    textfield.placeholder=@"   请输入类别或者关键字";
    textfield.font=[UIFont systemFontOfSize:14];
    UIBarButtonItem * leftBtn3 =[[UIBarButtonItem alloc]initWithCustomView:textfield];
    self.navigationItem.leftBarButtonItems=@[leftBtn,leftBtn2,leftBtn3];
//放大镜
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(KUAN-60, 27, 25, 25);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"放大镜"] forState:0];
    [rightBtn addTarget:self action:@selector(searchBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self TwoBtn];
   
    
 //下拉菜单
    _popArr=[[NSMutableArray alloc]initWithObjects:@"供应",@"求购",@"处置",@"拍卖", nil];
    LrdCellModel *one = [[LrdCellModel alloc] initWithTitle:@"供应" imageName:@"0"];
    LrdCellModel *two = [[LrdCellModel alloc] initWithTitle:@"求购" imageName:@"1"];
    LrdCellModel *three = [[LrdCellModel alloc] initWithTitle:@"处置" imageName:@"2"];
    LrdCellModel *four = [[LrdCellModel alloc] initWithTitle:@"拍卖" imageName:@"3"];
    self.dataArr = @[one, two, three, four];
     [self WhereJieMianCome];
  
}
//点击的搜索
-(void)searchBtn{
    if ([textfield.text isEqualToString:@""]) {
        [WINDOW showHUDWithText:@"请输入搜索条件" Type:ShowPhotoNo Enabled:YES];
    }else{
        NSLog(@"输出的菜单%lu",indexMenu);
        if (indexMenu==0 || indexMenu==1) {
            SearchTableView * vc =[SearchTableView new];
            vc.number=indexMenu;
            vc.titleName=textfield.text;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            GongQiuVC * gongVC =[GongQiuVC new];
            if (indexMenu==2) {
                gongVC.titleName=[NSString stringWithFormat:@"资产-%@",textfield.text];
            }else{
                gongVC.titleName=[NSString stringWithFormat:@"拍卖-%@",textfield.text];
            }
            gongVC.guanjianzi=textfield.text;
            gongVC.number1=indexMenu;
            [self.navigationController pushViewController:gongVC animated:YES];
            
        }
        
        
        
        
        
        
        
       [self searchGet:textfield.text type:indexMenu];
        
        
        
        
        
    }
    
}
-(void)searchGet:(NSString*)sting type:(NSInteger)type{
     [self.navigationController.view endEditing:YES];
     NSString * ss = [NSString stringWithFormat:@"%ld",(long)type];
    [Engine geQianTaiSearchLieBiaoSWord:sting  GID:ss success:^(NSDictionary *dic) {
        NSString * item2 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item2"]];
        if ([item2 isEqualToString:@"0"]) {
           //item2=0的话就是没有数据
        }else{
            [self saveSqlite];
        }
        
    } error:^(NSError *error) {
    }];
    
}
//用户输入的内容储存到数据库,相同的数据储存一次就可以
-(void)saveSqlite{
    if ([textfield.text isEqualToString:@""])
    {
        //空数据不可以储存
    }else
    {
        _dao=[[SearchDao alloc]init];
        [_dao connectSqlite];
        NSArray * arr =[_dao searchAllPeople];
        if (arr==nil || arr.count==0)
        {
            //代表数组为空，可以存储
            [_dao insertPeopleWithName:textfield.text];
        }else
        {
          
            for (ZuiJinSearch * p in arr)
            {
                if ([p.name isEqualToString:textfield.text])
                {
                    //相同的不用存储,把相同的移除
                    [_dao deleteWithPeople:p];
                }
            }
            [_dao insertPeopleWithName:textfield.text];
        }
        
    }
    
}

//最近搜索和热门搜索
-(void)TwoBtn
{
    NSArray * array =[NSArray arrayWithObjects:@"最近搜索",@"热门搜索", nil];
    
    for (int i = 0; i<2; i++) {
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(30+((KUAN-60)/2)*i, 10,(KUAN-60)/2, (KUAN-60)/6);
        button.tag=i;
        [button setTitle:array[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"write"] forState:0];
        [button setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateSelected];
        
        if (i==0) {
            button.selected=YES;
             _lastBtn=button;
        }
        [button addTarget:self action:@selector(sousuo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
   
    [self dataGuanjianZi];
}

//网络请求解析搜索关键字
-(void)dataGuanjianZi{
    if (buttonTagg==0) {
        [self mokuai:nil];
    }else{
       // [WINDOW showHUDWithText:@"数据切换中..." Type:0 Enabled:YES];
    }
    
    [Engine HuoQuSearchYeMessagesuccess:^(NSDictionary *dic) {
       // [WINDOW showHUDWithText:@"切换成功" Type:ShowPhotoYes Enabled:YES];
       NSMutableArray* arr1 =[dic objectForKey:@"Item3"];
        [self mokuai:arr1];
    } error:^(NSError *error) {
        [WINDOW showHUDWithText:@"网络请求超时" Type:ShowPhotoNo Enabled:YES];
    }];
    
}


//模块
-(void)mokuai:(NSMutableArray*)arr
{
    NSMutableArray * array=nil;
   
    SearchDao * dd=nil;
    if (dd==nil) {
        dd=[[SearchDao alloc]init];
       [dd connectSqlite];
    }
   
    NSArray * chaXunArr = [dd searchAllPeople];
    NSLog(@">>>查询的歌声%lu",chaXunArr.count);
    if (buttonTagg==0) {
        array=[[NSMutableArray alloc]init];
        NSArray * arr = [dd searchAllPeople];
        for (ZuiJinSearch * p in arr) {
            [array addObject:p.name];
        }
        
    }else{
        [array removeAllObjects];
        array=arr;
    }
    //间隔
    CGFloat x =5;
    CGFloat y =0;
    //大小
    CGFloat a =(KUAN-x*5)/4;
    CGFloat b =(KUAN-x*5)/7;
   //(KUAN-60)/6+10 上面button的高度
    CGFloat g =(KUAN-60)/6+10+20;
    //移除btn，防止重用，内存增加
    [self remeoBtn];
        for (int i =0 ; i<array.count; i++)
        {
            CGFloat c =i%4;
            CGFloat d =i/4;
            UIButton* btn =[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"搜索btn"] forState:0];
            btn.frame=CGRectMake(5+(a+x)*c, g+(y+b)*d, a, b);
            btn.titleLabel.font=[UIFont systemFontOfSize:15];
            [btn setTitle:array[i] forState:0];
            [btn setTitleColor:[UIColor blackColor] forState:0];
            btn.tag=i;
            [btn addTarget:self action:@selector(buttonClink:) forControlEvents:UIControlEventTouchUpInside];
            [_btnArray addObject:btn];
            [self.view addSubview:btn];
        }
   
    
}
-(void)buttonClink:(UIButton*)btn
{
    if (indexMenu==0 || indexMenu==1) {
        SearchTableView * vc =[SearchTableView new];
        vc.number=indexMenu;
        vc.titleName=btn.titleLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        GongQiuVC * vc =[GongQiuVC new];
        vc.number1=indexMenu;
        if (indexMenu==2) {
            vc.titleName=[NSString stringWithFormat:@"资产-%@",btn.titleLabel.text];
        }else{
            vc.titleName=[NSString stringWithFormat:@"拍卖-%@",btn.titleLabel.text];
        }
        vc.guanjianzi=btn.titleLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}
-(void)remeoBtn{
    
    for (UIButton * btn in _btnArray)
    {
        [btn removeFromSuperview];
    }
    
}


-(void)gongying:(UIButton*)btn
{
    CGFloat x = btn.center.x-20;
    CGFloat y = btn.frame.origin.y + btn.bounds.size.height + 25;
    _outputView = [[LrdOutputView alloc] initWithDataArray:self.dataArr origin:CGPointMake(x, y) width:70 height:34 direction:kLrdOutputViewDirectionLeft];
    _outputView.fount=15;
    _outputView.delegate = self;
    _outputView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        _outputView = nil;
    };
    [_outputView pop];

    
    
}
- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
  
       indexMenu=indexPath.row;
    //[self searchGet:textfield.text type:indexMenu];
    [gongYingBtn setTitle:_popArr[indexPath.row] forState:0];

}
-(void)WhereJieMianCome{
    if (_tagg) {
         indexMenu=_tagg;
         [gongYingBtn setTitle:_popArr[_tagg] forState:0];
    }else{
        return;
    }
}
-(void)sousuo:(UIButton*)btn
{
    _lastBtn.selected=NO;
    btn.selected=YES;
    _lastBtn=btn;
    buttonTagg=btn.tag;
    
   
    
    
    [self dataGuanjianZi];
}

-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController.view endEditing:YES];
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
