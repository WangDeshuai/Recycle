//
//  PaiMaiVC.m
//  Recycle
//
//  Created by Macx on 16/5/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PaiMaiVC.h"
#import "PaiModel.h"
#import "BaoMingVC.h"
#import "ZYData.h"
#import "People.h"
#import "MyZuJi.h"//我的足迹记录浏览历史
#import "ZJDao.h"//我的足迹记录浏览历史
@interface PaiMaiVC ()
{
     UIView * view1;
     UIView * view2;
     UIView * view3;
    UIButton * button1;
    UIButton * button2;
}
@property(nonatomic,retain)UIScrollView * bgScroller;
@property(nonatomic,retain)NSMutableArray * dataArr;
@property(nonatomic,retain)NSMutableArray * shangYitiaoArr;
@property(nonatomic,retain)NSMutableArray * xiaYitiaoArr;

@end

@implementation PaiMaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR;
    _shangYitiaoArr=[NSMutableArray new];
    _xiaYitiaoArr=[NSMutableArray new];
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
    UIBarButtonItem * righttBtn =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=righttBtn;
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"五角星"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn)];
//    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
   
    _dataArr=[NSMutableArray new];
    _bgScroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    _bgScroller.backgroundColor=COLOR;
    [self.view addSubview:_bgScroller];
   
    
    
    
    
    UIButton * OrderMessage =[UIButton buttonWithType:UIButtonTypeCustom];
    OrderMessage.frame=CGRectMake(0, GAO-45-64, KUAN, 45);
    [OrderMessage setBackgroundImage:[UIImage imageNamed:@"导航"] forState:0];
   
    if (![LoginModel isLogin]){
         [OrderMessage setTitle:@"登录可查看详细信息" forState:0];
        [OrderMessage addTarget:self action:@selector(denglu) forControlEvents:UIControlEventTouchUpInside];
       
       
    }else{
        [OrderMessage setTitle:@"我要报名" forState:0];
       [OrderMessage addTarget:self action:@selector(baoming) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.view addSubview:OrderMessage];
    
    if (_jiemian) {
        [self jiemianData];
    }else{
        [self MessagePaiMaiData:_messageID];
    }
    
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
}


//如果界面有值就调用这个
-(void)jiemianData{
    
    
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if(token==nil){
        
        return;
    }
    
    [Engine getMyPublicPaiMaiMessageKey:token MessageId:_jiemian success:^(NSDictionary *dic) {
        NSString * item =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item isEqualToString:@"1"])
        {
            PaiModel * model1 =[[PaiModel alloc]initWithDic:[dic objectForKey:@"Item3"]];
            [self.dataArr removeAllObjects];
            [self.dataArr addObject:model1];
            [self.navigationItem setTitle:model1.titleName];
        }else{
            [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
        }
        [self view1];
        //            PaiModel
    } error:nil];
    
}




