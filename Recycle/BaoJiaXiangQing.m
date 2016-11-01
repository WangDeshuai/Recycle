//
//  BaoJiaXiangQing.m
//  Recycle
//
//  Created by Macx on 16/5/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaoJiaXiangQing.h"
#import "BaoJiaModel.h"

@interface BaoJiaXiangQing ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel * titleLabel;
    UILabel * publicTimeLabel;
    UIView * bgView;
}
@property(nonatomic,retain)UIScrollView * bgScrollview;
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * baojiaArr;
@property(nonatomic,retain)UITableView * tableView;
@end

@implementation BaoJiaXiangQing

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangView];
    _dataArray=[NSMutableArray new];
    _baojiaArr=[NSMutableArray new];
    _bgScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    _bgScrollview.backgroundColor=COLOR;
   // _bgScrollview.contentSize=CGSizeMake(KUAN, GAO+2000);
    [self.view addSubview:_bgScrollview];
   
    [self baojiaXiangQingData];
   
   
}

//报价详情的数据解析
-(void)baojiaXiangQingData{
    //NSLog(@"%@",_messageID);
    [Engine getBaoJiaXiangQing:_messageID success:^(NSDictionary *dic) {
        NSDictionary * dicc =[dic objectForKey:@"Item3"];
        BaoJiaModel * model =[[BaoJiaModel alloc]initWithBaoJiaXiangQing:dicc];
        [_dataArray addObject:model];
        [self titleLabel];
    } error:nil];
}

//相关报价解析
//-(void)xiangGuanData{
//    
//    [Engine getXiangGuanBaoJiapage:@"1" pagesize:@"4" bjclass:@"0" success:^(NSDictionary *dic) {
//        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
//        if ([item1 isEqualToString:@"1"]) {
////            BaoJiaModel
//        }
//    } error:nil];
//    
//}


////html解析
//-(NSAttributedString * )HTML:(NSString*)string1
//{
//    NSString * htmlString = string1;
//    NSAttributedString * attributedString =[[NSAttributedString alloc]initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    
//    return attributedString;
//}

-(void)daohangView
{
    self.view.backgroundColor=COLOR;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:@"报价详情"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItems=@[leftBtn];
    
}
-(void)titleLabel
{
   
    BaoJiaModel * model1 =_dataArray[0];
    titleLabel =[UILabel new];
    titleLabel.textAlignment=1;
    titleLabel.font=[UIFont systemFontOfSize:17];
   titleLabel.text=model1.btitleName;
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
    publicTimeLabel.text=[NSString stringWithFormat:@"发布时间：%@",[Engine  nsdateToTime:model1.bpublicTime]];//model1.zipublicTime;model1.bpublicTime
    [_bgScrollview sd_addSubviews:@[publicTimeLabel]];
    
    publicTimeLabel.sd_layout
    .topSpaceToView(titleLabel,2)
    .centerXEqualToView(_bgScrollview)
    .heightIs(20);
    [publicTimeLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    
    [self contentView:model1];
}
-(void)contentView:(BaoJiaModel*)model1{
    
    bgView =[UIView new];
    bgView.backgroundColor=[UIColor whiteColor];
    [_bgScrollview sd_addSubviews:@[bgView]];
    bgView.sd_layout
    .topSpaceToView(publicTimeLabel,5)
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0);
     //.bottomSpaceToView(_bgScrollview,100);
    
    UILabel * titleLabel1 =[UILabel new];
    titleLabel1.font=[UIFont systemFontOfSize:15];
    titleLabel1.text=@"         中国回收商网(市场部)统计:每日报价更新的时间,下午2点(周六、日停止更新)";
    [bgView sd_addSubviews:@[titleLabel1]];
    titleLabel1.sd_layout
    .topSpaceToView(bgView,10)
    .leftSpaceToView(bgView,10)
    .rightSpaceToView(bgView,10)
    .autoHeightRatio(0);
    
    UIWebView * webView =[[UIWebView alloc]init];
     [webView loadHTMLString:model1.bContent baseURL:nil];
    [bgView sd_addSubviews:@[webView]];
    
    webView.sd_layout
    .topSpaceToView(titleLabel1,0)
    .leftSpaceToView(bgView,0)
    .rightSpaceToView(bgView,0)
    .heightIs(180);//高度成不了动态的，有待调整
    
    
    UILabel * label2 =[UILabel new];
    label2.font=[UIFont systemFontOfSize:15];
    label2.text=@"此内容系来自互联网、不代表回收商网赞成被此内容或立场。\n以上信息均由中国回收商(www.huishoushang.com)收集报道，如有转载，请注明出处，谢谢合作！";
    [bgView sd_addSubviews:@[label2]];
    label2.sd_layout
    .topSpaceToView(webView,15)
    .leftSpaceToView(bgView,10)
    .rightSpaceToView(bgView,10)
    .autoHeightRatio(0);
    
    UILabel * laiyuanLab =[UILabel new];
    laiyuanLab.text=@"来源:中国回收商网";
    laiyuanLab.font=[UIFont systemFontOfSize:13];
    laiyuanLab.alpha=.5;
    laiyuanLab.textAlignment=NSTextAlignmentRight;
    [bgView sd_addSubviews:@[laiyuanLab]];
    laiyuanLab.sd_layout
    .topSpaceToView(label2,10)
    .rightSpaceToView(bgView,5)
    .heightIs(20)
    .leftSpaceToView(bgView,60);//到时候换成宽度自适应
    [bgView setupAutoHeightWithBottomView:laiyuanLab bottomMargin:15];
     [self XiangGuanBaoJiaData];
}


