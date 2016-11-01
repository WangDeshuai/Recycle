//
//  SearchTableView.m
//  Recycle
//
//  Created by Macx on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SearchTableView.h"
#import "MyWeiZhi.h"//供应求购
#import "ProvinceModel.h"
#import "LeftMyAdressCell.h"
#import "RightMyAddressCell.h"
#import "GongableCell.h"
#import "XiangXiVC1.h"
@interface SearchTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *bgview;
    int tagg;
    UIButton * btn1;
    UIButton * btn2;
    UIButton * btn3;
    int pageYeshu;
    //分别记录值
    NSString * citycodeText;
    NSString * hangYeText;
    NSString*vipText;
}
@property(nonatomic,retain)UITableView*leftTabelView;
@property(nonatomic,retain)UITableView*rightTabelView;
@property(nonatomic,retain)UITableView*mainTabelView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic,retain)NSMutableArray * shengArr;
@property(nonatomic,retain)NSMutableArray * cityArr;
@property(nonatomic,retain)NSMutableArray * cityDataArr;
@property(nonatomic,retain)NSMutableArray * BtnArr;
@property(nonatomic,retain)NSMutableArray * arrButton;
@end

@implementation SearchTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohang];
    [self mainTableView];
    [self StarArray];
    [self CreatBtnTitle:_BtnArr];
    [self searchGet];
    [self refreshtableView];
    [self CreatTopBtn];
}
-(void)StarArray{
     _BtnArr=[[NSMutableArray alloc]initWithObjects:@"地区",@"会员等级", nil];
    _dataArray=[[NSMutableArray alloc]init];
    _arrButton=[NSMutableArray new];
    _cityDataArr=[NSMutableArray new];
    bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64)];
    bgview.backgroundColor=[UIColor blackColor];
    bgview.alpha=.5;
    pageYeshu=1;
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [bgview addGestureRecognizer:tap];
}
-(void)tap:(UITapGestureRecognizer*)tap{
    [self dissmiss];
    btn1.selected=NO;
    btn2.selected=NO;
    btn3.selected=NO;
    
}
-(void)dissmiss{
    _mainTabelView.scrollEnabled=YES;
    [bgview removeFromSuperview];
    [_leftTabelView removeFromSuperview];
    [_rightTabelView removeFromSuperview];
}
//刷新界面
-(void)refreshtableView{
    _mainTabelView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    _mainTabelView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}
