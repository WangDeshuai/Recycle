//
//  XiangXiVC1.m
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XiangXiVC1.h"
#import "ZaiXiangxiVC.h"
#import "LiuYanVC.h"
#import "GongQiuXiangXiModel.h"
#import "ZYData.h"//收藏用的
#import "PaiModel.h"
#import "ZidingYiAlert.h"
#import "MyZuJi.h"//记录浏览历史的
#import "ZJDao.h"//记录浏览历史的
#import "vipIDModel.h"
@interface XiangXiVC1 ()<SDCycleScrollViewDelegate>
{
    UIView * view3;
    UIButton * view4;
    UIView * view2;
    UIView * view1;
    UIButton * button1;
    UIButton * button2;
    ZidingYiAlert *  alt;
   vipIDModel * vipmodel;
  
   
}
@property(nonatomic,retain)NSMutableArray * shangJiArray;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *jingYingArr;
@property (nonatomic, strong) UIScrollView *bgScroller;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *shangYitiaoArr;
@property (nonatomic, strong) NSMutableArray *xiaYitiaoArr;
@property (nonatomic, strong) NSMutableArray * imageArray;
@end

@implementation XiangXiVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    //NSLog(@">>%@",_messageID);
    _jingYingArr=[NSMutableArray new];
    _imageArr=[NSMutableArray new];
    _shangJiArray=[NSMutableArray new];
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
    //查询出数据库中所有收藏的元素
    ZYData * da = [[ZYData alloc]init];
    [da connectSqlite];
    NSArray * chaXunArr = [da searchAllPeople];
    for (People * p in chaXunArr) {
        //判断有没有和本界面一样的ID，有得话说明收藏成功，显示红色五角星
        if ([p.messID intValue]==[_messageID intValue]) {
            rightBtn.selected=YES;
        }
//        NSLog(@"数据库的ID是>>>%@",p.messID);
//        NSLog(@"本界面的ID是>>>%@",_messageID);
    }
    
     UIBarButtonItem * righttBtn =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=righttBtn;
  //  [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    _shangYitiaoArr=[NSMutableArray new];
    _xiaYitiaoArr=[NSMutableArray new];
    _bgScroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
  //  _bgScroller.contentSize=CGSizeMake(KUAN, GAO+230);
    _bgScroller.backgroundColor=COLOR;
    [self.view addSubview:_bgScroller];
    _imageArr=[NSMutableArray new];
    _dataArr=[NSMutableArray new];
    [self FirstLunBo];
    
    UIButton * OrderMessage =[UIButton buttonWithType:UIButtonTypeCustom];
    OrderMessage.frame=CGRectMake(0, GAO-45-64, KUAN, 45);
    if(_jiemian){
        OrderMessage.hidden=YES;
    }
    [OrderMessage setBackgroundImage:[UIImage imageNamed:@"导航"] forState:0];
    [OrderMessage setTitle:@"在线留言" forState:0];
    [OrderMessage addTarget:self action:@selector(liuyan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:OrderMessage];

    
    if (_number==0) {
        //从供应过来的
        [self DataJieXiMessageID:_messageID];
    }else if (_number==1){
       //从求购过来的
        [self DataJieXiMessageID:_messageID];
    }else if (_number==2){
      //从资产过来的
        [self DataZiChanMessageID:_messageID];
    }
    
    
    
    
    
    
    
}
#pragma mark -- 如果点击上一条 或者下一条 崩溃的话很有可能是这的原因
//供求2接口详情
-(void)DataJieXiMessageID:(NSString*)idd{
    if (_jiemian) {
        [self jiemianGongQiu];
    }else{

        NSString * ss=  [[Engine plistDuqu22] objectForKey:@"messageID"];
        NSString * uid;
        if (ss==nil) {
            uid=@"0";
        }else{
            uid=ss;
        }
        
        [WINDOW showHUDWithText:@"数据加载中请稍后..." Type:ShowLoading Enabled:YES];
        [Engine getQianTaiXiangQingID:idd Uid:uid success:^(NSDictionary *dic) {
            [_shangYitiaoArr removeAllObjects];
            [_xiaYitiaoArr removeAllObjects];
            NSString * shang = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Item2"]];
            NSString * xia = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Item3"]];
            [WINDOW showHUDWithText:@"加载成功" Type:ShowPhotoYes Enabled:YES];
            [_shangYitiaoArr addObject:shang];
            [_xiaYitiaoArr addObject:xia];
            if ([dic objectForKey:@"Item4"]==[NSNull null]) {

                [WINDOW showHUDWithText:@"信息为空" Type:ShowPhotoNo Enabled:YES];
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            GongQiuXiangXiModel * model1 =[[GongQiuXiangXiModel alloc]initWithDic:[dic objectForKey:@"Item4"]];
            [self.navigationItem setTitle:model1.titleName];
            [self.dataArr removeAllObjects];
            [self.dataArr addObject:model1];
            NSArray * aa=[dic objectForKey:@"Item5"];
            if (aa.count==0)
            {
                //[WINDOW showHUDWithText:@"没有图片" Type:ShowPhotoNo Enabled:YES];
                [self remoteImageLoaded:@[model1.piccc]];
            }else{
                NSArray * item5 =[dic objectForKey:@"Item5"];
                for (NSDictionary * dicc in item5)
                {
                    GongQiuXiangXiModel * model1=[[GongQiuXiangXiModel alloc]initWithPicDic:dicc];
                    [_imageArr addObject:model1.picadd];
                }
                [self remoteImageLoaded:_imageArr];
            }
           
            if ([dic objectForKey:@"Item6"]==[NSNull null]) {
               
            }else{
               NSString* jingying= [dic objectForKey:@"Item6"];
                [_jingYingArr removeAllObjects];
                [_jingYingArr addObject:jingying];
            }
            
            [self view1];
        } error:^(NSError *error) {
            [WINDOW showHUDWithText:@"网络超时,请稍后重试" Type:ShowPhotoNo Enabled:YES];
        }];
 
    }
    
    
    
    
}
//资产详情
-(void)DataZiChanMessageID:(NSString*)idd
{
    NSString * ss=  [[Engine plistDuqu22] objectForKey:@"messageID"];
    NSString * uid;
    if (ss==nil) {
        uid=@"0";
    }else{
        uid=ss;
    }

    [Engine getZiChanXiangQingID:idd Uid:uid success:^(NSDictionary *dic) {
        if ([dic objectForKey:@"Item4"]==[NSNull null]) {

            [WINDOW showHUDWithText:@"信息为空" Type:ShowPhotoNo Enabled:YES];
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
        
        [_shangYitiaoArr removeAllObjects];
        [_xiaYitiaoArr removeAllObjects];
        //上一条
        NSString * shang = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Item2"]];
        //下一条
        NSString * xia = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Item3"]];
        [_shangYitiaoArr addObject:shang];
        [_xiaYitiaoArr addObject:xia];
        
        GongQiuXiangXiModel * model1 =[[GongQiuXiangXiModel alloc]initWithZiChanXQ:[self string:[dic objectForKey:@"Item4"]]];
        [self.navigationItem setTitle:model1.titleName];
        [self.dataArr removeAllObjects];
        [self.dataArr addObject:model1];
        NSArray * aa=[dic objectForKey:@"Item5"];
        if (aa.count==0)
        {
            //[WINDOW showHUDWithText:@"没有图片" Type:ShowPhotoNo Enabled:YES];
            [self remoteImageLoaded:@[model1.piccc]];
        }else{
            NSArray * item5 =[dic objectForKey:@"Item5"];
            for (NSDictionary * dicc in item5)
            {
                GongQiuXiangXiModel * model1=[[GongQiuXiangXiModel alloc]initWithPicDic:dicc];
                [_imageArr addObject:model1.picadd];
            }
            [self remoteImageLoaded:_imageArr];
        }
        

        if ([dic objectForKey:@"Item6"]==[NSNull null]) {
            
        }else{
            NSString* jingying= [dic objectForKey:@"Item6"];
            [_jingYingArr removeAllObjects];
            [_jingYingArr addObject:jingying];
        }
        [self view1];

    } error:^(NSError *error) {
        
    }];
}


//如果jiemian有值的话说明是从我的发布中来的调用这个接口
-(void)jiemianGongQiu{
    
    NSString* token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        return;
    }
    
    if (_tagg==0 || _tagg==1) {
        [Engine getMyPublicPaiMaiKey:token MessageId:_jiemian success:^(NSDictionary *dic) {
            NSString * item =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item isEqualToString:@"1"])
            {
                GongQiuXiangXiModel * model1 =[[GongQiuXiangXiModel alloc]initWithDic:[dic objectForKey:@"Item3"]];
                [self.dataArr removeAllObjects];
                [self.dataArr addObject:model1];
                [self.navigationItem setTitle:model1.titleName];
            }else{
                [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
            }
            NSMutableArray * aa ;
            if ([dic objectForKey:@"Item4"]==[NSNull null])
            {
                NSLog(@"null==nill");
                aa=nil;
            }else{
                 aa=[dic objectForKey:@"Item4"];
            }
           
            
            
            if (aa.count==0 ||aa==nil )
            {
                //[WINDOW showHUDWithText:@"没有图片" Type:ShowPhotoNo Enabled:YES];
                GongQiuXiangXiModel * model1=_dataArr[0];
                [self remoteImageLoaded:@[model1.piccc]];
            }else{
                NSArray * item5 =[dic objectForKey:@"Item4"];
                for (NSDictionary * dicc in item5)
                {
                    GongQiuXiangXiModel * model1=[[GongQiuXiangXiModel alloc]initWithPicDic:dicc];
                    [_imageArr addObject:model1.picadd];
                }
                [self remoteImageLoaded:_imageArr];
            }

            
            
            
            
            if ([dic objectForKey:@"Item5"]==[NSNull null]) {
                
            }else{
                NSString* jingying= [dic objectForKey:@"Item5"];
                [_jingYingArr removeAllObjects];
                [_jingYingArr addObject:jingying];
            }
            [self view1];
        } error:nil];
    }else if (_tagg==2){
        //拍卖
        //;
    }else{
        //资产处置
        [Engine getMyPublicZiChanMessageKey:token MessageId:_jiemian success:^(NSDictionary *dic) {
            NSString * item =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item isEqualToString:@"1"])
            {
                GongQiuXiangXiModel * model1 =[[GongQiuXiangXiModel alloc]initWithZiChanXQ:[dic objectForKey:@"Item3"]];
                [self.dataArr removeAllObjects];
                [self.dataArr addObject:model1];
                [self.navigationItem setTitle:model1.titleName];
            }else{
                [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
            }
            
            NSMutableArray * aa ;
            if ([dic objectForKey:@"Item4"]==[NSNull null])
            {
                aa=nil;
            }else{
                aa=[dic objectForKey:@"Item4"];
            }
            
            if (aa.count==0 ||aa==nil )
            {
                //[WINDOW showHUDWithText:@"没有图片" Type:ShowPhotoNo Enabled:YES];
                GongQiuXiangXiModel * model1=_dataArr[0];
                [self remoteImageLoaded:@[model1.piccc]];
            }else{
                NSArray * item5 =[dic objectForKey:@"Item4"];
                for (NSDictionary * dicc in item5)
                {
                    GongQiuXiangXiModel * model1=[[GongQiuXiangXiModel alloc]initWithPicDic:dicc];
                    [_imageArr addObject:model1.picadd];
                }
                [self remoteImageLoaded:_imageArr];
            }

            
            
            
            if ([dic objectForKey:@"Item5"]==[NSNull null]) {
                
            }else{
                NSString* jingying= [dic objectForKey:@"Item5"];
                [_jingYingArr removeAllObjects];
                [_jingYingArr addObject:jingying];
            }
            [self view1];
        } error:nil];
        
    }
    
    
    
}



