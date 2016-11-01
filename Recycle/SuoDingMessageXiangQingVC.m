//
//  SuoDingMessageXiangQingVC.m
//  Recycle
//
//  Created by Macx on 16/6/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SuoDingMessageXiangQingVC.h"
#import "ZaiXiangxiVC.h"
#import "LiuYanVC.h"
#import "GongQiuXiangXiModel.h"
#import "ZYData.h"
#import "ZidingYiAlert.h"
@interface SuoDingMessageXiangQingVC ()<SDCycleScrollViewDelegate>
{
    UIView * view3;
    UIButton * view4;
    UIView * view2;
    UIView * view1;
    UIButton * button1;
    UIButton * button2;
    ZidingYiAlert *  alt;
}
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) UIScrollView *bgScroller;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *shangYitiaoArr;
@property (nonatomic, strong) NSMutableArray *xiaYitiaoArr;
@end

@implementation SuoDingMessageXiangQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangtiao];
    [self CreatArray];
    [self CreatButtonLiuYan];
    [self FirstLunBo];
    [self shuJuJieXiDataType:_number];
    
    
//    if (_number==0) {
//        //从供应过来的
//        [self DataJieXiMessageID:_messageID];
//    }else if (_number==1){
//        //从求购过来的
//        [self DataJieXiMessageID:_messageID];
//    }else if (_number==2){
//        //从资产过来的
//        [self DataZiChanMessageID:_messageID];
//    }

}
-(void)CreatArray{
    _shangYitiaoArr=[NSMutableArray new];
    _xiaYitiaoArr=[NSMutableArray new];
    _bgScroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    _bgScroller.contentSize=CGSizeMake(KUAN, GAO+230);
    _bgScroller.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:_bgScroller];
    _imageArr=[NSMutableArray new];
    _dataArr=[NSMutableArray new];
}
-(void)CreatButtonLiuYan{
    UIButton * OrderMessage =[UIButton buttonWithType:UIButtonTypeCustom];
    OrderMessage.frame=CGRectMake(0, GAO-45-64, KUAN, 45);
    [OrderMessage setBackgroundImage:[UIImage imageNamed:@"导航"] forState:0];
    [OrderMessage setTitle:@"在线留言" forState:0];
    [OrderMessage addTarget:self action:@selector(liuyan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:OrderMessage];

}


-(void)shuJuJieXiDataType:(NSString*)type{
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        return;
    }
    NSLog(@"我就是messageID=%@",_messageID);
    [self.dataArr removeAllObjects];
    [Engine getSuoDingXiangQingYeMianKey:token MessageID:_messageID Infoclass:type success:^(NSDictionary *dic) {
        NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        
        if ([type isEqualToString:@"2"]) {
            //资产解析
            if ([ss isEqualToString:@"1"])
            {
                NSDictionary * item3 = [dic objectForKey:@"Item3"];
                GongQiuXiangXiModel * md =[[GongQiuXiangXiModel alloc]initWithZiChanXQ:item3];
                [self.dataArr addObject:md];
                
            }else{
                [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
            }
            
            
        }else{
            //供求解析
            if ([ss isEqualToString:@"1"]) {
                 NSDictionary * item3 = [dic objectForKey:@"Item3"];
                GongQiuXiangXiModel * md =[[GongQiuXiangXiModel alloc]initWithDic:item3];
                 [self.dataArr addObject:md];
                
            }else{
                [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
            }
        }
        
        [self view1];
        
    } error:^(NSError *error) {
        
    }];
}

#pragma marc -- 轮播图
-(void)FirstLunBo
{
//    [Engine GetFirstLunBosuccess:^(NSDictionary *dic) {
//        NSArray* arr =  [dic objectForKey:@"Item3"];
//       // [self remoteImageLoaded:arr];
//    } error:nil];
    [self remoteImageLoaded];
}
//获取网络图片
- (void)remoteImageLoaded {
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, KUAN, 200*GAO/667) delegate:self placeholderImage:[UIImage imageNamed:@"publicTou"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    [_bgScroller addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = @[@"http://image97.360doc.com/DownloadImg/2016/05/2707/72679499_8.png"];
    });
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        // NSLog(@">>>>>  %ld", (long)index);
        
    };
    
    
    
    
    
    

    
    
    
    
    
    
}
//view1
-(void)view1
{
    
    GongQiuXiangXiModel * model1 =_dataArr[0];
    view1 =[[UIView alloc]init];
       [self.navigationItem setTitle:model1.titleName];
    view1.backgroundColor=[UIColor whiteColor];
    [_bgScroller sd_addSubviews:@[view1]];
    view1.sd_layout
    .leftSpaceToView(_bgScroller, 0)
    .topSpaceToView(_bgScroller, 200)
    .rightSpaceToView(_bgScroller, 0);
    
    UILabel * titleLab =[UILabel new];
    titleLab.text=model1.titleName;//_gmodel.titleName;
    UILabel * priceLab =[UILabel new];
    priceLab.text=[NSString stringWithFormat:@"%@￥",model1.price];
    UILabel * diquLab =[UILabel new];
    diquLab.text=model1.diQu;
    UIButton * image1 =[UIButton new];
    [image1 setBackgroundImage:[UIImage imageNamed:@"锁上"] forState:0];
    [image1 setBackgroundImage:[UIImage imageNamed:@"锁子"] forState:UIControlStateSelected];
    [image1 addTarget:self action:@selector(suoDingBtn:) forControlEvents:UIControlEventTouchUpInside];
    UILabel * fabuLab =[UILabel new];//
    fabuLab.text=[NSString stringWithFormat:@"发布日期：%@",[Engine nsdateToTime:model1.publicTime]];
    NSLog(@"vipClass=%@",model1.vipname);
    if ([model1.vipname isEqualToString:@"8"]) {
        image1.hidden=NO;
    }else{
        image1.hidden=YES;
    }
    
    titleLab.font=[UIFont systemFontOfSize:15];
    priceLab.font=[UIFont systemFontOfSize:14];
    diquLab.font=[UIFont systemFontOfSize:13];
    fabuLab.font=[UIFont systemFontOfSize:13];
    
    priceLab.textColor=[UIColor redColor];
    fabuLab.textColor=[UIColor blackColor];
    fabuLab.alpha=.7;
    diquLab.textColor=[UIColor blackColor];
    diquLab.alpha=.7;
    
    [view1 sd_addSubviews:@[titleLab,priceLab,diquLab,image1,fabuLab]];
    
    titleLab.sd_layout
    .leftSpaceToView(view1,20)
    .topSpaceToView(view1,10)
    .rightSpaceToView(view1,70)
    .autoHeightRatio(0);
    
    priceLab.sd_layout
    .topSpaceToView(titleLab,5)
    .leftEqualToView(titleLab)
    .widthIs(120)
    .heightIs(25);
    
    
    
    image1.sd_layout
    .widthIs(52)
    .heightIs(52)
    .centerYEqualToView(view1)
    .rightSpaceToView(view1,15);
    
    diquLab.sd_layout
    .topSpaceToView(image1,5)
    .leftEqualToView(titleLab)
    .widthIs(150)
    .heightIs(20);
    
    fabuLab.sd_layout
    .topEqualToView(diquLab)
    .rightEqualToView(image1)
    .leftSpaceToView(diquLab,20)
    .heightRatioToView(diquLab,1);
    [view1 setupAutoHeightWithBottomView:fabuLab bottomMargin:5];
    [self view2];
    
}
//view2
-(void)view2
{
    
    GongQiuXiangXiModel * model1 =_dataArr[0];
    view2 =[[UIView alloc]init];
    view2.backgroundColor=[UIColor whiteColor];
    [_bgScroller sd_addSubviews:@[view2]];
    view2.sd_layout
    .leftSpaceToView(_bgScroller, 0)
    .topSpaceToView(view1, 15)
    .rightSpaceToView(_bgScroller, 0);
    
    
    
    UIImageView * image1 =[UIImageView new];
    image1.image=[UIImage imageNamed:@"矩形点"];
    UILabel * titleLab =[UILabel new];
    titleLab.text=@"信息参数";
    titleLab.font=[UIFont systemFontOfSize:15];
    UILabel * numberLab =[UILabel new];
    numberLab.text=@"数量:";
    numberLab.font=[UIFont systemFontOfSize:13];
    UILabel * standardLab =[UILabel new];
    standardLab.text=@"规格:";
    standardLab.font=[UIFont systemFontOfSize:13];
    UIButton * phoneImage=[UIButton buttonWithType:UIButtonTypeCustom];
    [phoneImage setBackgroundImage:[UIImage imageNamed:@"电话"] forState:0];
    [phoneImage addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    UILabel * numberLabtext =[UILabel new];
    UILabel *standardLabtext =[UILabel new];
    
    numberLabtext.font=[UIFont systemFontOfSize:13];
    standardLabtext.font=[UIFont systemFontOfSize:13];
    numberLabtext.textColor=[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
    standardLabtext.textColor=[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
    
    numberLabtext.text=model1.shuLiang;
    standardLabtext.text=model1.guiGe;
     alt =[[ZidingYiAlert alloc]initWithTitle:model1.companyName alerMessage:model1 canCleBtn:@"确定"];
    [view2 sd_addSubviews:@[image1,titleLab,numberLab,standardLab,phoneImage,numberLabtext,standardLabtext]];
    
    
    image1.sd_layout
    .leftSpaceToView(view2,0)
    .widthIs(39/2)
    .heightIs(30/2)
    .topSpaceToView(view2,10);
    
    titleLab.sd_layout
    .leftSpaceToView(image1,5)
    .widthIs(70)
    .heightRatioToView(image1,1)
    .topSpaceToView(view2,10);
    
    numberLab.sd_layout
    .leftEqualToView(titleLab)
    .widthIs(30)
    .heightIs(20)
    .topSpaceToView(titleLab,10);
    
    standardLab.sd_layout
    .leftEqualToView(numberLab)
    .widthRatioToView(numberLab,1)
    .heightRatioToView(numberLab,1)
    .topSpaceToView(numberLab,10);
    
    numberLabtext.sd_layout
    .leftSpaceToView(numberLab,10)
    .widthIs(60)
    .heightIs(20)
    .topEqualToView(numberLab);
    
    standardLabtext.sd_layout
    .leftEqualToView(numberLabtext)
    .widthRatioToView(numberLabtext,1)
    .heightRatioToView(numberLabtext,1)
    .topSpaceToView(numberLabtext,10);
    
    phoneImage.sd_layout
    .rightSpaceToView(view2,15)
    .widthIs(64/2)
    .heightIs(61/2)
    .topSpaceToView(view2,35);
    [view2 setupAutoHeightWithBottomView:standardLabtext bottomMargin:5];
    [self view3];
}
-(void)callPhone:(UIButton*)btn{
    __weak ZidingYiAlert * weakSelf =alt;
    alt.clickBlock=^(int a){
        [weakSelf dissmiss];
    };
    [alt show];
    
    
}
-(void)view3
{
    GongQiuXiangXiModel * model1 =_dataArr[0];
    view3 =[[UIView alloc]init ];
    view3.backgroundColor=[UIColor whiteColor];
    [_bgScroller sd_addSubviews:@[view3]];
    view3.sd_layout
    .leftSpaceToView(_bgScroller, 0)
    .topSpaceToView(view2, 15)
    .rightSpaceToView(_bgScroller, 0);
    
    UIImageView * image1 =[UIImageView new];
    image1.image=[UIImage imageNamed:@"矩形点"];
    UILabel * titleLab =[UILabel new];
    titleLab.text=@"产品详情";
    titleLab.font=[UIFont systemFontOfSize:15];
    
    UILabel * contentLabe =[UILabel new];
    contentLabe.font=[UIFont systemFontOfSize:13];
    contentLabe.text=model1.chanpincontent;
    [view3 sd_addSubviews:@[image1,titleLab,contentLabe]];
    image1.sd_layout
    .leftSpaceToView(view3,0)
    .widthIs(39/2)
    .heightIs(30/2)
    .topSpaceToView(view3,10);
    
    titleLab.sd_layout
    .leftSpaceToView(image1,5)
    .widthIs(70)
    .heightRatioToView(image1,1)
    .topSpaceToView(view3,10);
    
    contentLabe.sd_layout
    .topSpaceToView(titleLab,5)
    .leftEqualToView(titleLab)
    .rightSpaceToView(view3,5)
    .autoHeightRatio(0);
    
    
    [view3 setupAutoHeightWithBottomView:contentLabe bottomMargin:5];
    
    [self view4];
    
}
-(void)view4{
    GongQiuXiangXiModel * model1 =_dataArr[0];
    view4 =[UIButton buttonWithType:UIButtonTypeCustom];
    [view4 addTarget:self action:@selector(view4:) forControlEvents:UIControlEventTouchUpInside];
    view4.backgroundColor=[UIColor whiteColor];
    [_bgScroller sd_addSubviews:@[view4]];
    
    view4.sd_layout
    .topSpaceToView(view3,15)
    .leftSpaceToView(_bgScroller,0)
    .rightSpaceToView(_bgScroller,0);
    
    
    UILabel * nameLab =[UILabel new];
    nameLab.text=model1.username;
    UILabel * vipLab =[UILabel new];
    vipLab.text=model1.vipname;
    UILabel *contentLab =[UILabel new];
    //contentLab.text=model1.usercontent;//找不到主营业务，找到了在换
   // contentLab.attributedText=[self HTML:model1.usercontent];
    UIImageView * arrow =[UIImageView new];
    arrow.image=[UIImage imageNamed:@"jiantou"];
    
    nameLab.font=[UIFont systemFontOfSize:15];
    vipLab.font=[UIFont systemFontOfSize:12];
    contentLab.font=[UIFont systemFontOfSize:13];
    vipLab.textColor=[UIColor redColor];
    contentLab.alpha=.7;
    contentLab.textAlignment=0;
    [view4 sd_addSubviews:@[nameLab,vipLab,contentLab,arrow]];
    nameLab.sd_layout
    .topSpaceToView(view4,10)
    .leftSpaceToView(view4,25)
    .heightIs(30);
    
    vipLab.sd_layout
    .topSpaceToView(view4,10)
    .leftSpaceToView(nameLab,10)
    .heightRatioToView(nameLab,1);
    
    [nameLab setSingleLineAutoResizeWithMaxWidth:180];
    [vipLab setSingleLineAutoResizeWithMaxWidth:180];
    contentLab.sd_layout
    .topSpaceToView(nameLab,0)
    .leftEqualToView(nameLab)
    .rightSpaceToView(view4,50)
    .autoHeightRatio(0);//到时候设置高度自适应
    
    arrow.sd_layout
    .rightSpaceToView(view4,15)
    .widthIs(28/2)
    .heightIs(44/2)
    .centerYEqualToView(view4);
    
    [view4 setupAutoHeightWithBottomView:contentLab bottomMargin:5];
    
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
-(void)view4:(UIButton*)btn
{
    GongQiuXiangXiModel * model1 =_dataArr[0];
    ZaiXiangxiVC * zvc =[ZaiXiangxiVC new];
    zvc.gmodel=model1;
    [self.navigationController pushViewController:zvc animated:YES];
}
-(void)suoDingBtn:(UIButton*)btn{
   
    //解锁
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        return;
    }else{
        
        [Engine getJieSuoMessageKey:token messageID:_messageID Infoclass:_number success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"])
            {
                 btn.selected=!btn.selected;
                [WINDOW showHUDWithText:@"解锁成功" Type:ShowPhotoYes Enabled:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } error:^(NSError *error) {
            
        }];
        
    }
    
    
}
-(void)daohangtiao{
    self.view.backgroundColor=[UIColor whiteColor];
    //NSLog(@">>%@",_messageID);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    
    
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(KUAN-48/2-10,27, 48/2, 44/2);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"五角星"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"红五角星"] forState:UIControlStateSelected];
//    //查询出数据库中所有收藏的元素
//    ZYData * da = [[ZYData alloc]init];
//    [da connectSqlite];
//    NSArray * chaXunArr = [da searchAllPeople];
//    for (People * p in chaXunArr) {
//        //判断有没有和本界面一样的ID，有得话说明收藏成功，显示红色五角星
//        if ([p.messID intValue]==[_messageID intValue]) {
//            rightBtn.selected=YES;
//        }
//    }
//    UIBarButtonItem * righttBtn =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
   // self.navigationItem.rightBarButtonItem=righttBtn;
    
}
-(void)rightBtn:(UIButton*)btn
{
    btn.selected=!btn.selected;
//    GongQiuXiangXiModel * model1 =_dataArr[0];
//    ZYData *dao = [[ZYData alloc]init];
//    NSString * ss;
//    if ([_number isEqualToString:@"2"]){
//        //从资产过来的
//        ss=@"资产处置";;
//    }else if([_number isEqualToString:@"0"]){
//        //供应、
//        ss=@"供应";
//    }else{
//        //供求
//        ss=@"供求";
//    }
//    [dao connectSqlite];
//    if (btn.selected==YES) {
//        NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
//        [formatter setDateFormat:@"YYYY-MM-dd"];
//        NSString*   date = [formatter stringFromDate:[NSDate date]];
//        [dao insertPeopleWithName:model1.titleName psw:_messageID gongqiu:ss timeSc:date];
//        [WINDOW showHUDWithText:@"收藏成功" Type:ShowPhotoYes Enabled:YES];
//    }else{
//        //查询数据库数组，看看有没有和本界面相同的ID
//        NSArray * chaXunArr = [dao searchAllPeople];
//        for (People * p in chaXunArr)
//        {
//            /*
//             判断有没有和本界面一样的ID，有得话说明收藏成功，显示红色五角星
//             可以删除
//             */
//            if ([p.messID intValue]==[_messageID intValue])
//            {
//                [dao deleteWithPeople:p];
//            }
//            [WINDOW showHUDWithText:@"取消收藏" Type:ShowPhotoYes Enabled:YES];
//        }
//        
//    }
}
-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
}
//在线留言
-(void)liuyan{
    LiuYanVC* vc =[LiuYanVC new];
    if ([_number isEqualToString:@"2"]) {
        //资产
        vc.typee=@"2";
    }else{
        //求购 供应
        vc.typee=@"1";
    }
   // [self.navigationController pushViewController:vc animated:YES];
    GongQiuXiangXiModel * model1 =_dataArr[0];
    NSLog(@"这是messageID=%@",model1.youHuID);
    
}

@end