//数据解析详细
-(void)MessagePaiMaiData:(NSString*)idd
{
  NSString * ss=  [[Engine plistDuqu22] objectForKey:@"messageID"];
    NSString * uid;
    if (ss==nil) {
        uid=@"0";
    }else{
        uid=ss;
    }
    
    
    [Engine getPaiMaiXiangXiId:idd Uid:uid success:^(NSDictionary *dic) {
        [_shangYitiaoArr removeAllObjects];
        [_xiaYitiaoArr removeAllObjects];
        //上一条
        NSString * shang = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Item2"]];
        //下一条
        NSString * xia = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Item3"]];
        [_shangYitiaoArr addObject:shang];
        [_xiaYitiaoArr addObject:xia];
       
        PaiModel * model1 =[[PaiModel alloc]initWithDic:[self string:[dic objectForKey:@"Item4"]]];
        [_dataArr addObject:model1];
        [self.navigationItem setTitle:model1.titleName];
        
       [self view1];
    } error:nil];
    
    
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
-(void)view1
{
    
    PaiModel * model1=_dataArr[0];
    
    
    view1 =[[UIView alloc]init];
    view1.backgroundColor=[UIColor whiteColor];
    [_bgScroller sd_addSubviews:@[view1]];
   
    view1.sd_layout
    .leftSpaceToView(_bgScroller, 0)
    .topSpaceToView(_bgScroller, 0)
    .rightSpaceToView(_bgScroller, 0);
    
    UILabel * titleLab =[UILabel new];
    titleLab.text=model1.titleName;
    UILabel * diquLab =[UILabel new];
    diquLab.text=model1.diqu;
   
    UILabel * fabuLab =[UILabel new];
    NSString * str =[NSString stringWithFormat:@"%@",[Engine nsdateToTime:model1.publicTime]];
    fabuLab.text=[NSString stringWithFormat:@"发布日期：%@",str];
    
    
    
    titleLab.font=[UIFont systemFontOfSize:15];
    diquLab.font=[UIFont systemFontOfSize:13];
    fabuLab.font=[UIFont systemFontOfSize:13];
    
    fabuLab.textColor=[UIColor blackColor];
    fabuLab.alpha=.7;
    diquLab.textColor=[UIColor blackColor];
    diquLab.alpha=.7;
    
    [view1 sd_addSubviews:@[titleLab,diquLab,fabuLab]];
    
    titleLab.sd_layout
    .leftSpaceToView(view1,20)
    .topSpaceToView(view1,10)
    .rightSpaceToView(view1,70)
    .autoHeightRatio(0);
    
    
    diquLab.sd_layout
    .topSpaceToView(titleLab,5)
    .leftEqualToView(titleLab)
    .widthIs(150)
    .heightIs(20);
    
    
    
    fabuLab.sd_layout
    .topEqualToView(diquLab)
    .rightSpaceToView(view1,10)
    .leftSpaceToView(diquLab,20)
    .heightRatioToView(diquLab,1);
    [view1 setupAutoHeightWithBottomView:fabuLab bottomMargin:5];
    [self view2:model1];
    
}

//view2
-(void)view2:(PaiModel*)model1
{
    
    
   
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
    numberLab.text=@"报名时间:";
    numberLab.font=[UIFont systemFontOfSize:13];
    UILabel * standardLab =[UILabel new];
    standardLab.text=@"保证金:";
    standardLab.font=[UIFont systemFontOfSize:13];
    
    UILabel * comname =[UILabel new];
    comname.text=@"公司名称:";
    comname.font=[UIFont systemFontOfSize:13];
    UILabel * fuzeren =[UILabel new];
    fuzeren.text=@"负责人:";
    fuzeren.font=[UIFont systemFontOfSize:13];
   
    UILabel * lianxidiahua =[UILabel new];
    lianxidiahua.text=@"联系电话:";
    lianxidiahua.font=[UIFont systemFontOfSize:13];
    UILabel * shoujihao =[UILabel new];
    shoujihao.text=@"手机号码:";
    shoujihao.font=[UIFont systemFontOfSize:13];
    
    UILabel * chuanzhen =[UILabel new];
    chuanzhen.text=@"传真:";
    chuanzhen.font=[UIFont systemFontOfSize:13];
    UILabel * email =[UILabel new];
    email.text=@"Email:";
    email.font=[UIFont systemFontOfSize:13];
    
    
    
    UILabel * numberLabtext =[UILabel new];
    UILabel *standardLabtext =[UILabel new];
    
    UILabel * comnametext =[UILabel new];
    UILabel *fuzerentext =[UILabel new];
    
    UILabel * lianxidiahuatext =[UILabel new];
    UILabel *shojihaomatext =[UILabel new];
    
    UILabel * chuanzhentext =[UILabel new];
    UILabel *emailtext =[UILabel new];
    
    
    
    numberLabtext.font=[UIFont systemFontOfSize:13];
    standardLabtext.font=[UIFont systemFontOfSize:13];
   
    comnametext.font=[UIFont systemFontOfSize:13];
    fuzerentext.font=[UIFont systemFontOfSize:13];
   
    lianxidiahuatext.font=[UIFont systemFontOfSize:13];
    shojihaomatext.font=[UIFont systemFontOfSize:13];
    
    chuanzhentext.font=[UIFont systemFontOfSize:13];
    emailtext.font=[UIFont systemFontOfSize:13];
    
    numberLabtext.textColor=[UIColor blackColor];
    standardLabtext.textColor=[UIColor blackColor];
    comnametext.textColor=[UIColor blackColor];
    fuzerentext.textColor=[UIColor blackColor];
    lianxidiahuatext.textColor=[UIColor blackColor];
    shojihaomatext.textColor=[UIColor blackColor];
    chuanzhentext.textColor=[UIColor blackColor];
    emailtext.textColor=[UIColor blackColor];
    
    
    numberLabtext.alpha=.7;
    standardLabtext.alpha=.7;
    comnametext.alpha=.7;
    fuzerentext.alpha=.7;
    lianxidiahuatext.alpha=.7;
    shojihaomatext.alpha=.7;
    chuanzhentext.alpha=.7;
    emailtext.alpha=.7;
    
    
    numberLabtext.text=[Engine nsdateToTime:model1.baomingTime];//   model1.baomingTime;//model1.shuLiang;
    standardLabtext.text=model1.baozhengPrice;//model1.guiGe;
    comnametext.text=model1.commName;
    fuzerentext.text=model1.fuzePeople;
   
    lianxidiahuatext.text=model1.callNumber;
  
    shojihaomatext.text=model1.phoneNumber;
    chuanzhentext.text=model1.chuanZhen;
    emailtext.text=model1.email;
    [view2 sd_addSubviews:@[comname,fuzeren,lianxidiahua,shoujihao,chuanzhen,email]];
    [view2 sd_addSubviews:@[comnametext,fuzerentext,lianxidiahuatext,shojihaomatext,chuanzhentext,emailtext]];
    [view2 sd_addSubviews:@[image1,titleLab,numberLab,standardLab,numberLabtext,standardLabtext]];
    
    
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
    .heightIs(20)
    .topSpaceToView(titleLab,10);
    [numberLab setSingleLineAutoResizeWithMaxWidth:200];
    
    
    standardLab.sd_layout
    .leftEqualToView(numberLab)
    .heightRatioToView(numberLab,1)
    .topSpaceToView(numberLab,10);
    [standardLab setSingleLineAutoResizeWithMaxWidth:200];
    
    comname.sd_layout
    .leftEqualToView(numberLab)
    .heightRatioToView(numberLab,1)
    .topSpaceToView(standardLab,10);
    [comname setSingleLineAutoResizeWithMaxWidth:200];
   
    fuzeren.sd_layout
    .leftEqualToView(numberLab)
    .heightRatioToView(numberLab,1)
    .topSpaceToView(comname,10);
    [fuzeren setSingleLineAutoResizeWithMaxWidth:200];
    
    
    lianxidiahua.sd_layout
    .leftEqualToView(numberLab)
    .heightRatioToView(numberLab,1)
    .topSpaceToView(fuzeren,10);
    [lianxidiahua setSingleLineAutoResizeWithMaxWidth:200];
    
    shoujihao.sd_layout
    .leftEqualToView(numberLab)
    .heightRatioToView(numberLab,1)
    .topSpaceToView(lianxidiahua,10);
    [shoujihao setSingleLineAutoResizeWithMaxWidth:200];
    
    chuanzhen.sd_layout
    .leftEqualToView(numberLab)
    .heightRatioToView(numberLab,1)
    .topSpaceToView(shoujihao,10);
    [chuanzhen setSingleLineAutoResizeWithMaxWidth:200];
    
    email.sd_layout
    .leftEqualToView(numberLab)
    .heightRatioToView(numberLab,1)
    .topSpaceToView(chuanzhen,10);
    [email setSingleLineAutoResizeWithMaxWidth:200];
    
    
    numberLabtext.sd_layout
    .leftSpaceToView(numberLab,10)
    .heightIs(20)
    .topEqualToView(numberLab);
    [numberLabtext setSingleLineAutoResizeWithMaxWidth:200];
    
    standardLabtext.sd_layout
    .leftEqualToView(numberLabtext)
    .heightRatioToView(numberLabtext,1)
    .topSpaceToView(numberLabtext,10);
    [standardLabtext setSingleLineAutoResizeWithMaxWidth:200];
   
    //
    comnametext.sd_layout
    .leftEqualToView(numberLabtext)
    .heightRatioToView(numberLabtext,1)
    .topSpaceToView(standardLabtext,10);
    [comnametext setSingleLineAutoResizeWithMaxWidth:200];
   
    fuzerentext.sd_layout
    .leftEqualToView(numberLabtext)
    .heightRatioToView(numberLabtext,1)
    .topSpaceToView(comnametext,10);
    [fuzerentext setSingleLineAutoResizeWithMaxWidth:200];
    
    lianxidiahuatext.sd_layout
    .leftEqualToView(numberLabtext)
    .heightRatioToView(numberLabtext,1)
    .topSpaceToView(fuzerentext,10);
    [lianxidiahuatext setSingleLineAutoResizeWithMaxWidth:200];
    
    shojihaomatext.sd_layout
    .leftEqualToView(numberLabtext)
    .heightRatioToView(numberLabtext,1)
    .topSpaceToView(lianxidiahuatext,10);
    [shojihaomatext setSingleLineAutoResizeWithMaxWidth:200];
    
    chuanzhentext.sd_layout
    .leftEqualToView(numberLabtext)
    .heightRatioToView(numberLabtext,1)
    .topSpaceToView(shojihaomatext,10);
    [chuanzhentext setSingleLineAutoResizeWithMaxWidth:200];
  
    emailtext.sd_layout
    .leftEqualToView(numberLabtext)
    .heightRatioToView(numberLabtext,1)
    .topSpaceToView(chuanzhentext,10);
    [emailtext setSingleLineAutoResizeWithMaxWidth:200];
    
    [view2 setupAutoHeightWithBottomView:email bottomMargin:5];
    [self view3:model1];
}



-(void)view3:(PaiModel*)model1
{
  
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
    titleLab.text=@"信息详情";
    titleLab.font=[UIFont systemFontOfSize:15];
    
    UILabel * contentLabe =[UILabel new];
    contentLabe.font=[UIFont systemFontOfSize:13];
    //contentLabe.text=model1.content;//model1.chanpincontent;
    contentLabe.attributedText=[self HTML:model1.content];
    
    
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
    [self buttonTwo];
    if ([LoginModel isLogin])
    {
        [self isNsNull:model1];
    }
    
    
    
}
-(NSAttributedString * )HTML:(NSString*)string1
{
    NSString * htmlString = string1;
    NSAttributedString * attributedString =[[NSAttributedString alloc]initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    return attributedString;
}
-(void)isNsNull:(PaiModel*)md
{
    if (md.titleName==nil || md.publicTime==nil)
    {
        return;
    }
    [self myZuji:md];
}

//记录历史记录的(我的足迹)
-(void)myZuji:(PaiModel*)model1
{
    NSLog(@"登录了存储了");
    ZJDao *dao = [[ZJDao alloc]init];
    NSString * ss=@"3";
    [dao connectSqlite];
    NSMutableArray * arr =[dao searchWhoMessageID:_messageID];
    if (arr==nil || arr.count==0)
    {
        NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString*   date = [formatter stringFromDate:[NSDate date]];
        [dao insertPeopleWithName:model1.titleName psw:_messageID gongqiu:ss timeSc:date Publictime:[Engine nsdateToTime:model1.publicTime]];
    }
    
}



//2个按钮
-(void)buttonTwo
{
    button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:[UIImage imageNamed:@"上一条"] forState:0];
    //  button1.frame=CGRectMake(50, 550, 219/2, 61/2);
    [button1 addTarget:self action:@selector(buttonshang:) forControlEvents:UIControlEventTouchUpInside];
    
    button2 =[UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundImage:[UIImage imageNamed:@"下一条"] forState:0];
    [button2 addTarget:self action:@selector(buttonxia:) forControlEvents:UIControlEventTouchUpInside];
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
    //[self view4];
    
    
    __weak __typeof(self)weakSelf = self;
    button1.didFinishAutoLayoutBlock=^(CGRect aaa){
        weakSelf.bgScroller.contentSize=CGSizeMake(KUAN, aaa.origin.y+aaa.size.height+150);
    };
    
    
}
//上一条
-(void)buttonshang:(UIButton*)btton1{
    UIAlertController  * alertionView =nil;
    if(alertionView==nil){
        alertionView=[UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    }
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertionView addAction:action];

    NSString * messid =_shangYitiaoArr[0];
    if ([messid isEqualToString:@"0"]) {
        alertionView.message=@"没有上一条数据了";
        [self presentViewController:alertionView animated:YES completion:nil];
    }else{
        [self reloadData];
        [self MessagePaiMaiData:_shangYitiaoArr[0]];
    }
    
  
}
//下一条
-(void)buttonxia:(UIButton*)button2
{
    UIAlertController  * alertionView =nil;
    if(alertionView==nil){
        alertionView=[UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    }
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertionView addAction:action];
    
    
    NSString * messid =_xiaYitiaoArr[0];
    if ([messid isEqualToString:@"0"]) {
        alertionView.message=@"没有下一条数据了";
        [self presentViewController:alertionView animated:YES completion:nil];
    }else{
        [self reloadData];
        [self MessagePaiMaiData:_xiaYitiaoArr[0]];
    }
    
}
-(void)denglu{
    LoginVC * vc = [LoginVC new];
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)baoming{
    BaoMingVC * vc =[BaoMingVC new];
    vc.messageID=_messageID;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)rightBtn:(UIButton*)btn{
     btn.selected=!btn.selected;
    PaiModel * model1=_dataArr[0];
    ZYData *dao = [[ZYData alloc]init];
    NSString * ss=@"拍卖";
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
//清空数据
-(void)reloadData{
    [view1 removeFromSuperview];
    [view2 removeFromSuperview];
    [view3 removeFromSuperview];
    [button1 removeFromSuperview];
    [button2 removeFromSuperview];
    // [banner removeFromSuperview];
    
}
-(void)backWrite
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//html解析
//-(NSAttributedString * )HTML:(NSString*)string1
//{
//    NSString * htmlString = string1;
//    NSAttributedString * attributedString =[[NSAttributedString alloc]initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    
//    return attributedString;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
