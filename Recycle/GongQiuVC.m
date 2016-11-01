//
//  GongQiuVC.m
//  Recycle
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GongQiuVC.h"
#import "GongableCell.h"
#import "LrdSuperMenu.h"
#import "XiangXiVC1.h"
#import "ProvinceModel.h"
#import "GongQiuModel.h"
#import "PaiMaiVC.h"
#import "MyWeiZhi.h"//供应求购
#import "ZiChanFaBuVC.h"//资产发布
#import "PaiMaiPublicVC.h"//拍卖发布
#import "LeftMyAdressCell.h"
#import "RightMyAddressCell.h"
#import "HangYeClassModel.h"//行业选择Demo
#import "SearchVC1.h"//搜索
#import "HYData.h"//存储行业
#import "HYPeople.h"//存储行业
#import "CityData.h"//存储城市
#import "CityPeople.h"//存储城市
@interface GongQiuVC ()<UITableViewDataSource,UITableViewDelegate>
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
    CityData * cdao;
    HYData * hdao;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)UITableView*leftTabelView;
@property(nonatomic,retain)UITableView*rightTabelView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic,retain)NSMutableArray * shengArr;
@property(nonatomic,retain)NSMutableArray * cityArr;
@property(nonatomic,retain)NSMutableArray * cityDataArr;
@property(nonatomic,retain)NSMutableArray * BtnArr;
@property(nonatomic,retain)NSMutableArray * arrButton;

@end

@implementation GongQiuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self daohang];
    [self whereGuolai:@"1"];
    [self mainTableView];
    if(_number1==2){
        //资产
        _BtnArr=[[NSMutableArray alloc]initWithObjects:@"地区",@"时间",@"行业", nil];
    }else if (_number1==3){
        //拍卖
        _BtnArr=[[NSMutableArray alloc]initWithObjects:@"地区",@"时间",@"行业", nil];
    }
    else{
        //供求
         _BtnArr=[[NSMutableArray alloc]initWithObjects:@"地区",@"会员等级",@"行业", nil];
    }
    _dataArray=[[NSMutableArray alloc]init];
    _arrButton=[NSMutableArray new];
    _cityDataArr=[NSMutableArray new];
    sCityCode=[NSMutableArray new];
    sShengArr=[NSMutableArray new];
    bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64)];
    bgview.backgroundColor=[UIColor blackColor];
    bgview.alpha=.5;
    pageYeshu=1;
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [bgview addGestureRecognizer:tap];
    
    [self CreatBtnTitle:_BtnArr];
    [self refreshtableView];
    [self CreatTopBtn];
}
-(void)tap:(UITapGestureRecognizer*)tap{
    [self dissmiss];
    btn1.selected=NO;
    btn2.selected=NO;
    btn3.selected=NO;
    
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
  [_tableView setContentOffset:CGPointZero animated:YES];
}