-(void)headerRefresh{
    [_mainTabelView.header endRefreshing];
    
}
-(void)footerRefresh{
    [_mainTabelView.footer endRefreshing];
    pageYeshu++;
    [self whereGuolai:[NSString stringWithFormat:@"%d",pageYeshu]];
    NSLog(@"page页数%d",pageYeshu);
}
-(void)whereGuolai:(NSString*)page{
    
//    if (_number==0) {
//        //从供应过来的
//        [self dataJieXiDiQu:page PinYin:hangYeText vip:vipText DiquCode:citycodeText];
//    }else if (_number==1){
//        //从求购过来的
//        [self qiuGouPage:page PinYin:hangYeText vip:vipText DiquCode:citycodeText];
//    }
    
    [self searchAddress:citycodeText VipJiBie:vipText Page:page];
    
}
//创建筛选的2个按钮
-(void)CreatBtnTitle:(NSMutableArray*)arr{
    
    CGFloat k =(KUAN-10)/arr.count;///3-20;
    CGFloat g =40;
    UIButton *  menuBtn=nil;
    [_arrButton removeAllObjects];
    if (menuBtn==nil) {
        for (int i = 0; i<arr.count; i++) {
            menuBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
            menuBtn.backgroundColor=[UIColor whiteColor];
            [menuBtn setTitleColor:[UIColor blackColor] forState:0];
            menuBtn.titleLabel.font=[UIFont systemFontOfSize:15];
            menuBtn.tag=i;
            [menuBtn setImage:[UIImage imageNamed:@"xia123"] forState:UIControlStateNormal];
            [menuBtn addTarget:self action:@selector(butTitleClink:) forControlEvents:UIControlEventTouchUpInside];
            menuBtn.frame=CGRectMake(0+(k+5)*i, 0, k, g);
            [menuBtn setTitle:arr[i] forState:0];
            [menuBtn setImage:[UIImage imageNamed:@"shang123"] forState:UIControlStateSelected];
            [menuBtn setImageEdgeInsets:UIEdgeInsetsMake(0,k-20, 0, 0)];
            [menuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [menuBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [_arrButton addObject:menuBtn];
            [self.view addSubview:menuBtn];
        }
        
    }else{
        
        NSLog(@"btn不为空");
    }
    
    
}
-(void)butTitleClink:(UIButton*)btn{
    btn.selected=!btn.selected;
    tagg=(int)btn.tag;
    if (btn.tag==0) {
        if (btn.selected==YES) {
            _mainTabelView.scrollEnabled=NO;
            [_mainTabelView setContentOffset:CGPointZero animated:NO];
            [_mainTabelView addSubview:bgview];
            [_rightTabelView removeFromSuperview];
            [_leftTabelView removeFromSuperview];
            [self CreatLeftTableVeiw];
            btn2.selected=NO;
            btn3.selected=NO;
        }else{
            [self dissmiss];
        }
        btn1=btn;
    }else if (btn.tag==1){
        if (btn.selected==YES) {
            _mainTabelView.scrollEnabled=NO;
            [_mainTabelView setContentOffset:CGPointZero animated:NO];
            btn1.selected=NO;
            btn3.selected=NO;
            [_mainTabelView addSubview:bgview];
            [_leftTabelView removeFromSuperview];
            [_cityArr removeAllObjects];
            _cityArr=nil;
            _cityArr=[[NSMutableArray alloc]initWithObjects:@"不限",@"普通会员", @"高级会员",@"企业会员",nil];
            [self CreatRightTableView:KUAN Xzhou:0 Gzhou:44*_cityArr.count];
        }else{
            [self dissmiss];
            
        }
        btn2=btn;
    }
    
    
}

-(void)mainTableView{
    _mainTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, KUAN, GAO-64-44) style:UITableViewStylePlain];
    _mainTabelView.dataSource=self;
    _mainTabelView.delegate=self;
    [self.view addSubview:_mainTabelView];
}
-(void)CreatLeftTableVeiw{
    [UIView animateWithDuration:.5 animations:^{
        
    }];
    _leftTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, KUAN/2.5, GAO/1.5) style:UITableViewStylePlain];
    _leftTabelView.dataSource=self;
    _leftTabelView.delegate=self;
    _leftTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _shengArr=[NSMutableArray new];
    _cityArr=[NSMutableArray new];
    //[_shengArr addObject:@"不限"];
    [self.view addSubview:_leftTabelView];
    [self shengShuJuData];
    
}
-(void)CreatRightTableView:(CGFloat)kuan Xzhou:(CGFloat)x Gzhou:(CGFloat)g{
    [_rightTabelView removeFromSuperview];
    _rightTabelView=nil;
    if (_rightTabelView==nil) {
        _rightTabelView=[[UITableView alloc]initWithFrame:CGRectMake(x, 40,kuan, g) style:UITableViewStylePlain];
        _rightTabelView.backgroundColor=COLOR;
        _rightTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _rightTabelView.dataSource=self;
        _rightTabelView.delegate=self;
        [self.view addSubview:_rightTabelView];
    }
    
}
-(void)shengShuJuData{
    
    [_shengArr removeAllObjects];
//    tagg记录的是button的tag
    if (tagg==0) {
        //地区(无论哪个界面过来的地区都一样，不用分类)
        [Engine getAllProvincesuccess:^(NSDictionary *dic) {
            NSArray * array =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in array)
            {
                ProvinceModel* pmodel=[[ProvinceModel alloc]initWithDic:dicc];
                [_shengArr addObject:pmodel];
            }
            
            [_leftTabelView reloadData];
        } error:^(NSError *error) {
            
        }];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_leftTabelView) {
        return _shengArr.count;
    }else if (tableView==_rightTabelView){
        return _cityArr.count;
    }else{
        return _dataArray.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell1 =nil;
    if (tableView==_leftTabelView) {
        cell1 =[LeftMyAdressCell cellWithTableView:tableView];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        ProvinceModel* pmodel=_shengArr[indexPath.row];
        cell1.textLabel.text=pmodel.pName;
        cell1.textLabel.font=[UIFont systemFontOfSize:14];
        cell1.textLabel.textAlignment=1;
        return cell1;
    }else if (tableView==_rightTabelView){
        cell1 =[RightMyAddressCell cellWithTableView:tableView];
        cell1.textLabel.text=_cityArr[indexPath.row];//注意：_cityArr里面存的是字符串不是Model了
        cell1.textLabel.font=[UIFont systemFontOfSize:14];
        cell1.textLabel.textAlignment=1;
        
        return cell1;
    }else{
        
        GongableCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell=[[GongableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.gmodel=_dataArray[indexPath.row];
       
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTabelView) {
        ProvinceModel* pmodel=_shengArr[indexPath.row];
       // HangYeClassModel * md =_shengArr[indexPath.row];
        [self CreatRightTableView:KUAN-KUAN/2.5 Xzhou:KUAN/2.5 Gzhou:GAO/1.5];
        [_cityArr removeAllObjects];
        [self dataCity:pmodel];
            
        
    }else if (tableView==_rightTabelView){
        //筛选结果显示button的标题
        UIButton* btn= _arrButton[tagg];
        if(btn==btn1){
            ProvinceModel* pmodel=_cityDataArr[indexPath.row];
            citycodeText=pmodel.pCode;
        }
        else if (btn==btn2){
             vipText=[self zidiang:_cityArr[indexPath.row]];
        }
        [self shaiXuan];
        btn.selected=NO;
        [btn setTitle:_cityArr[indexPath.row] forState:0];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [self dissmiss];
    }else{
        GongQiuModel * mm =_dataArray[indexPath.row];
        //判断是从哪个界面过来的
        XiangXiVC1 * vc =[XiangXiVC1 new];
        vc.number=_number;//从哪个界面过来的
        vc.messageID=mm.messageID;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    
}
-(void)shaiXuan{
    pageYeshu=1;
    NSString * yeshu =[NSString stringWithFormat:@"%d",pageYeshu];
    [_dataArray removeAllObjects];
    [_mainTabelView setContentOffset:CGPointZero animated:YES];
    [self searchAddress:citycodeText VipJiBie:vipText Page:yeshu];
}


-(void)dataCity:(ProvinceModel*)model{
    [_cityArr removeAllObjects];
    [_cityDataArr removeAllObjects];
    [Engine getCityCode:model.pCode success:^(NSDictionary *dic) {
        NSArray * array =[dic objectForKey:@"Item3"];
        for (NSDictionary * dicc in array)
        {
            ProvinceModel* pmodel=[[ProvinceModel alloc]initWithCitydic:dicc];
            [_cityArr addObject:pmodel.pName];
            [_cityDataArr addObject:pmodel];
        }
        [_rightTabelView reloadData];
    } error:nil];
}
//字典枚举类型(供应，求购)
-(NSString*)zidiang:(NSString*)name{
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:@"0" forKey:@"不限"];
    [dic setObject:@"1" forKey:@"普通会员"];
    [dic setObject:@"2" forKey:@"企业会员"];
    [dic setObject:@"3" forKey:@"高级会员"];
    NSString * vipp = [dic objectForKey:name];
    
    return vipp;
    
}


//搜索时调用的接口
-(void)searchGet{
    [WINDOW showHUDWithText:@"搜索中请稍后..." Type:ShowLoading Enabled:YES];
    NSString * ss = [NSString stringWithFormat:@"%ld",(long)_number];
   
    [Engine geQianTaiSearchLieBiaoSWord:_titleName  GID:ss success:^(NSDictionary *dic) {
        NSString * item2 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item2"]];
        
        if ([item2 isEqualToString:@"0"]) {
            //item2=0的话就是没有数据
            [WINDOW showHUDWithText:@"没有查找到相关数据" Type:ShowPhotoNo Enabled:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [WINDOW showHUDWithText:@"数据加载成功" Type:ShowPhotoYes Enabled:YES];
            //[self saveSqlite];
            NSArray * item3 =[dic objectForKey:@"Item3"];
            [_dataArray removeAllObjects];
            for (NSDictionary * dicc in item3) {
                GongQiuModel * md =[[GongQiuModel alloc]initWithDic:dicc];
                [_dataArray addObject:md];
            }
        }
        
        [_mainTabelView reloadData];
    } error:^(NSError *error) {
        [WINDOW showHUDWithText:@"网络超时" Type:ShowPhotoNo Enabled:YES];
    }];
    
    
}
-(void)searchAddress:(NSString*)diqu VipJiBie:(NSString*)vip Page:(NSString*)page {
    
     [WINDOW showHUDWithText:@"数据加载中..." Type:ShowLoading Enabled:YES];
     NSString * ss = [NSString stringWithFormat:@"%ld",(long)_number];
    [Engine geQianTaiSearchLieBiaoSWord:_titleName Address:diqu VipJibie:vip Page:page GID:ss success:^(NSDictionary *dic) {
         NSString * item2 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item2"]];
        if ([item2 isEqualToString:@"0"]) {
            //item2=0的话就是没有数据
            [WINDOW showHUDWithText:@"没有查找到相关数据" Type:ShowPhotoNo Enabled:YES];
        }else{
            [WINDOW showHUDWithText:@"数据加载成功" Type:ShowPhotoYes Enabled:YES];
            //[self saveSqlite];
            NSArray * item3 =[dic objectForKey:@"Item3"];
           // [_dataArray removeAllObjects];
            for (NSDictionary * dicc in item3) {
                GongQiuModel * md =[[GongQiuModel alloc]initWithDic:dicc];
                [_dataArray addObject:md];
            }
        }
        
        [_mainTabelView reloadData];
    } error:^(NSError *error) {
        
    }];
    
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==_leftTabelView) {
        return 44;
    }else if (tableView==_rightTabelView){
        return 44;
    }else{
        return 100;
    }
    
}
-(void)CreatTopBtn
{
    UIButton * xiangShangBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat ff;
    if (KUAN<375) {
        ff = (GAO-80-40)*GAO/568;
    }else if (KUAN==376){
        ff=(GAO-80-40)*GAO/667;
    }
    else{
        ff = (GAO-80-40)*GAO/736;
    }
    
    // NSLog(@">>>%f",GAO);
    xiangShangBtn.frame=CGRectMake(KUAN-20-40,ff, 40, 40);
    [xiangShangBtn setBackgroundImage:[UIImage imageNamed:@"向上箭头"] forState:0];
    [xiangShangBtn addTarget:self action:@selector(dingduan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiangShangBtn];
}

-(void)dingduan:(UIButton*)top{
    [_mainTabelView setContentOffset:CGPointZero animated:YES];
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
-(void)daohang{
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite11) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems=@[leftBtn];
    
    //发布
    UIButton *fabu=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabu setBackgroundImage:[UIImage imageNamed:@"fabu"] forState:0];
    fabu.frame=CGRectMake(KUAN-41/2-10,27, 41/2, 37/2);
    [fabu addTarget:self action:@selector(fapu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    self.navigationItem.rightBarButtonItems=@[rightBtn];
    
    NSString * titleName;
    if (_number==0) {
        titleName  =[NSString stringWithFormat:@"供应-%@",_titleName];
    }else{
        titleName  =[NSString stringWithFormat:@"求购-%@",_titleName];
    }
    [self.navigationItem setTitle:titleName];
}
-(void)fapu{
    if (_number==0) {
        MyWeiZhi * gongying =[MyWeiZhi new];
        gongying.titleName=@"供应信息发布";
        gongying.typee=@"1";
        [self.navigationController pushViewController:gongying animated:YES];
        
    }else if (_number==1){
        MyWeiZhi * gongying =[MyWeiZhi new];
        gongying.titleName=@"求购信息发布";
        gongying.typee=@"2";
        [self.navigationController pushViewController:gongying animated:YES];
        
    }
}
//返回按钮
-(void)backWrite11
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
