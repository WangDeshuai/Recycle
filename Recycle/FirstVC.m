//
//  FirstVC.m
//  Recycle
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FirstVC.h"
#import "CustomCell.h"
#import "SearchVC1.h"
#import "GongQiuVC.h"
#import "FirstModel.h"
#import "ZiXunViewController.h"
#import "BaoJiaViewController.h"
#import "ZongHeVC.h"
#import "XiangXiVC1.h"
#import "CityChooseVC.h"
#import "ProvinceModel.h"
#import "HYData.h"//首页存储热门行业
#import "HYPeople.h"
#import "CityData.h"//城市存储
#import "CityPeople.h"
#import "UIButtonImageWithLable.h"
@interface FirstVC ()<UICollectionViewDataSource,UICollectionViewDelegate,CLLocationManagerDelegate,SDCycleScrollViewDelegate>
{
   // UICollectionView *_collectionView ;
    UIImageView * remenImage;
    ZongHeVC * zhvc;
    UIButton * cityBtn;
    int pageYeshu;
    NSString * ciddClass;
//    HYData *dao;
    //CityData * cityDao;
    NSString * strCid;
    UILabel * cityLable;
    UIImageView * imageJT;
}
@property(nonatomic,retain)NSMutableArray * dataArr1;
@property(nonatomic,retain)NSMutableArray * dataArr2;//猜你喜欢
//这几个数租就是为了筛选code通过定位得到的城市
@property(nonatomic,retain)NSMutableArray * dataCityName;
@property(nonatomic,retain)NSMutableArray * dataCityCode;
@property(nonatomic,retain)NSMutableArray * dataShengCode;
@property(nonatomic,retain)UICollectionView *collectionView;

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    dao = [[HYData alloc]init];
//    [dao connectSqlite];
    
//    cityDao=[[CityData alloc]init];
//    [cityDao connectSqlite];
    
     zhvc =[ZongHeVC new];
     zhvc.hidesBottomBarWhenPushed=YES;
    pageYeshu=1;
     self.view.backgroundColor=COLOR;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBarHidden=YES;
    [self.navigationItem setTitle:@"首页"];
    _dataArr1=[NSMutableArray new];
    _dataArr2=[NSMutableArray new];
    _dataCityName=[NSMutableArray new];
    _dataCityCode=[NSMutableArray new];
    _dataShengCode=[NSMutableArray new];
    //城市定位放到轮播图里面加载了
    UICollectionViewFlowLayout * flowLawyou =[UICollectionViewFlowLayout new];
    //item大小
    flowLawyou.itemSize = CGSizeMake((KUAN-35)/2, (KUAN-35)/2.5);
    //行间距
    flowLawyou.minimumLineSpacing=20;
    flowLawyou.minimumInteritemSpacing=15;
    //视图的四个边距离父视图四个边的距离
    if (KUAN==320&&GAO==480){
        flowLawyou.sectionInset = UIEdgeInsetsMake(730*GAO/667, 10, 56, 10);
    }else{
        flowLawyou.sectionInset = UIEdgeInsetsMake(650*GAO/667, 10, 56, 10);
    }
    
    //集合 表（视图）继承与 UIScrollView
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLawyou];
    _collectionView.pagingEnabled = NO;
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    //默认是黑色的，需要设置才能显示
    _collectionView.backgroundColor = COLOR;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[CustomCell class] forCellWithReuseIdentifier:@"cell"];
    //返回顶端
    UIButton * xiangShangBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    xiangShangBtn.frame=CGRectMake(KUAN-20-40, GAO-56-40, 40, 40);
    
    [xiangShangBtn setBackgroundImage:[UIImage imageNamed:@"向上箭头"] forState:0];
    [xiangShangBtn addTarget:self action:@selector(dingduan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiangShangBtn];
    
    [self FirstLunBo];//轮播图
    [self SixBtn];//6个按钮
    [self remenLabel];//解析热门行业数据
    [self likePage:@"1"Cid:@"0"];//猜你喜欢
    [self CreatReashTableview];
}


-(void)CreatReashTableview{
    _collectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
}
-(void)footerRefresh{
    [_collectionView.footer endRefreshing];
    pageYeshu++;
    NSString*pageYS =[NSString stringWithFormat:@"%d",pageYeshu];
    // [self baojiaData:pageYS bgClass:cidClass];
  //  NSLog(@"page页数%d",pageYeshu);
//    NSLog(@"ciddClass=%@",ciddClass);
    if (strCid) {
        //NSLog(@"strCid=%@",strCid);
        [self likePage:pageYS Cid:strCid];
    }else{
        [self likePage:pageYS Cid:ciddClass];
    }
    
}