//刷新界面
-(void)refreshtableView{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}
-(void)headerRefresh{
     [_tableView.header endRefreshing];
    
}
-(void)footerRefresh{
    [_tableView.footer endRefreshing];
    pageYeshu++;
    [self whereGuolai:[NSString stringWithFormat:@"%d",pageYeshu]];
    NSLog(@"page页数%d",pageYeshu);
}



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
            if (_model) {
                if (i==2) {
                [menuBtn setTitle:_model.Onename forState:0];
                }
            }
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"cityname"]) {
                if (i==0) {
                    [menuBtn setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"cityname"] forState:0];
                }
            }
            
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
            _tableView.scrollEnabled=NO;
            [_tableView setContentOffset:CGPointZero animated:NO];
            [_tableView addSubview:bgview];
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
            _tableView.scrollEnabled=NO;
             [_tableView setContentOffset:CGPointZero animated:NO];
            btn1.selected=NO;
            btn3.selected=NO;
            [_tableView addSubview:bgview];
            [_leftTabelView removeFromSuperview];
            [_cityArr removeAllObjects];
            _cityArr=nil;
            if (_number1==2) {
                 _cityArr=[[NSMutableArray alloc]initWithObjects:@"不限",@"1天内", @"3天内",@"5天内",@"7天内",@"15天内",nil];
            }else if (_number1==3){
                 _cityArr=[[NSMutableArray alloc]initWithObjects:@"全部",@"拍卖预告",@"一周内结束", @"未结束拍卖",@"推荐信息",nil];
            }
            else{
                _cityArr=[[NSMutableArray alloc]initWithObjects:@"不限",@"普通会员", @"高级会员",@"企业会员",nil];
            }
           
            [self CreatRightTableView:KUAN Xzhou:0 Gzhou:44*_cityArr.count];
        }else{
            [self dissmiss];
            
        }
        btn2=btn;
    }else if(btn.tag==2){
        //行业选择
        if (btn.selected==YES)
        {
            _tableView.scrollEnabled=NO;
             [_tableView setContentOffset:CGPointZero animated:NO];
            btn2.selected=NO;
            btn1.selected=NO;
            [_rightTabelView removeFromSuperview];
            [_leftTabelView removeFromSuperview];
            [_tableView addSubview:bgview];
            if(_number1==3){
                //拍卖
                [_cityArr removeAllObjects];
                 _cityArr=nil;
                [self PaiMaiArrData];
            }else{
                //供应，求购，资产
                [self CreatLeftTableVeiw];
            }
            
            
        }else{
            [self dissmiss];
        }
        btn3=btn;
    }

    
    
}
#pragma mark --拍卖分类
//拍卖分类
-(void)PaiMaiArrData{
    _cityArr=[NSMutableArray new];
    [_cityDataArr removeAllObjects];
    [Engine getPaiMaiHangYesuccess:^(NSDictionary *dic) {
        NSString * item =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item isEqualToString:@"1"]) {
            NSArray * arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in arr ) {
              HangYeClassModel * model =[[HangYeClassModel alloc]initWithPaiMaiDic:dicc];
                [_cityArr addObject:model.titleName];
                [_cityDataArr addObject:model];
            }
        }
         [self CreatRightTableView:KUAN Xzhou:0 Gzhou:44*_cityArr.count];
    } error:nil];
    
  }
