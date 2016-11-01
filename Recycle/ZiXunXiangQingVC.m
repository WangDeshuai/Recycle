//
//  ZiXunXiangQingVC.m
//  Recycle
//
//  Created by Macx on 16/5/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZiXunXiangQingVC.h"
#import "ZiXunFenLeiModel.h"

@interface ZiXunXiangQingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel * titleLabel;
    UILabel * publicTimeLabel;
    UIView * bgView;
}
@property(nonatomic,retain)UITableView*tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * newsArray;
@property(nonatomic,retain)UIScrollView * bgScrollview;
@end

@implementation ZiXunXiangQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangView];
    _dataArray=[NSMutableArray new];
    _newsArray=[NSMutableArray new];
    _bgScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
   
    _bgScrollview.backgroundColor=COLOR;
    _bgScrollview.contentSize=CGSizeMake(KUAN, GAO+300);
    
    [self.view addSubview:_bgScrollview];
    [self ZixunXiangQingData];
   
}
-(void)daohangView
{
    self.view.backgroundColor=COLOR;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:@"详情"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 17/2, 30/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backwrite"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItems=@[leftBtn];
    
}

//资讯详情数据解析
-(void)ZixunXiangQingData{
    [Engine getZiXunXiangQingMessageID:_messageid success:^(NSDictionary *dic) {
        
        NSDictionary * dicc =[dic objectForKey:@"Item3"];
        ZiXunFenLeiModel * model1 =[[ZiXunFenLeiModel alloc]initWithZiXunXiangQing:dicc];
        [_dataArray addObject:model1];
        [self titleLabel];
    } error:nil];
    
}