#pragma mark --  猜你喜欢数据解析
-(void)likePage:(NSString*)yeshu Cid:(NSString*)cid
{
    //行业选择的哪个传递哪个id
    [WINDOW showHUDWithText:@"加载中..." Type:ShowLoading Enabled:YES];
    [Engine getShouyeCainiLikeCid:cid Pagesize:@"10" Page:yeshu success:^(NSDictionary *dic) {
        NSArray * array =[dic objectForKey:@"Item3"];
        [WINDOW showHUDWithText:@"加载成功" Type:ShowPhotoYes Enabled:YES];
        for (NSDictionary * dicc in array) {
            FirstModel * model2 =[[FirstModel alloc]initWithLike:dicc];
            [_dataArr2 addObject:model2];
        }
        
        [_collectionView reloadData];
    } error:^(NSError *error) {
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr2.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
  //  cell.backgroundColor = [UIColor whiteColor];
//    cell.image1.image=[UIImage imageNamed:@"pic"];
//    cell.lab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    FirstModel * md=_dataArr2[indexPath.row];
    cell.model=md;
    //cell.backgroundColor=[UIColor redColor];
    return cell;

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XiangXiVC1 * vc =[XiangXiVC1 new];
    vc.tagg=1;
    FirstModel * model2 =_dataArr2[indexPath.row];
    vc.messageID=model2.messageID;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma marc -- 首页轮播图
-(void)FirstLunBo
{
    NSMutableArray * array = [NSMutableArray new];
    [Engine GetFirstLunBosuccess:^(NSDictionary *dic) {
       // NSLog(@">>%@",dic);
        NSArray * arr =[dic objectForKey:@"Item3"];
        for (NSDictionary * dicc in arr) {
            NSString * picUrl =[dicc objectForKey:@"pic"];
            [array addObject:picUrl];
        }
        
        [self remoteImageLoaded:array];
    } error:nil];
}




//获取网络图片
- (void)remoteImageLoaded:(NSArray*)arr{
   
    CGFloat  gg =165 * GAO/667;
   
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, KUAN, gg) delegate:self placeholderImage:[UIImage imageNamed:@"publicTou"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    [_collectionView addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = arr;
    });
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        // NSLog(@">>>>>  %ld", (long)index);
        
    };
    
    
    [self sousuoBtn];
    [self CityDingWei];//城市定位
}
#pragma mark -- 首页搜索及定位
-(void)sousuoBtn
{
  
   
  
    UIImageView * imagebg=[UIImageView new];
    imagebg.image=[UIImage imageNamed:@"请输入类别或关键字"];
    imagebg.userInteractionEnabled=YES;
    
    UIButton * zongheBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [zongheBtn setBackgroundImage:[UIImage imageNamed:@"综合"] forState:0];
    [zongheBtn addTarget:self action:@selector(zonghebtn) forControlEvents:UIControlEventTouchUpInside];
    [_collectionView sd_addSubviews:@[imagebg,zongheBtn]];
    
    imagebg.sd_layout
    .topSpaceToView(_collectionView,30)
    .leftSpaceToView(_collectionView,20)
    .rightSpaceToView(_collectionView,60)
    .heightIs(40);
    
    zongheBtn.sd_layout
    .leftSpaceToView(imagebg,10)
    .widthIs(30)
    .centerYEqualToView(imagebg)
    .heightEqualToWidth();
    
    
    UIButton *  souSuoBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [souSuoBtn addTarget:self action:@selector(sousuoBtnn) forControlEvents:UIControlEventTouchUpInside];
    
 
   
    
    NSString*name= [[NSUserDefaults standardUserDefaults]objectForKey:@"cityname"];
     cityBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    if (name) {
        [cityBtn setTitle:name forState:0];
    }else{
       [cityBtn setTitle:@"请选择城市" forState:0];
    }
    cityBtn.tag=2;
    [cityBtn addTarget:self action:@selector(citiChoose) forControlEvents:UIControlEventTouchUpInside];
    cityBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [cityBtn setTitleColor:[UIColor blackColor] forState:0];
    [imagebg sd_addSubviews:@[souSuoBtn,cityBtn]];
    
    imageJT =[UIImageView new];
    imageJT.image=[UIImage imageNamed:@"下箭头"];
    [cityBtn sd_addSubviews:@[imageJT]];
    
    souSuoBtn.sd_layout
    .topSpaceToView(imagebg,7)
    .leftSpaceToView(imagebg,100)
    .rightSpaceToView(imagebg,10)
    .heightRatioToView(imagebg,.7);
    
 
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGFloat g=[cityBtn.titleLabel.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    cityBtn.sd_layout
    .centerYEqualToView(imagebg)
    .leftSpaceToView(imagebg,10)
    .widthIs(g)
    .heightIs(25);
   
    imageJT.sd_layout
    .leftSpaceToView(cityBtn,g)
    .widthIs(15)
    .heightIs(10)
    .centerYEqualToView(cityBtn);
    
    

    
    
}

#pragma mark -- 供求资产6button
-(void)SixBtn
{
    CGFloat k = (KUAN-7*2)/6;
    
    for (int i = 0; i<6; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(2+(2+k)*i, 200*GAO/667, k, k);
        btn.tag=i;
        [btn addTarget:self action:@selector(btnSix:) forControlEvents:UIControlEventTouchUpInside];
        NSString * ss =[NSString stringWithFormat:@"first%d",i];
        [btn setBackgroundImage:[UIImage imageNamed:ss] forState:0];
        [_collectionView addSubview:btn];
    }
    
}

#pragma mark --热门行业Labe
-(void)remenLabel
{
    remenImage =[UIImageView new];
    remenImage.image=[UIImage imageNamed:@"热门行业"];
    UIButton * chankanMore =[UIButton new];
    [chankanMore setBackgroundImage:[UIImage imageNamed:@"more"] forState:0];
        remenImage.frame=CGRectMake(15, 275*GAO/667, 139/2, 17);
        chankanMore.frame=CGRectMake(KUAN-15-142/2, 275*GAO/667, 142/2, 30/2);
    [chankanMore addTarget:self action:@selector(chanKanMore) forControlEvents:UIControlEventTouchUpInside];
    [_collectionView addSubview:remenImage];
    [_collectionView addSubview:chankanMore];
     [self jiexiDataReMen];
    
    
    
    
}
-(void)chanKanMore{
    GongQiuVC * vc =[GongQiuVC new];
    vc.titleName=@"供应";
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -- 热门行业数据解析
-(void)jiexiDataReMen{
    
  
    
    [Engine HuoquFirstHangYesuccess:^(NSDictionary *dic) {
         NSArray * array =[dic objectForKey:@"Item3"];
        [WINDOW showHUDWithText:@"数据加载中..." Type:ShowDismiss Enabled:YES];
        for (NSDictionary * dicc in array )
        {
            FirstModel * md =[[FirstModel alloc]initWithDic:dicc];
            [_dataArr1 addObject:md];
            //NSLog(@"名字是%@",md.Onename);
        }
        [self sixMoKuai];
    } error:^(NSError *error) {
         [WINDOW showHUDWithText:@"网络超时请稍后重试" Type:ShowPhotoNo Enabled:YES];
    }];
    
    
    
    
//    [Engine HuoQuFirstHangYeMessageType:@"0" success:^(NSDictionary *dic) {
//        NSArray * array =[dic objectForKey:@"Item3"];
//        [WINDOW showHUDWithText:@"数据加载中..." Type:ShowDismiss Enabled:YES];
//        for (NSDictionary * dicc in array )
//        {
//           FirstModel * md =[[FirstModel alloc]initWithDic:dicc];
//            [_dataArr1 addObject:md];
//             //NSLog(@"名字是%@",md.Onename);
//          //  [self saveShuJuKu:md.Onename Cid:md.Cid PY:md.pinYin name1:md.Onename name2:@""];
//            
//        }
//        
//      
//
//        
//        [self sixMoKuai];
//    } error:^(NSError *error) {
//        [WINDOW showHUDWithText:@"网络超时请稍后重试" Type:ShowPhotoNo Enabled:YES];
//    }];
    
}
#pragma mark -- 存到数据库
-(void)saveShuJuKu:(NSString*)name Cid:(NSString*)cid PY:(NSString*)py name1:(NSString*)name1 name2:(NSString*)name2
{
  
   // [dao insertPeopleWithName:name Name1:name1 Name2:name2 Name3:@"name3" Name4:@"name4" Cid:cid PinYin:py];
}





#pragma mark --6个模块
-(void)sixMoKuai
{
    CGFloat a =(KUAN-45)/2;
    CGFloat b =(KUAN-45)/3.5;
    CGFloat g = remenImage.frame.size.height+remenImage.frame.origin.y+10;
    //NSLog(@">>>%f",g);
    for (int i = 0; i<6; i++) {
        int c= i%2;
        int d =i/2;
        FirstModel * md =_dataArr1[i];//如果运行首页崩掉，说明i>数组个数
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(15+(a+15)*c, g+(b+10)*d, a, b);
        btn.backgroundColor=[UIColor whiteColor];
        [btn addTarget:self action:@selector(sixMoKuaiBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
      //  [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:0];
       //label1
        UILabel * label1 =[UILabel new];
        label1.text=md.Onename;//@"车床设备";
       
        label1.alpha=.7;
        label1.font=[UIFont systemFontOfSize:15];
        label1.textColor=[UIColor redColor];
        [btn sd_addSubviews:@[label1]];
        label1.sd_layout
        .topSpaceToView(btn,10)
        .leftSpaceToView(btn,10)
        .autoHeightRatio(0);
        [label1 setSingleLineAutoResizeWithMaxWidth:150];
      
        
        for (int ii =0; ii<md.chirdArr.count; ii++) {
            NSDictionary * dicc  =md.chirdArr[ii];
            FirstModel * mm = [[FirstModel alloc]initWithDic:dicc];
            CGFloat aa =(a-16)/2;
            CGFloat bb =aa/3;//每一个Label的、高度根据aa计算得来
            CGFloat aaa=[Engine getWidthWithFontSize:13 height:bb string:mm.Onename];
            int cc= ii%2;//每行显示2个
            int dd =ii/2;
            
           
            UILabel * lab =[UILabel new];
            lab.font=[UIFont systemFontOfSize:13];
            lab.textColor=[UIColor blackColor];
            lab.frame=CGRectMake(10+(aaa+3)*cc, label1.frame.size.height+35+(bb+3)*dd, aaa, bb);
            //lab.backgroundColor=[UIColor redColor];
            lab.text=mm.Onename;
           // NSLog(@"名字是%@",mm.Onename);
            
            btn.clipsToBounds=YES;
            [btn addSubview:lab];
        }
       
        
        [_collectionView addSubview:btn];
    
    }
    
    //猜你喜欢
    UIImageView * likeView=[UIImageView new];
    CGFloat gg;
    if (KUAN==320&&GAO==480) {
         gg =340*GAO/667;
    }else{
         gg =320*GAO/667;
    }
    
    likeView.frame=CGRectMake(KUAN/2-152/4, gg+(b+10)*2+b, 152/2, 34/2);
    likeView.image=[UIImage imageNamed:@"like(1)"];
    [_collectionView addSubview:likeView];
}


-(void)sixMoKuaiBtn:(UIButton*)btn{
    FirstModel * md =_dataArr1[btn.tag];
    GongQiuVC * vc =[GongQiuVC new];
     vc.hidesBottomBarWhenPushed=YES;
    vc.titleName=@"供求";
    vc.model=md;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -- 城市定位
-(void)CityDingWei
{
   //// NSLog(@"定位");
    
    if ([CLLocationManager locationServicesEnabled]) {
       
        _coder = [[CLGeocoder alloc]init];
        _manager = [[CLLocationManager alloc] init] ;
        _manager.delegate = self;
        //设置定位精度
        _manager.desiredAccuracy=kCLLocationAccuracyBest;
        _manager.distanceFilter = kCLLocationAccuracyHundredMeters;//每隔多少米定位一次（这里的设置为每隔百米)
        if (IOS8) {
            //使用应用程序期间允许访问位置数据
            [_manager requestWhenInUseAuthorization];
        }
        // 开始定位
        [_manager startUpdatingLocation];
        
    }
    else
    {
        NSLog(@"定位服务不可用");
    }
    
    
}

//位置发生改变的时候调用
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    
    CLLocation * location =[locations lastObject];
    //  NSLog(@"维度是%f精度是%f",location.coordinate.latitude,location.coordinate.longitude);
    //维度
    CLLocationDegrees lat = location.coordinate.latitude;
    //精度
    CLLocationDegrees lon = location.coordinate.longitude;
    
   NSString*name= [[NSUserDefaults standardUserDefaults]objectForKey:@"cityname"];
    if (name) {
        NSLog(@"已经定位好了，不需要再定位了");
        return;
    }else{
        //[WINDOW showHUDWithText:@"定位中请稍后..." Type:ShowLoading Enabled:YES];
        CLLocation * aLoc = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
        [_coder reverseGeocodeLocation:aLoc completionHandler:^(NSArray *placemarks, NSError *error)
        {
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * mark, NSUInteger idx, BOOL *stop)
            {
                //直接调用去找code
                [self CityDaga:[mark.addressDictionary objectForKey:@"City"]];
            }];
            
        }];
        
    }
    
   

}
//这个的主要目的就是获取全国所有城市，然后通过定位得到的城市筛选出code来
-(void)CityDaga:(NSString*)name1{
    
    
    [Engine getCityCode:nil success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"0"]) {
            //没查询成功
        }else
        {
            NSArray * item3 =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in  item3)
            {
                ProvinceModel * md =[[ProvinceModel alloc]initWithCitydic:dicc];
                [_dataCityName addObject:md.pName];
                [_dataCityCode addObject:md.pCode];
                [_dataShengCode addObject:md.pID];
              //  NSLog(@"看看");
              //  [cityDao insertPeopleWithName:md.pName Sname:md.pSname Pid:md.pID Code:md.pCode PinYin:md.pPinyin];
                
            }
       
        }
        [self searchCode:name1];
    } error:^(NSError *error) {
        
    }];
}
//根据定位得到的城市寻找code
-(void)searchCode:(NSString*)name1{
 
    for (int i = 0; i<_dataCityName.count; i++)
    {
        NSString * name2 =_dataCityName[i];
        if ([name2 isEqualToString:name1])
        {
            NSLog(@"这就是找到的code=%@",_dataCityCode[i]);
            [cityBtn setTitle:name1 forState:0];
            
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
            CGFloat g=[name1 boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
            cityBtn.sd_layout
            .widthIs(g);
            imageJT.sd_layout
            .leftSpaceToView(cityBtn,g);
           
            [[NSUserDefaults standardUserDefaults]setObject:name1 forKey:@"cityname"];
            [[NSUserDefaults standardUserDefaults]setObject:_dataCityCode[i] forKey:@"citycode"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [WINDOW showHUDWithText:@"定位成功" Type:ShowDismiss Enabled:YES];
        }
    }

}

//跳转搜索
-(void)sousuoBtnn
{
    NSLog(@"点击了搜索");
    SearchVC1 * vc1 =[SearchVC1 new];
    vc1.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc1 animated:YES];
    
}
//综合
-(void)zonghebtn
{
    // NSLog(@"点击了综合");
    [self.navigationController pushViewController:zhvc animated:YES];
    __weak __typeof(self)wself = self;
    zhvc.CidBlock=^(NSString*cid){
        NSLog(@">>>cid=%@",cid);
        ciddClass=cid;
        [wself.dataArr2 removeAllObjects];
        [wself likePage:@"1"Cid:cid];
    };
}
//城市选择
-(void)citiChoose//:(UIButton*)btn
{
      NSLog(@"点击了城市选择");
//        btn.selected=!btn.selected;
    CityChooseVC * vc =[CityChooseVC new];
    vc.citynameBlock=^(NSString*cityName,NSString*cityCode,NSString*shengCode)
    {
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGFloat g=[cityName boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
       [cityBtn setTitle:cityName forState:0];
        cityBtn.sd_layout
        .widthIs(g);
        
        imageJT.sd_layout
        .leftSpaceToView(cityBtn,g);
        //筛选城市之后记录到沙盒
        [[NSUserDefaults standardUserDefaults]setObject:cityName forKey:@"cityname"];
        [[NSUserDefaults standardUserDefaults]setObject:cityCode forKey:@"citycode"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
//供求资产6字
-(void)btnSix:(UIButton*)btn
{

     GongQiuVC * vc =[GongQiuVC new];
     vc.number1=btn.tag;
     vc.hidesBottomBarWhenPushed=YES;
    if(btn.tag==0){
        vc.titleName=@"供应";
         [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==1){
        vc.titleName=@"求购";
        
         [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==2){
         vc.titleName=@"资产处置";
         [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==3){
        //拍卖
        vc.titleName=@"拍卖";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==4){
        //资讯
        ZiXunViewController * vcc =[ZiXunViewController new];
        vcc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vcc animated:YES];

        
    }else if (btn.tag==5){
        //报价
        BaoJiaViewController * vcc =[BaoJiaViewController new];
        vcc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vcc animated:YES];

    }



}




//返回顶端
-(void)dingduan:(UIButton*)btn
{
 [_collectionView setContentOffset:CGPointZero animated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
   NSString * ss= [[NSUserDefaults standardUserDefaults]objectForKey:@"key1"];
    if (ss==nil) {
        [self.navigationController pushViewController:zhvc animated:YES];
        __weak __typeof(self)wself = self;
        zhvc.CidBlock=^(NSString*cid){
            NSLog(@">>>刚开始选择的cid=%@",cid);
                strCid=cid;
                [wself.dataArr2 removeAllObjects];
                [wself.collectionView reloadData];
                [wself likePage:@"1"Cid:cid];
            
            
        };
    }else{
        return;
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

@end