//过滤一下
-(NSDictionary*)string:(id)sss
{
    NSDictionary * a=nil;
    if (sss==[NSNull null]) {
       
    }else{
        a=sss;
    }
    return a;
}



#pragma marc -- 轮播图
-(void)FirstLunBo
{
//    [Engine GetFirstLunBosuccess:^(NSDictionary *dic) {
//        NSArray* arr =  [dic objectForKey:@"Item3"];
//       [self remoteImageLoaded:arr];
//    } error:nil];
}
//获取网络图片
- (void)remoteImageLoaded:(NSArray*)arr{
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, KUAN, 200*GAO/667) delegate:self placeholderImage:[UIImage imageNamed:@"publicTou"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    [_bgScroller addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = arr;
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
    view1.backgroundColor=[UIColor whiteColor];
    [_bgScroller sd_addSubviews:@[view1]];
    view1.sd_layout
    .leftSpaceToView(_bgScroller, 0)
    .topSpaceToView(_bgScroller, 200*GAO/667)
    .rightSpaceToView(_bgScroller, 0);
    
    UILabel * titleLab =[UILabel new];
    titleLab.text=model1.titleName;//_gmodel.titleName;
    UILabel * priceLab =[UILabel new];
    priceLab.text=[NSString stringWithFormat:@"%@￥",model1.price];
    UILabel * diquLab =[UILabel new];
    diquLab.text=model1.diQu;
    UIButton * image1 =[UIButton new];
    [image1 setBackgroundImage:[UIImage imageNamed:@"锁子"] forState:0];
    [image1 setBackgroundImage:[UIImage imageNamed:@"锁上"] forState:UIControlStateSelected];
    [image1 addTarget:self action:@selector(suoDingBtn:) forControlEvents:UIControlEventTouchUpInside];
    UILabel * fabuLab =[UILabel new];
    fabuLab.text=[NSString stringWithFormat:@"发布日期：%@",[Engine nsdateToTime:model1.publicTime]];
    //NSLog(@"vipClass=%@",model1.publicTime);
   
    if ([model1.suozi isEqualToString:@"1"]) {
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
-(void)suoDingBtn:(UIButton*)btn{
    
    btn.selected=!btn.selected;
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        return;
    }
    NSString * type ;
    if (_number==0||_number==1) {
        type=@"1";
    }else{
        type=@"2";
    }
    
    
    [Engine getSuoDingMessageKey:token messageID:_messageID Infoclass:type success:^(NSDictionary *dic) {
        
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoYes Enabled:YES];
            btn.selected=YES;
            
        }else{
            [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
             btn.selected=NO;
        }
        
        
        
        
    } error:nil];
    
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
    
     alt =[[ZidingYiAlert alloc]initWithTitle:model1.companyName alerMessage:model1 canCleBtn:@"确定"];
    
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
    [phoneImage addTarget:self action:@selector(phoneBtn) forControlEvents:UIControlEventTouchUpInside];
    [phoneImage setBackgroundImage:[UIImage imageNamed:@"电话"] forState:0];
    UILabel * numberLabtext =[UILabel new];
    UILabel *standardLabtext =[UILabel new];
    
     numberLabtext.font=[UIFont systemFontOfSize:13];
     standardLabtext.font=[UIFont systemFontOfSize:13];
     numberLabtext.textColor=[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
     standardLabtext.textColor=[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
    
   numberLabtext.text=model1.shuLiang;
    standardLabtext.text=model1.guiGe;
    
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
    /********************/
//    contentLabe.text=model1.chanpincontent;
     contentLabe.attributedText=[self HTML:model1.chanpincontent];
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
            
    if(_jiemian){
        
    }else{
         [self buttonTwo];
    }
    
   
    
}
//2个按钮
-(void)buttonTwo
{
    button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:[UIImage imageNamed:@"上一条"] forState:0];
     button2 =[UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundImage:[UIImage imageNamed:@"下一条"] forState:0];
    [button1 addTarget:self action:@selector(shangYiTiao:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(xiaYiTiao:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_bgScroller sd_addSubviews:@[button1,button2]];
   
    button1.sd_layout
    .topSpaceToView(view3,15)
    .widthIs(219/2)
    .heightIs(61/2)
    .leftSpaceToView(_bgScroller,40);
   
    button2.sd_layout
    .topEqualToView(button1)
    .widthIs(219/2)
    .heightIs(61/2)
    .rightSpaceToView(_bgScroller,40);
  // [self view4];
    [self dataJiXi];
}

-(void)view4{
    GongQiuXiangXiModel * model1 =_dataArr[0];
    //vipIDModel * mode=_shangJiArray[0];
    view4 =[UIButton buttonWithType:UIButtonTypeCustom];
    [view4 addTarget:self action:@selector(view4:) forControlEvents:UIControlEventTouchUpInside];
    view4.backgroundColor=[UIColor whiteColor];
    [_bgScroller sd_addSubviews:@[view4]];
   
    view4.sd_layout
    .topSpaceToView(button1,15)
    .leftSpaceToView(_bgScroller,0)
    .rightSpaceToView(_bgScroller,0);
    
    
    UILabel * nameLab =[UILabel new];
    nameLab.text=model1.username;//
    UILabel * vipLab =[UILabel new];
    vipLab.text=vipmodel.vipName;//model1.vipname;
    UILabel *contentLab =[UILabel new];
    contentLab.text=_jingYingArr[0];//model1.usercontent;//找不到主营业务，找到了在换
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
     __weak __typeof(self)weakSelf = self;
    view4.didFinishAutoLayoutBlock=^(CGRect aaa){
        weakSelf.bgScroller.contentSize=CGSizeMake(KUAN, aaa.origin.y+aaa.size.height+150);
    };

    //是不是登录了如果没有就不存储，如果登陆了就存储
    if ([LoginModel isLogin])
    {
        [self myZuji:model1];
    }
   
}

//记录历史记录的(我的足迹)
-(void)myZuji:(GongQiuXiangXiModel*)model1
{
    ZJDao *dao = [[ZJDao alloc]init];
    [dao connectSqlite];
    NSMutableArray * arr =[dao searchWhoMessageID:_messageID];
    if (arr==nil || arr.count==0)
    {
        NSString * ss;
        if (_number==0) {
             ss=[NSString stringWithFormat:@"%lu",_number];
        }else if(_number==1){
             ss=[NSString stringWithFormat:@"%lu",_number];
        }else if (_number==2){
             ss=[NSString stringWithFormat:@"%lu",_number];
        }
       
        NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString*   date = [formatter stringFromDate:[NSDate date]];
        [dao insertPeopleWithName:model1.titleName psw:_messageID gongqiu:ss timeSc:date Publictime:[Engine nsdateToTime:model1.publicTime]];
    }
 
}




//电话的点击事件
-(void)phoneBtn{
    if (![LoginModel isLogin]){
        LoginVC * vc = [LoginVC new];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    __weak ZidingYiAlert * weakSelf =alt;
    alt.clickBlock=^(int a){
        [weakSelf dissmiss];
    };
    [alt show];
    
}


//html解析
-(NSAttributedString * )HTML:(NSString*)string1
{
    NSString * htmlString = string1;
    NSAttributedString * attributedString =[[NSAttributedString alloc]initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
   
    return attributedString;
}



//上一条
-(void)shangYiTiao:(UIButton*)btn{
    
    
    UIAlertController  * alertionView =nil;
    if(alertionView==nil){
        alertionView=[UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    }
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertionView addAction:action];
    if (_jiemian) {
        alertionView.message=@"没有上一条数据了";
        [self presentViewController:alertionView animated:YES completion:nil];
    }else{
        NSString * messid =_xiaYitiaoArr[0];
        if ([messid isEqualToString:@"0"]) {
            alertionView.message=@"没有上一条数据了";
            [self presentViewController:alertionView animated:YES completion:nil];
        }else{
            [self reloadData];
            if (_number==2){
                //从资产过来的
                [self DataZiChanMessageID:_shangYitiaoArr[0]];
            }else{
                [self DataJieXiMessageID:_shangYitiaoArr[0]];
            }
        }
        

    }
    
    
    
    
    
    
    
   
  
    
}
//下一条
-(void)xiaYiTiao:(UIButton*)btn{

    UIAlertController  * alertionView =nil;
    if(alertionView==nil){
        alertionView=[UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    }
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertionView addAction:action];
    if (_jiemian) {
        alertionView.message=@"没有下一条数据了";
        [self presentViewController:alertionView animated:YES completion:nil];
    }else{
        
        NSString * messid =_xiaYitiaoArr[0];
        if ([messid isEqualToString:@"0"]) {
            alertionView.message=@"没有下一条数据了";
            [self presentViewController:alertionView animated:YES completion:nil];
        }else{
            [self reloadData];
            if (_number==2){
                //从资产过来的
                [self DataZiChanMessageID:_xiaYitiaoArr[0]];
            }else{
                //供应、供求
                [self DataJieXiMessageID:_xiaYitiaoArr[0]];
            }
        }
        
 
    }
    
    
    
    
   
    
}



-(void)viewWillDisappear:(BOOL)animated {
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"123"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)viewWillAppear:(BOOL)animated{
   
}



//清空数据
-(void)reloadData{
    [view1 removeFromSuperview];
    [view2 removeFromSuperview];
    [view3 removeFromSuperview];
    [view4 removeFromSuperview];
    [button1 removeFromSuperview];
    [button2 removeFromSuperview];
   // [banner removeFromSuperview];
    
}
-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)rightBtn:(UIButton*)btn
{
    btn.selected=!btn.selected;
    GongQiuXiangXiModel * model1 =_dataArr[0];
    ZYData *dao = [[ZYData alloc]init];
    NSString * ss;
        if (_number==2){
            //从资产过来的
            ss=@"资产处置";;
        }else if(_number==0){
            //供应、
            ss=@"供应";
        }else{
            //供求
            ss=@"求购";
        }
    [dao connectSqlite];
    if (btn.selected==YES) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString*   date = [formatter stringFromDate:[NSDate date]];
        [dao insertPeopleWithName:model1.titleName psw:_messageID gongqiu:ss timeSc:date];
        [WINDOW showHUDWithText:@"收藏成功" Type:ShowPhotoYes Enabled:YES];
    }else{
       //查询数据库数组，看看有没有和本界面相同的ID
        NSArray * chaXunArr = [dao searchAllPeople];
        for (People * p in chaXunArr)
        {
            /*
             判断有没有和本界面一样的ID，有得话说明收藏成功，显示红色五角星
             可以删除
             */
            if ([p.messID intValue]==[_messageID intValue])
            {
                [dao deleteWithPeople:p];
            }
         [WINDOW showHUDWithText:@"取消收藏" Type:ShowPhotoYes Enabled:YES];
        }
        
    }
    
    

}

-(void)view4:(UIButton*)btn
{
     GongQiuXiangXiModel * model1 =_dataArr[0];
     ZaiXiangxiVC * zvc =[ZaiXiangxiVC new];
     zvc.gmodel=model1;
    [self.navigationController pushViewController:zvc animated:YES];
}

-(void)dataJiXi{
      GongQiuXiangXiModel * model1 =_dataArr[0];
    NSString * idd=model1.youHuID;
  
    [Engine getHuiYuanMessageUid:idd success:^(NSDictionary *dic) {
        if ([dic objectForKey:@"Item3"]==[NSNull null]) {
            
        }else{
            //直接设置全局的不用添加到数组，就只有1条数据
            vipmodel=[[vipIDModel alloc]initWithDic:[dic objectForKey:@"Item3"]];
            
        }
        [self view4];
    } error:nil];
}


//在线留言
-(void)liuyan{
    LiuYanVC* vc =[LiuYanVC new];
    
    //type 0网站建议 1供求表 2资产 3拍卖 4商铺
    //拍卖的是我要报名
    if (_number==2) {
        //资产
        vc.typee=@"2";
    }else{
        //求购 供应
        vc.typee=@"1";
    }
    vc.messageID=_messageID;
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"看看这留言>>>%@",_messageID);
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