-(void)titleLabel
{
   
    ZiXunFenLeiModel * model1 =_dataArray[0];
    titleLabel =[UILabel new];
    titleLabel.textAlignment=1;
    titleLabel.font=[UIFont systemFontOfSize:17];
    titleLabel.text=model1.ziTitleName;
    [_bgScrollview sd_addSubviews:@[titleLabel]];
    titleLabel.sd_layout
    .topSpaceToView(_bgScrollview,10)
    .centerXEqualToView(_bgScrollview)
    .heightIs(30);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    publicTimeLabel=[UILabel new];
    publicTimeLabel.alpha=.6;
    publicTimeLabel.font=[UIFont systemFontOfSize:13];
    publicTimeLabel.textAlignment=1;
    publicTimeLabel.text=[NSString stringWithFormat:@"发布时间：%@",[Engine  nsdateToTime:model1.zipublicTime]];//model1.zipublicTime;
    [_bgScrollview sd_addSubviews:@[publicTimeLabel]];
    
    publicTimeLabel.sd_layout
    .topSpaceToView(titleLabel,2)
    .centerXEqualToView(_bgScrollview)
    .heightIs(20);
    [publicTimeLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    
    [self contentView:model1];
}
//view1
-(void)contentView:(ZiXunFenLeiModel*)model1{
    bgView =[UIView new];
    bgView.backgroundColor=[UIColor whiteColor];
    [_bgScrollview sd_addSubviews:@[bgView]];
    bgView.sd_layout
    .topSpaceToView(publicTimeLabel,5)
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0);
    
    UILabel * label1 =[UILabel new];
    label1.font=[UIFont systemFontOfSize:15];
    label1.text=@"         中国回收商网(市场部)统计:每日报价更新的时间,下午2点(周六、日停止更新)";
    [bgView sd_addSubviews:@[label1]];
    label1.sd_layout
    .topSpaceToView(bgView,10)
    .leftSpaceToView(bgView,10)
    .rightSpaceToView(bgView,10)
    .autoHeightRatio(0);
    
    UILabel * contentLabel =[UILabel new];
   // contentLabel.text=[self filterHTML:model1.ziContent];
    contentLabel.attributedText=[self HTML:model1.ziContent];
   // NSLog(@"输出看看%@",model1.ziContent);
   //[self hhtmmll:model1.ziContent];
    contentLabel.font=[UIFont systemFontOfSize:14];
    contentLabel.alpha=.8;
    [bgView sd_addSubviews:@[contentLabel]];
    contentLabel.sd_layout
    .topSpaceToView(label1,5)
    .leftSpaceToView(bgView,10)
    .rightSpaceToView(bgView,10)
    .autoHeightRatio(0);
    
    
    UILabel * label2 =[UILabel new];
    label2.font=[UIFont systemFontOfSize:15];
    label2.text=@"此内容系来自互联网、不代表回收商网赞成被此内容或立场。\n以上信息均由中国回收商(www.huishoushang.com)收集报道，如有转载，请注明出处，谢谢合作！";
    [bgView sd_addSubviews:@[label2]];
    label2.sd_layout
    .topSpaceToView(contentLabel,15)
    .leftSpaceToView(bgView,10)
    .rightSpaceToView(bgView,10)
    .autoHeightRatio(0);
    
    UILabel * laiyuanLab =[UILabel new];
    laiyuanLab.text=@"来源:中国回收商网";//[//NSString stringWithFormat:@"来源:%@",ss]//model1.zimessageLaiyuan;
    laiyuanLab.font=[UIFont systemFontOfSize:13];
    laiyuanLab.alpha=.5;
    laiyuanLab.textAlignment=NSTextAlignmentRight;
    [bgView sd_addSubviews:@[laiyuanLab]];
    laiyuanLab.sd_layout
    .topSpaceToView(label2,10)
    .rightSpaceToView(bgView,5)
    .heightIs(20)
    .leftSpaceToView(bgView,60);//到时候换成宽度自适应

    
    UIButton * QQbtn =[UIButton buttonWithType:UIButtonTypeCustom];
   // QQbtn.backgroundColor=[UIColor redColor];
    [QQbtn setImage:[UIImage imageNamed:@"anfor_details_qq"] forState:0];
    [QQbtn setTitle:@"QQ" forState:UIControlStateNormal];
    [QQbtn setTitleColor:[UIColor blackColor] forState:0];
    [bgView sd_addSubviews:@[QQbtn]];
    QQbtn.sd_layout
    .topSpaceToView(laiyuanLab,10)
    .rightSpaceToView(bgView,39)
    .heightIs(39/2)
    .widthIs(38/2);
    
    UIButton * Webbtn =[UIButton buttonWithType:UIButtonTypeCustom];
  //  Webbtn.backgroundColor=[UIColor redColor];
    [Webbtn setImage:[UIImage imageNamed:@"anfor_details_weibo"] forState:0];
    
    [bgView sd_addSubviews:@[Webbtn]];
    Webbtn.sd_layout
    .topEqualToView(QQbtn)
    .rightSpaceToView(QQbtn,20)
    .heightIs(35/2)
    .widthIs(37/2);
   
    
    UIButton * WeXinbtn =[UIButton buttonWithType:UIButtonTypeCustom];
   // WeXinbtn.backgroundColor=[UIColor redColor];
    [WeXinbtn setImage:[UIImage imageNamed:@"anfor_details_weixin"] forState:0];
    
    [bgView sd_addSubviews:@[WeXinbtn]];
    WeXinbtn.sd_layout
    .topEqualToView(Webbtn)
    .rightSpaceToView(Webbtn,20)
    .heightIs(37/2)
    .widthIs(46/2);
    
    
    
    [bgView setupAutoHeightWithBottomView:QQbtn bottomMargin:5];
   
     [self newsData];
}
-(void)newsData{
    
//    NSLog(@"classIDD=%@",_classIdd);
    
    [Engine getZiXunXinWenPage:@"1" Pagesize:@"3" classID:_classIdd  success:^(NSDictionary *dic) {
       // ZiXunFenLeiModel
        if ([dic objectForKey:@"Item3"]==[NSNull null]) {
            return ;
        }else
        {
            for (NSDictionary * dicc in [dic objectForKey:@"Item3"] )
            {
                ZiXunFenLeiModel * md =[[ZiXunFenLeiModel alloc]initWithNewsXiangQing:dicc];
                [_newsArray addObject:md];
               
            }
            
        }
       
         [self CreatTableView];

    } error:nil];
}
-(void)CreatTableView{
    
    _tableView =[[UITableView alloc]init];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled=NO;
    [_bgScrollview sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .topSpaceToView(bgView,10)
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0)
    .heightIs(44*_newsArray.count+40+40);
    _tableView.tableHeaderView=[self tableviewHead];
    _tableView.tableFooterView=[self tableViewFoot];
    __weak __typeof(self)weakSelf = self;
    _tableView.didFinishAutoLayoutBlock=^(CGRect aaa){
        weakSelf.bgScrollview.contentSize=CGSizeMake(KUAN, aaa.origin.y+aaa.size.height+100);
    };
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _newsArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UIImageView * image1 =[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 5, 5)];
        image1.tag=1;
        [cell addSubview:image1];
        UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(40, 12, cell.frame.size.width, 20)];
        label.tag=2;
        [cell addSubview:label];
        
    }
    UIImageView * image1 =[cell viewWithTag:1];
    UILabel  * lab =[cell viewWithTag:2];
    ZiXunFenLeiModel * md =_newsArray[indexPath.row];
    lab.text=md.newsTitle;
    image1.image=[UIImage imageNamed:@"anfor_details_point"];
    lab.font=[UIFont systemFontOfSize:13];
    return cell;
    
}
-(UIView*)tableviewHead{
    //ZiXunFenLeiModel * md =_newsArray[0];
    UILabel * viewLable =[[UILabel alloc]init];
    viewLable.frame=CGRectMake(0, 0, KUAN, 40);
    viewLable.font=[UIFont systemFontOfSize:14];
    viewLable.text=@"   相关新闻";
    viewLable.backgroundColor=COLOR;
    return viewLable;
}

-(UIView*)tableViewFoot{
    ZiXunFenLeiModel * md =_newsArray[0];
    UIButton * footBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame=CGRectMake(0, 0, KUAN, 40);
    footBtn.backgroundColor=[UIColor whiteColor];
    [footBtn setTitleColor:[UIColor blackColor] forState:0];
    NSString * ss =[NSString stringWithFormat:@"点击进入[%@]频道",md.newsCname];
    footBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [footBtn setTitle:ss forState:0];
    [footBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    return footBtn;
}
-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//html解析
-(NSAttributedString * )HTML:(NSString*)string1
{
    NSString * htmlString = string1;
    NSAttributedString * attributedString =[[NSAttributedString alloc]initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    return attributedString;
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