-(void)dissmiss{
    _tableView.scrollEnabled=YES;
    [bgview removeFromSuperview];
    [_leftTabelView removeFromSuperview];
    [_rightTabelView removeFromSuperview];
}
-(void)CreatLeftTableVeiw{
   
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
-(void)mainTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, KUAN, GAO-64-44) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}
#pragma mark -- 省份数据解析
-(void)shengShuJuData{
    
   [_shengArr removeAllObjects];
    [sShengArr removeAllObjects];
    cdao =[[CityData alloc]init];
    [cdao connectSqlite];
    hdao=[[HYData alloc]init];
    [hdao connectSqlite];
    if (tagg==0) {
        
        NSArray * arr =[cdao searchAllPeople];
        if(arr.count>=34){
            isFirst=NO;
            sShengArr=[cdao shengFenChaXun];
            [_leftTabelView reloadData];
        }else{
            isFirst=YES;
            //地区(无论哪个界面过来的地区都一样，不用分类)
            [Engine getAllProvincesuccess:^(NSDictionary *dic) {
                NSArray * array =[dic objectForKey:@"Item3"];
                for (NSDictionary * dicc in array)
                {
                    ProvinceModel* pmodel=[[ProvinceModel alloc]initWithDic:dicc];
                    [_shengArr addObject:pmodel];
                }
                [self saveCityData];
                [_leftTabelView reloadData];
            } error:^(NSError *error) {
                
            }];

        }
        
    }else if (tagg==2)
    {
         NSArray * arr =[hdao searchAllPeople];
        if (arr.count==0) {//说明是首次运行
            isFirst=YES;
            [self diaoYongJieKou:1];
        }else{
            [Engine GengXinHuanCunsuccess:^(NSDictionary *dic) {
                NSDictionary * dicc =[dic objectForKey:@"Item3"];
                NSString*time =[dicc objectForKey:@"updatetime"];
                [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"timeHT"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
            } error:nil];
            NSString * time =[[NSUserDefaults standardUserDefaults]objectForKey:@"timeHT"];
            if ([Engine isUpdate:time]==YES) {
                NSLog(@"我要更新缓存");
                isFirst=YES;
                [self diaoYongJieKou:2];
            }else{
                isFirst=NO;
                sShengArr =[hdao LookTableViewLeft];
                [_leftTabelView reloadData];
            }
            
        }
    }

}

-(void)diaoYongJieKou:(NSInteger)tag{
    
    if (_number1==2) {
    //获取资产行业
        [self huoQuHangYe:tag];
    }else if(_number1==3){
    //获取拍卖行业
   }else{
    //获取求购行业
       [self huoQuHangYe:tag];
  }
}

//供求行业
-(void)huoQuHangYe:(NSInteger)tag{
    [Engine getGongQiuFenLeiClass:nil success:^(NSDictionary *dic)
     {
         NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
         if ([item1 isEqualToString:@"1"])
         {
             NSArray * item3 =[dic objectForKey:@"Item3"];
             for (NSDictionary * dicc in item3)
             {
                 HangYeClassModel * model =[[HangYeClassModel alloc]initWithOneDic:dicc];
                 [_shengArr addObject:model];
             }
             [self saveHangYeData:tag];
         }else
         {
         }
         [_leftTabelView reloadData];
     } error:nil];
}

#pragma mark -- 存储行业信息
-(void)saveHangYeData:(NSInteger)tag
{
    if (tag==1) {//说明是首次运行
        for (int i =0; i<_shengArr.count; i++) {
            HangYeClassModel * model=_shengArr[i];
            NSString * xuhao =[NSString stringWithFormat:@"%d",i];
            NSLog(@"首次运行存上了啊");
            [hdao insertPeopleWithName:model.titleName Name1:xuhao Name2:nil Name3:nil Name4:nil Cid:model.cid PinYin:model.pinYin];
        }
    }else{//说明是更新的
        //1先删除里面所有的元素
        NSArray *arr =[hdao searchAllPeople];
        for (HYPeople * p in arr) {
             NSLog(@"首次运行删除啊");
            [hdao deleteWithPeople:p];
        }
        //2.在重新存入数据
        for (int i =0; i<_shengArr.count; i++) {
            HangYeClassModel * model=_shengArr[i];
            NSString * xuhao =[NSString stringWithFormat:@"%d",i];
            NSLog(@"更新数据成功了啊");
            [hdao insertPeopleWithName:model.titleName Name1:xuhao Name2:nil Name3:nil Name4:nil Cid:model.cid PinYin:model.pinYin];
        }
        
    }
    
    
   
    
    
    
    
}


#pragma mark --存储省份数据
-(void)saveCityData{

    for (int i =0; i<_shengArr.count; i++) {
        ProvinceModel* md=_shengArr[i];
        NSString * xuhao =[NSString stringWithFormat:@"%d",i];
        [cdao insertPeopleWithName:md.pName Sname:md.pSname Pid:xuhao Code:md.pCode PinYin:md.pPinyin];
        }
    
}







-(void)whereGuolai:(NSString*)page{
    
    if (citycodeText==nil) {
         NSString* straCode=[[NSUserDefaults standardUserDefaults]objectForKey:@"citycode"];
        citycodeText=straCode;
    }
    
    if (_number1==0) {
        //从供应过来的
         [self dataJieXiDiQu:page PinYin:hangYeText vip:vipText DiquCode:citycodeText];
    }else if (_number1==1){
        //从求购过来的
        [self qiuGouPage:page PinYin:hangYeText vip:vipText DiquCode:citycodeText];
    }else if (_number1==2){
        //从资产过来的
       // [self zichanDataYeShu:page];
        [self zichanDataYeShu:page HangYe:hangYeText AdressCode:citycodeText Date:vipText];
    }else if (_number1==3){
        //从拍过来的
        //[self paiMaiLieBiaoData:page];
        [self paiMaiLieBiaoData:page Time:vipText DiQu:citycodeText Cid:hangYeText];
        
    }
}
-(void)fapu{
    
    if (![LoginModel isLogin]){
        LoginVC * vc = [LoginVC new];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    
    
    if (_number1==0) {
        MyWeiZhi * gongying =[MyWeiZhi new];
        gongying.titleName=@"供应信息发布";
        gongying.typee=@"1";
        [self.navigationController pushViewController:gongying animated:YES];

    }else if (_number1==1){
        MyWeiZhi * gongying =[MyWeiZhi new];
         gongying.titleName=@"求购信息发布";
        gongying.typee=@"2";
        [self.navigationController pushViewController:gongying animated:YES];
        
    }else if (_number1==2){
        ZiChanFaBuVC *vc =[ZiChanFaBuVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(_number1==3){
        PaiMaiPublicVC * paivc =[PaiMaiPublicVC new];
        [self.navigationController pushViewController:paivc animated:YES];
    }
   
}


//供应数据解析
-(void)dataJieXiDiQu:(NSString*)page PinYin:(NSString*)pinyin vip:(NSString*)jibie DiquCode:(NSString*)code
{
    [WINDOW showHUDWithText:@"数据加载中..." Type:ShowLoading Enabled:YES];
    
    
    
  //因为这是通过首页那6个大按钮点击进来的需要筛选啊
    NSString * PY=nil;
    if (_model) {
        PY=_model.pinYin;
    }else{
        PY=pinyin;
    }
    [Engine getQianTai:code MID:jibie Page:page Category:PY  success:^(NSDictionary *dic) {
        [WINDOW showHUDWithText:@"加载成功" Type:ShowPhotoYes Enabled:YES];
        NSMutableArray * item2Arr =[dic objectForKey:@"Item3"];
        for (NSDictionary * dicc in item2Arr) {
           GongQiuModel* gmodel1=[[GongQiuModel alloc]initWithDic:dicc];
            [_dataArray addObject:gmodel1];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
    }];
}

//求购数据解析
-(void)qiuGouPage:(NSString*)page PinYin:(NSString*)pinyin vip:(NSString*)jibie DiquCode:(NSString*)code
{
    [WINDOW showHUDWithText:@"数据加载中..." Type:ShowLoading Enabled:YES];

    [Engine getQiuGou:code MID:jibie Page:page Category:pinyin  success:^(NSDictionary *dic) {
         [WINDOW showHUDWithText:@"加载成功" Type:ShowPhotoYes Enabled:YES];
        NSMutableArray * item2Arr =[dic objectForKey:@"Item3"];
        for (NSDictionary * dicc in item2Arr) {
        GongQiuModel* gmodel1=[[GongQiuModel alloc]initWithDic:dicc];
            [_dataArray addObject:gmodel1];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

//资产数据解析
-(void)zichanDataYeShu:(NSString*)yeshu HangYe:(NSString*)hangye AdressCode:(NSString*)code Date:(NSString*)dateTime
{
    NSString * guanjianzi = nil;
    if (_guanjianzi) {
        guanjianzi=_guanjianzi;
    }else{
        guanjianzi=nil;
    }
    
    [WINDOW showHUDWithText:@"数据加载中..." Type:ShowLoading Enabled:YES];
    [Engine getZhiChanPage:yeshu Pagesize:@"10" Category:hangye Adds:code Date:dateTime GuanJianZi:guanjianzi  success:^(NSDictionary *dic) {
        NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        [WINDOW showHUDWithText:@"加载成功" Type:ShowPhotoYes Enabled:YES];
        if ([ss isEqualToString:@"1"]) {
            NSMutableArray * item2Arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in item2Arr) {
            GongQiuModel* gmodel2=[[GongQiuModel alloc]initWithZiChan:dicc];
            [_dataArray addObject:gmodel2];
            }

        }else{
            
        }
       [_tableView reloadData];

    } error:^(NSError *error) {
        
    }];
    
}

//拍卖列表
-(void)paiMaiLieBiaoData:(NSString*)yeshu Time:(NSString*)time DiQu:(NSString*)diqu Cid:(NSString*)cid
{
    [WINDOW showHUDWithText:@"数据加载中..." Type:ShowLoading Enabled:YES];
    NSString * guanjianzi = nil;
    if (_guanjianzi) {
        guanjianzi=_guanjianzi;
    }else{
        guanjianzi=nil;
    }
    //Time时间类型0：全部；1：拍卖预告；2：一周内结束；3：未结束拍卖；4：推荐信息
    [Engine getPaiMaicid:cid Pid:diqu Time:time Page:yeshu Pagesize:@"10" GuanJian:guanjianzi success:^(NSDictionary *dic) {
        [WINDOW showHUDWithText:@"加载成功" Type:ShowPhotoYes Enabled:YES];
        NSMutableArray * item2Arr =[dic objectForKey:@"Item3"];
        for (NSDictionary * dicc in item2Arr) {
            GongQiuModel* gmodel3=[[GongQiuModel alloc]initWithPaiMai:dicc];
            [_dataArray addObject:gmodel3];
        }
        [_tableView reloadData];
    } error:nil];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_leftTabelView) {
//        tagg 代表的是上面3个按钮的tag值，只有当tagg=0的时候，才有数据库
      //  if (tagg==0) {
            if (isFirst==YES) {
                return _shengArr.count;
            }else{
                return sShengArr.count;
            }
//        }else{
//         return _shengArr.count;
//        }
        
    }else if (tableView==_rightTabelView){
        return _cityArr.count;
    }else{
       return _dataArray.count;
    }
}
#pragma mark --表的展示
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell1 =nil;
    if (tableView==_leftTabelView) {
        cell1 =[LeftMyAdressCell cellWithTableView:tableView];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
        if (tagg==0) {
          
            if (isFirst==NO) {
                NSLog(@"数据库");
                CityPeople *pmodel2 =sShengArr[indexPath.row];
                cell1.textLabel.text=pmodel2.pname;
            }else{
                NSLog(@"首次运行获得的值");
                ProvinceModel* pmodel= _shengArr[indexPath.row];
                 cell1.textLabel.text=pmodel.pName;//第一次获取的网络数据
            }
            
        }
        //行业
        else if (tagg==2){
            if (isFirst==YES) {
                 NSLog(@"首次运行获行业的值");
                HangYeClassModel * md =_shengArr[indexPath.row];
                cell1.textLabel.text=md.titleName;
            }else{
                HYPeople * md =sShengArr[indexPath.row];
                 NSLog(@"数据库获取行业的值");
                cell1.textLabel.text=md.namehy;
            }
           
        }
        cell1.textLabel.font=[UIFont systemFontOfSize:14];
        cell1.textLabel.textAlignment=1;
        return cell1;
    }else if (tableView==_rightTabelView){
        cell1 =[RightMyAddressCell cellWithTableView:tableView];
        //ProvinceModel* pmodel=_cityArr[indexPath.row];
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
        if (_number1==3) {
            //拍卖列表没有image，坐标需要重新调整
            cell.image1.hidden=YES;
            cell.gmodel=_dataArray[indexPath.row];
            [cell sd_addSubviews:@[ cell.titleLab]];
            cell.titleLab.sd_layout
            .leftSpaceToView(cell,35)
            .rightSpaceToView(cell,10)
            .topSpaceToView(cell,10)
            .heightIs(30);
            
        }else{
            cell.gmodel=_dataArray[indexPath.row];
        }
        
        return cell;
    }
    
}

#pragma mark -- 点击表的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   
    if (tableView==_leftTabelView) {
       
        
        shengTag=(int)indexPath.row;
        [self CreatRightTableView:KUAN-KUAN/2.5 Xzhou:KUAN/2.5 Gzhou:GAO/1.5];
        [_cityArr removeAllObjects];
        if (tagg==0) {
            if (indexPath.row==0) {
                [[NSUserDefaults standardUserDefaults]setObject:@"不限" forKey:@"不限"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"不限"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            if (isFirst==YES) {
                ProvinceModel* pmodel=_shengArr[indexPath.row];
                [self dataCity:pmodel.pCode indePax:indexPath];
            }else{
                CityPeople *pmodel2 =sShengArr[indexPath.row];
                [self dataCity:pmodel2.pcode indePax:indexPath];
            }
            
        }else if (tagg==2){
            if (isFirst==YES) {
                HangYeClassModel * md =_shengArr[indexPath.row];
                [self erJiFenLei:md.pinYin indepax:indexPath];
            }else{
                HYPeople * md =sShengArr[indexPath.row];
                 [self erJiFenLei:md.pinyin indepax:indexPath];
            }
            
            
            
            
        }
        

    }else if (tableView==_rightTabelView){
        //筛选结果显示button的标题
        UIButton* btn= _arrButton[tagg];
        if(btn==btn1){
            if (isCity==YES) {
                if (indexPath.row==0) {
                        //
                 NSString * ss=[[NSUserDefaults standardUserDefaults]objectForKey:@"不限"];
                    if (ss) {
                        NSLog(@"不限");
                        citycodeText=@"buxian";//如果点击的是第0行（左右表都是第0行）
                    }else{
                       ProvinceModel* pmodel=_cityDataArr[indexPath.row];
                        citycodeText=pmodel.pID;//不限传的是省份ID
                   }
                    
                }else{
                    ProvinceModel* pmodel=_cityDataArr[indexPath.row-1];
                    citycodeText=pmodel.pCode;
                }
               
            }else{
                if (indexPath.row==0) {
                    NSLog(@"数据库的不限");
                    //不限 就传省份的code
                      NSString * ss=[[NSUserDefaults standardUserDefaults]objectForKey:@"不限"];
                    if (ss) {
                     citycodeText=@"buxian";
                    }else{
                        CityPeople * pmodel2 =_cityDataArr[indexPath.row];
                        citycodeText=pmodel2.psname;
                    }
                    
                    
                   
                    //NSLog(@"数据库是不是省份的code=%@",pmodel2.psname);
                }else{
                    CityPeople * pmodel2 =_cityDataArr[indexPath.row-1];
                    citycodeText=pmodel2.pcode;
                }
               
            }
            
            //citycodeText=sCityCode[indexPath.row];
        }else if (btn==btn3){
            if (_number1==3) {
                HangYeClassModel * mdel=_cityDataArr[indexPath.row];
                 hangYeText=mdel.pinYin;
            }else{
                if (isCity==YES) {
                HangYeClassModel * mdel=_cityDataArr[indexPath.row];
                hangYeText=mdel.pinYin;
                }
                else{
                    HYPeople * mdel =_cityDataArr[indexPath.row];
                    hangYeText=mdel.pinyin;
                }
            }
            
            
        }else if (btn==btn2){
            if(_number1==3){
                vipText=[self paiMai:_cityArr[indexPath.row]];
            }else if (_number1==2){
                //资产
                vipText=[self ziChan:_cityArr[indexPath.row]];
            }
            else{
                vipText=[self zidiang:_cityArr[indexPath.row]];
            }
        }
        [self shaiXuan];
        btn.selected=NO;
        [btn setTitle:_cityArr[indexPath.row] forState:0];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [self dissmiss];
    }else{
        GongQiuModel * mm =_dataArray[indexPath.row];
        //判断是从哪个界面过来的
        if(_number1==3){
            //从拍卖界面过来的，拍卖详细界面和其他界面不一样，需要新建
            PaiMaiVC * vc =[PaiMaiVC new];
            vc.messageID=mm.messageID;
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            XiangXiVC1 * vc =[XiangXiVC1 new];
            vc.number=_number1;//从哪个界面过来的
            vc.messageID=mm.messageID;
            vc.uidd=mm.uidd;
            NSLog(@"我看看有没有uid=%@",mm.uidd);
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
    
}

-(void)shaiXuan{
    pageYeshu=1;
    NSString * yeshu =[NSString stringWithFormat:@"%d",pageYeshu];
    [_dataArray removeAllObjects];
    [_tableView setContentOffset:CGPointZero animated:YES];
    if (_number1==0) {
        //从供应过来的
        [self dataJieXiDiQu:yeshu PinYin:hangYeText vip:vipText DiquCode:citycodeText];
    }else if (_number1==1){
        //从求购过来的
         [self qiuGouPage:yeshu PinYin:hangYeText vip:vipText DiquCode:citycodeText];
    }else if (_number1==2){
        //从资产过来的
        [self zichanDataYeShu:yeshu HangYe:hangYeText AdressCode:citycodeText Date:vipText];
        // NSLog(@"地区code%@,会员级别%@,行业拼音%@",citycodeText,vipText,hangYeText);
    }else if (_number1==3){
        //从拍过来的
        [self paiMaiLieBiaoData:yeshu Time:vipText DiQu:citycodeText Cid:hangYeText];
    }
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
//字典枚举类型(拍卖)
-(NSString*)paiMai:(NSString*)paimai{
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:@"0" forKey:@"全部"];
    [dic setObject:@"1" forKey:@"拍卖预告"];
    [dic setObject:@"2" forKey:@"一周内结束"];
    [dic setObject:@"3" forKey:@"未结束拍卖"];
    [dic setObject:@"4" forKey:@"推荐信息"];
    NSString * vipp = [dic objectForKey:paimai];
    
    return vipp;
}
//资产枚举类型(资产)
-(NSString*)ziChan:(NSString*)zichan{
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:@"0" forKey:@"不限"];
    [dic setObject:@"1" forKey:@"1天内"];
    [dic setObject:@"3" forKey:@"3天内"];
    [dic setObject:@"5" forKey:@"5天内"];
    [dic setObject:@"7" forKey:@"7天内"];
     [dic setObject:@"15" forKey:@"15天内"];
    NSString * vipp = [dic objectForKey:zichan];
    return vipp;
}
#pragma mark -- 根据省份选取城市
-(void)dataCity:(NSString*)modelcode indePax:(NSIndexPath*)indexpath{
    [_cityArr removeAllObjects];
    [_cityDataArr removeAllObjects];
    
    NSString * xuhao =[NSString stringWithFormat:@"c%lu",indexpath.row];
   //根据xuhao去查某个省的城市
    NSMutableArray * chaArr =[cdao genJuPid:xuhao];
   [_cityArr addObject:@"不限"];
    if (chaArr.count==0) {
        isCity=YES;
       
        [Engine getCityCode:modelcode success:^(NSDictionary *dic) {
            NSArray * array =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in array)
            {
                ProvinceModel* pmodel=[[ProvinceModel alloc]initWithCitydic:dicc];
                [_cityArr addObject:pmodel.pName];
                [sCityCode addObject:pmodel.pCode];//存放code
                [_cityDataArr addObject:pmodel];
            }
            [self saveCityData123];
            [_rightTabelView reloadData];
        } error:nil];
       
        return;
    }else{
        isCity=NO;
        for (CityPeople * pmodel in chaArr)
        {
            [_cityArr addObject:pmodel.pname];
             [sCityCode addObject:pmodel.pcode];
            [_cityDataArr addObject:pmodel];
        }
         [_rightTabelView reloadData];
    }
    
}

#pragma mark --存储城市数据
-(void)saveCityData123{
        for (int i =0; i<_cityDataArr.count; i++) {
            ProvinceModel* md=_cityDataArr[i];
            NSLog(@"城市的名字%d",shengTag);
            NSString * xuhao =[NSString stringWithFormat:@"c%d",shengTag];
            //pid是对应省的code，现在把Pid改成序号标示了，而Sname是城市里面对应省的code
            [cdao insertPeopleWithName:md.pName Sname:md.pID Pid:xuhao Code:md.pCode PinYin:md.pPinyin];
        }
   
    
    
    
}



//二级菜单数据解析
-(void)erJiFenLei:(NSString*)mdpinyin indepax:(NSIndexPath*)indexpath{
    [_cityArr removeAllObjects];
    [_cityDataArr removeAllObjects];
    [sCityCode removeAllObjects];
    NSString * xuhao =[NSString stringWithFormat:@"hy%lu",indexpath.row];
    //根据xuhao去查某个省的行业
    NSMutableArray * chaArr =[hdao genJuPid:xuhao];
    if (chaArr.count==0) {
        isCity=YES;
        [Engine getGongQiuFenLeiClass:mdpinyin success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"]) {
                
                NSArray * item3 =[dic objectForKey:@"Item3"];
                for (NSDictionary * dicc in item3) {
                    HangYeClassModel * model =[[HangYeClassModel alloc]initWithTwoDic:dicc];
                    [_cityArr addObject:model.titleName];
                    [_cityDataArr addObject:model];
                }
                [self saveHangYeData123];
            }else{
            }
            [_rightTabelView reloadData];
        } error:nil];
        return;
    }else{
        isCity=NO;
        NSLog(@"有值了%lu",chaArr.count);
        for (HYPeople * pmodel in chaArr)
        {
            [_cityArr addObject:pmodel.namehy];
            [sCityCode addObject:pmodel.pinyin];
            [_cityDataArr addObject:pmodel];
        }
        [_rightTabelView reloadData];
        
    }
    
    
}
#pragma mark --存储行业二级菜单
-(void)saveHangYeData123{
    for (int i =0; i<_cityDataArr.count; i++) {
        HangYeClassModel* md=_cityDataArr[i];
       // NSLog(@"存储行业二级菜单%d",shengTag);
        NSString * xuhao =[NSString stringWithFormat:@"hy%d",shengTag];
        [hdao insertPeopleWithName:md.titleName Name1:nil Name2:xuhao Name3:nil Name4:nil Cid:md.cid PinYin:md.pinYin];
    }
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==_leftTabelView) {
        return 44;
    }else if (tableView==_rightTabelView){
        return 44;
    }else{
        return 100;
    }
    
    
   // return 100;
}
//返回按钮
-(void)backWrite11
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self daohang];
}
-(void)daohang{
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:_titleName];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite11) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
     self.navigationItem.leftBarButtonItems=@[leftBtn];
    
    
    
       //放大镜
    UIButton *fangdajing=[UIButton buttonWithType:UIButtonTypeCustom];
    if (_guanjianzi) {
        fangdajing.hidden=YES;
    }else{
        fangdajing.hidden=NO;
    }
    [fangdajing setBackgroundImage:[UIImage imageNamed:@"Search"] forState:0];
    fangdajing.center=CGPointMake(self.view.center.x+10, 27);
    fangdajing.bounds=CGRectMake(0, 0, 38/2, 37/2);
    [fangdajing addTarget:self action:@selector(JumpSearch:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtn2 =[[UIBarButtonItem alloc]initWithCustomView:fangdajing];
   
    //发布
    UIButton *fabu=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabu setBackgroundImage:[UIImage imageNamed:@"fabu"] forState:0];
    fabu.frame=CGRectMake(KUAN-41/2-10,27, 41/2, 37/2);
    [fabu addTarget:self action:@selector(fapu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
   // self.navigationItem.rightBarButtonItems=@[rightBtn,rightBtn2,rightBtn2];
  
    //不知道为什么，就这么写他就会去中间
    
    
    
    
    if (KUAN<375) {
        self.navigationItem.rightBarButtonItems=@[rightBtn,rightBtn2,rightBtn2,rightBtn2,rightBtn2];
    }else{
        if (_number1==2) {
            self.navigationItem.rightBarButtonItems=@[rightBtn,rightBtn2,rightBtn2,rightBtn2,rightBtn2];
        }else{
             self.navigationItem.rightBarButtonItems=@[rightBtn,rightBtn2,rightBtn2,rightBtn2,rightBtn2,rightBtn2];
        }
        
    }
    
    
    

}
-(void)JumpSearch:(UIButton*)btn{
    SearchVC1 * vc =[SearchVC1 new];
    vc.tagg=_number1;
    [self.navigationController pushViewController:vc animated:YES];
    if (_number1==0) {
        //供应
    }else if (_number1==1){
        //求购
    }else if (_number1==2){
        //资产
    }else if (_number1==3){
        //拍卖
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [self dissmiss];
    btn1.selected=NO;
    btn2.selected=NO;
    btn3.selected=NO;
   // pageYeshu=0;
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