-(void)XiangGuanBaoJiaData{
    //NSLog(@"cidclass=%@",_cidClass);
    if (_cidClass==nil) {
        _cidClass=@"10";
    }
    
    
    [Engine getXiangGuanBaoJiapage:@"1" pagesize:@"3" bjclass:_cidClass success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"])
        {
            if ([dic objectForKey:@"Item3"]==[NSNull null])
            {
                [WINDOW showHUDWithText:@"没有数据" Type:ShowPhotoNo Enabled:YES];
                return ;
            }else{
                NSArray * item3 =[dic objectForKey:@"Item3"];
                for (NSDictionary * dicc in item3)
                {
                    BaoJiaModel * md =[[BaoJiaModel alloc]initWithXiangGuanBaoJia:dicc];
                    [_baojiaArr addObject:md];
                }
            }
        }
        //[self.tableView reloadData];
        [self CreatTableView];
    } error:^(NSError *error) {
        
    }];
}


-(void)CreatTableView{
    self.tableView=[[UITableView alloc]init];//WithFrame:CGRectMake(0, 400, KUAN, GAO) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableHeaderView=[self tableviewHead];
    [_bgScrollview sd_addSubviews:@[self.tableView]];
    _tableView.sd_layout
    .topSpaceToView(bgView,0)
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0)
    .heightIs(44*_baojiaArr.count+40);
    
    __weak __typeof(self)weakSelf = self;
    _tableView.didFinishAutoLayoutBlock=^(CGRect aaa){
        weakSelf.bgScrollview.contentSize=CGSizeMake(KUAN, aaa.origin.y+aaa.size.height+150);
    };
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _baojiaArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 static  NSString * idd =@"Cell";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:idd];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
        UIImageView * image1 =[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 5, 5)];
        image1.tag=1;
        [cell addSubview:image1];
        UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(40, 12, cell.frame.size.width, 20)];
        label.tag=2;
        [cell addSubview:label];
        
    }
    UIImageView * image1 =[cell viewWithTag:1];
    UILabel  * lab =[cell viewWithTag:2];
    BaoJiaModel * md =_baojiaArr[indexPath.row];
    lab.text=md.xtitleName;
    image1.image=[UIImage imageNamed:@"anfor_details_point"];
    lab.font=[UIFont systemFontOfSize:13];
    return cell;
    
}
-(UIView*)tableviewHead{
    BaoJiaModel * md =_baojiaArr[0];
    UILabel * viewLable =[[UILabel alloc]init];
    viewLable.frame=CGRectMake(0, 0, KUAN, 40);
    viewLable.font=[UIFont systemFontOfSize:14];
    viewLable.text=[NSString stringWithFormat:@"      相关%@价格行情",md.xtcName];
    viewLable.backgroundColor=COLOR;
    return viewLable;
}
-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
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
